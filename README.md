# dominguesdigital.com

Static site for **2120670 Ontario Inc. o/a Domingues Digital** (Barrie, Ontario).

Its job: be the authoritative website for the Google Business Profile, with NAP
that matches the Ontario Business Registry record exactly.

## Stack

Plain server-rendered HTML + CSS. No build step, no framework, no JavaScript.
Hosted on GitHub Pages with a custom apex domain (`CNAME` file).

- `index.html` — home
- `contact.html` — contact
- `tokens.css` — design tokens (OKLCH colour, 4pt space scale, type scale)
- `site.css` — page styles, imports tokens
- `CNAME` — apex domain for GitHub Pages
- `robots.txt`, `sitemap.xml`
- `.hallmark/log.json` — design provenance

## Deploy

Any push to `main` publishes via GitHub Pages. No CI needed.

## Outstanding

- [ ] **Phone number.** Deliberately absent. A dedicated business line is needed
      (cannot reuse the Kumon centre number — already bound to that Google
      profile). Once it exists, add it in three places: `index.html` contact
      section, `contact.html` details list, and `telephone` in both JSON-LD
      blocks. The site and the Google profile should gain the number together.
- [ ] **Email forwarding** for `hello@dominguesdigital.com` — set up at the
      registrar or via Cloudflare Email Routing (free) before announcing the site.
- [ ] Consider adding real client work/testimonials once there are some.
      Nothing on this site is invented — no fake metrics, no placeholder
      testimonials, no logo wall. Keep it that way.
