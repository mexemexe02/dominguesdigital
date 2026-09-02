# Development log

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
