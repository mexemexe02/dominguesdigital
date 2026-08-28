# Cloudflare setup — dominguesdigital.com

Zone is live on Cloudflare (registered/added **2026-08-27**).
GitHub Pages is already built with custom domain `dominguesdigital.com`.
Destination mailbox `hdominguesdigital@gmail.com` is already verified for Email Routing.

What is still missing: **DNS A/CNAME records** and **Email Routing rules**.

---

## 1) DNS → GitHub Pages (do this first)

Dashboard: [DNS records](https://dash.cloudflare.com/e615e29ac0d861c4703096963685984a/dominguesdigital.com/dns/records)

Add these records. Keep **Proxy status = DNS only** (grey cloud) until GitHub finishes HTTPS, then you can turn proxy on if you want.

| Type | Name | Content | Proxy |
|------|------|---------|-------|
| A | `@` | `185.199.108.153` | DNS only |
| A | `@` | `185.199.109.153` | DNS only |
| A | `@` | `185.199.110.153` | DNS only |
| A | `@` | `185.199.111.153` | DNS only |
| AAAA | `@` | `2606:50c0:8000::153` | DNS only |
| AAAA | `@` | `2606:50c0:8001::153` | DNS only |
| AAAA | `@` | `2606:50c0:8002::153` | DNS only |
| AAAA | `@` | `2606:50c0:8003::153` | DNS only |
| CNAME | `www` | `mexemexe02.github.io` | DNS only |

Or run (needs a token with **Zone → DNS → Edit**):

```powershell
.\scripts\setup-cloudflare.ps1
```

### After DNS propagates (usually minutes)

1. Open https://dominguesdigital.com — site should load.
2. In GitHub: repo **Settings → Pages → Custom domain** → wait for DNS check → enable **Enforce HTTPS**.
3. Optional: Cloudflare **SSL/TLS → Overview → Full**, then flip records to Proxied (orange).

---

## 2) Email Routing

Dashboard: [Email Routing](https://dash.cloudflare.com/e615e29ac0d861c4703096963685984a/dominguesdigital.com/email/routing)

1. **Enable** Email Routing for this domain (Cloudflare adds MX + SPF + DKIM).
2. Destination already exists: `hdominguesdigital@gmail.com` (verified).
3. Add custom addresses (same pattern as your other domains):

| Custom address | Forwards to |
|----------------|-------------|
| `hello@dominguesdigital.com` | `hdominguesdigital@gmail.com` |
| `contact@dominguesdigital.com` | `hdominguesdigital@gmail.com` |
| `support@dominguesdigital.com` | `hdominguesdigital@gmail.com` |

4. Send a test to `hello@dominguesdigital.com` and confirm it lands in Gmail.

---

## 3) Optional follow-ups

- [ ] Buy `dominguesdigital.ca` on Cloudflare (~$9/yr) and redirect to `.com` — still available as of purchase day.
- [ ] Google Search Console property for `https://dominguesdigital.com/`
- [ ] Point Google Business Profile website URL to `https://dominguesdigital.com/`
