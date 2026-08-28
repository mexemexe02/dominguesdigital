# dominguesdigital.com

Premium light-theme studio site for **2120670 Ontario Inc. o/a Domingues Digital** (Barrie, Ontario).

Its job: be the authoritative website for the Google Business Profile, with NAP
that matches the Ontario Business Registry record exactly, while showing the
real products and operator experience behind the service.

## Stack

Plain server-rendered HTML + CSS. No build step, no framework, no JavaScript.
Hosted on GitHub Pages with a custom apex domain (`CNAME` file).

- `index.html` — home
- `contact.html` — contact
- `on-site-setup.html` — paid On-Site Digital Setup service
- `products.html` — live product portfolio and development-status notes
- `tokens.css` — design tokens and premium light palette
- `site.css` — page styles, imports tokens
- `CNAME` — apex domain for GitHub Pages
- `robots.txt`, `sitemap.xml`
- `.hallmark/log.json` — design provenance

## Deploy

Any push to `main` publishes via GitHub Pages. No CI needed.

## Outstanding

- [x] **Phone number.** (416) 918-0473 — live on both pages and in both
      JSON-LD blocks as +1-416-918-0473.
- [x] **Cloudflare DNS + Email Routing** — A/AAAA + www → GitHub Pages;
      `hello@` / `contact@` / `support@` → `hdominguesdigital@gmail.com`.
- [ ] **Enforce HTTPS** on GitHub Pages (confirm in Settings → Pages).
- [ ] Consider adding real client work/testimonials once there are some.
      Nothing on this site is invented — no fake metrics, no placeholder
      testimonials, no logo wall. Keep it that way.
