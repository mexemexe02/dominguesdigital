# Development log

## 2026-09-02 — Concept work section + demo subdomain

**Ask:** Show the spec websites we built for local businesses, honestly, and use them as a lead magnet.

**What exists:** Pro Fleet Care (static, 7 pages), Kangen Wellness Center Barrie (static, 8 pages), Total Concept Kitchens (Next.js app with portal + API — needs a server, so screenshot only). NannyB has no site built, only planning docs. Guard Your Space and the Kumon platform were left out (product site / internal).

**Built:**
- `products.html#work` — "Concept work" section, three cards, each with screenshot, `Concept · not yet live` badge, Preview link and "Is this your business? Claim it" mailto. Footnote says names/logos belong to owners and sites come down on request.
- `assets/work/*.jpg` — 1280×800 screenshots, ~75 KB each.
- Home "Websites" service card now links to the section.
- `section[id] { scroll-margin-top }` so anchors clear the sticky header.
- New repo folder `V:\Cursor_Projects\dd-demos` — copies of the two static sites, every page patched with `noindex,nofollow` and a fixed bottom banner ("Concept site by Domingues Digital. Not yet live. Is this your business? Claim it."). `robots.txt` disallows all. `CNAME` = `demo.dominguesdigital.com`.

**Not yet done (approval UI failed):** publish `dd-demos` to GitHub, enable Pages, add Cloudflare CNAME `demo` → `mexemexe02.github.io` (proxied). Until then the Preview links on the two static cards 404. Main-site commit is local only for that reason.

**Kangen card pulled (2026-09-02, later):** a web check found no "Kangen Wellness Center" in Barrie — the brand has locations in London, Hamilton, Toronto, Markham, Mississauga only. The section promises real businesses, so the card is out until Humberto confirms who the site is for. Demo folder still exists in `dd-demos/kangen/` but is unlinked.

**Owner contacts found (public):**
- Pro Fleet Care Simcoe County — Jan Borkowski, `simcoecounty@profleetcare.com`, 705-627-7941 (profleetcare.com/service-providers/simcoe-county)
- Total Concept Kitchens — `totalconceptkitchens@gmail.com`, (705) 309-4443, 438 Dunlop St W, Barrie (from the project's business-profile-source.json)

**Emails not sent:** this environment has no mail-sending tool (Cloudflare Email Routing only forwards inbound). Drafts below are ready to paste into Gmail from hdominguesdigital@gmail.com.

**Permission email (send before publishing):**
> Subject: I built a website for [Business] — can I show it?
>
> Hi [Name], I'm Humberto, I run a Kumon centre in Barrie and a small studio called Domingues Digital. I built a full website concept for [Business] on my own time because I thought you deserved a better one than most local trades have. No charge to look: [demo link]. Two asks: may I show it in my portfolio as a concept, and if you like it, would you want it live on your own domain? If not, say the word and it comes down. — Humberto, (416) 918-0473

## 2026-09-02 — Full site audit (infra + code + visual)

**Infra checked, all healthy:** every page 200; www→apex and http→https 301s; Cloudflare proxy on, SSL Full, Always-HTTPS on; sitemap + robots served; email routing live (hello/contact/support → Gmail). GitHub's own "Enforce HTTPS" cannot be enabled while Cloudflare proxies the domain (GitHub can't issue a cert it never sees) — this is expected; Cloudflare enforces HTTPS at the edge instead.

**Bugs fixed:**
- Sideways scroll at 320px on Home (`.visual__glow` 22rem wide) and Contact (`1fr` grid tracks growing to fit the email address). Fixed with `min(22rem, 88vw)` and `minmax(0, 1fr)`.
- No `404.html` — GitHub Pages served a plain default. Added a branded one with absolute asset paths.
- No `og:image` on any page, so shared links had no preview card. Generated `assets/og-image.png` (1200×630) and added OG/Twitter tags to all pages.
- Founder photo was 2000×1500 / 562 KB for a ~500px slot. Resized to 1200×900 / 279 KB.
- Montserrat font was requested but only referenced inside an `<img>` SVG (unreachable). Removed.
- Home nav "Contact" pointed at the CTA anchor while inner pages pointed at `contact.html`. Unified.
- Mock dashboard showed an invented "↑ 12% this week" stat. Replaced with neutral labels and marked "sample".

**Improvements:** "On-site setup" (the paid service) added to nav; phone number now a tap-to-call link in the header on every page; skip-to-content link; hero animation no longer uses `filter: blur`; sitemap `lastmod` updated.

**Audit method:** Playwright driving Edge at 320/375/390/414/768/1024. Note: raw headless Edge `--window-size` clamps at 510px wide, so its "mobile" screenshots are misleading — use Playwright viewports.

## 2026-09-02 — Custom mark + ship editorial restore

**Ask:** Decide whether to use `V:/repos/react-bits` on this site. Create a real logo. Commit and push so the restored site is live.

**React Bits:** Not used. This site stays static HTML for GitHub Pages and Google Business Profile. The premium-starter note already says the light editorial register is correct here. One CSS-only hero fade is the only motion nod.

**Logo:** Replaced the generic letter-D tile with `assets/dd-mark.svg` — a constructed D with an inner cobalt signal arc. Same mark is the favicon. JSON-LD now points at the mark.

**Verify:** header/footer mark on Home, Products, Contact, On-Site Setup. Favicon in the tab.

## 2026-09-02 — Restore editorial site after Hermes workbench rewrite

**Ask:** Hermes replaced the live site with the warm-workbench variant. Home and Contact no longer matched Products / On-Site Setup. The earlier editorial look should come back.

**Cause:** Commit `0888f32` copied workbench HTML/CSS onto production (`index.html`, `contact.html`, `tokens.css`, `site.css`). `products.html` and `on-site-setup.html` still used the editorial markup, so those pages rendered against the wrong stylesheet.

**Change:** Restored Home, Contact, tokens and `site.css` from `520a4fd` (the professional editorial design). Kept product links opening in a new tab. Added a sticky glass masthead and `aria-current` on the active nav item.

Did **not** convert the site to React. No React folder is in this repo. The site stays static HTML for GitHub Pages and Google Business Profile crawlability.

**Verify locally:** `http://127.0.0.1:8766/` then Products, Contact, On-Site Setup. Home and inner pages should share the same wordmark, fonts and nav.

## 2026-09-02 — Product links open in a new tab

**Ask:** Clicking Schedulo, A10dee, or similar product cards/links was replacing the Domingues Digital page. Visitors should keep this site open so they can come back.

**Change:** Added `target="_blank"` and `rel="noopener noreferrer"` to every Schedulo and A10dee link.

- Live pages: `products.html` (whole product cards), `index.html`, `contact.html`
- Design variants under `variants/` so previews match

In-site links (Products, Contact, On-Site Setup) still open in the same tab.
