# Sets DNS (GitHub Pages) + Email Routing for dominguesdigital.com.
# Requires: Cloudflare API token with Zone.DNS Edit + Email Routing Edit.
# Usage:  $env:CLOUDFLARE_API_TOKEN = "..."; .\scripts\setup-cloudflare.ps1
# Fallback: CF_API_TOKEN is also accepted.

$ErrorActionPreference = "Stop"

$token = $env:CLOUDFLARE_API_TOKEN
if (-not $token) { $token = $env:CF_API_TOKEN }
if (-not $token) { throw "Set CLOUDFLARE_API_TOKEN (or CF_API_TOKEN) first." }

$zoneName = "dominguesdigital.com"
$githubIo = "mexemexe02.github.io"
$forwardTo = "hdominguesdigital@gmail.com"
$headers = @{
  Authorization = "Bearer $token"
  "Content-Type" = "application/json"
}

# --- Zone ---
$zones = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones?name=$zoneName" -Headers $headers
if (-not $zones.result) { throw "Zone $zoneName not found." }
$zoneId = $zones.result[0].id
Write-Host "Zone $zoneName -> $zoneId"

function Ensure-DnsRecord {
  param(
    [string]$Type,
    [string]$Name,
    [string]$Content,
    [bool]$Proxied = $false
  )
  # List matching records (name is FQDN in API responses)
  $fqdn = if ($Name -eq "@") { $zoneName } else { "$Name.$zoneName" }
  $list = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records?type=$Type&name=$fqdn&content=$([uri]::EscapeDataString($Content))" -Headers $headers
  if ($list.result.Count -gt 0) {
    Write-Host "OK exists: $Type $Name -> $Content"
    return
  }
  $body = @{
    type    = $Type
    name    = $Name
    content = $Content
    ttl     = 1
    proxied = $Proxied
  } | ConvertTo-Json
  $created = Invoke-RestMethod -Method Post -Uri "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records" -Headers $headers -Body $body
  if (-not $created.success) { throw ($created | ConvertTo-Json -Depth 6) }
  Write-Host "CREATED: $Type $Name -> $Content"
}

# GitHub Pages IPv4
@(
  "185.199.108.153",
  "185.199.109.153",
  "185.199.110.153",
  "185.199.111.153"
) | ForEach-Object { Ensure-DnsRecord -Type "A" -Name "@" -Content $_ }

# GitHub Pages IPv6
@(
  "2606:50c0:8000::153",
  "2606:50c0:8001::153",
  "2606:50c0:8002::153",
  "2606:50c0:8003::153"
) | ForEach-Object { Ensure-DnsRecord -Type "AAAA" -Name "@" -Content $_ }

Ensure-DnsRecord -Type "CNAME" -Name "www" -Content $githubIo

# --- Email Routing enable + rules ---
# Enable routing (creates MX/SPF/DKIM when allowed)
try {
  $enable = Invoke-RestMethod -Method Post -Uri "https://api.cloudflare.com/client/v4/zones/$zoneId/email/routing/enable" -Headers $headers -Body "{}"
  Write-Host "Email Routing enable: success=$($enable.success)"
} catch {
  Write-Host "Email Routing enable note: $($_.ErrorDetails.Message)"
}

# Custom addresses -> verified destination
$aliases = @("hello", "contact", "support")
foreach ($local in $aliases) {
  $rulesUri = "https://api.cloudflare.com/client/v4/zones/$zoneId/email/routing/rules"
  $existing = Invoke-RestMethod -Uri $rulesUri -Headers $headers
  $matchers = $existing.result | Where-Object {
    $_.matchers | Where-Object { $_.type -eq "literal" -and $_.value -eq "$local@$zoneName" }
  }
  if ($matchers) {
    Write-Host "OK rule exists: $local@$zoneName"
    continue
  }
  $ruleBody = @{
    name    = "Forward $local"
    enabled = $true
    matchers = @(@{ type = "literal"; field = "to"; value = "$local@$zoneName" })
    actions  = @(@{ type = "forward"; value = @($forwardTo) })
  } | ConvertTo-Json -Depth 5
  $createdRule = Invoke-RestMethod -Method Post -Uri $rulesUri -Headers $headers -Body $ruleBody
  if (-not $createdRule.success) { throw ($createdRule | ConvertTo-Json -Depth 6) }
  Write-Host "CREATED rule: $local@$zoneName -> $forwardTo"
}

Write-Host ""
Write-Host "Done. Next:"
Write-Host "  1) Open https://$zoneName"
Write-Host "  2) GitHub Pages → Enforce HTTPS"
Write-Host "  3) Email a test to hello@$zoneName"
