# Balcony Garden — Visual Catalog 2026

An interactive, image-first planting catalog for a container / balcony garden,
covering **July → December 2026**. It continues the visual language of the
original July & August Figma frames: white-on-warm-paper, Signika type, purple
section headings, borderless square photo cards laid out five-up.

The whole app is a single self-contained page — open `Garden Catalog 2026.dc.html`
in any modern browser. No build step, no server.

---

## Contents

| File | Purpose |
|------|---------|
| `Garden Catalog 2026.dc.html` | The entire app — markup, styling, and logic. |
| `image-slot.js` | Web component powering every drag-and-drop photo slot. |
| `support.js` | Runtime that renders the Design Component (loaded by the HTML). |
| `.image-slots.state.json` | Saved photos (one entry per plant). Travels with the project. |
| `assets/*.png` | Plant photos imported from the original Figma file. |

---

## Features

- **Six months**, July–December 2026, each with its own planting periods.
- **Real photos** for ~17 plants pulled from the source Figma file; every other
  card is a fillable placeholder.
- **Month-jump nav** with live plant counts and a scroll-spy that highlights the
  month you're currently viewing.
- **Focus mode** — a full-screen viewer that steps through every plant one at a
  time (arrow buttons, ← / → keys, swipe, Esc to close).
- **Filter box** — dims cards whose name doesn't match your query.
- **Edit mode** — rename plants / headings / months, add or remove plants and
  whole planting periods, and reset to the original catalog.
- **Photos keyed by plant, not position** — upload a plant once and it appears in
  every month that plant occurs; edits never knock a photo off its plant.

---

## Design system / CSS

All styling is inline on the elements (the Design Component pattern). The tokens
below are the source of truth.

### Color

| Token | Value | Used for |
|-------|-------|----------|
| Canvas | `#f4f3ef` | Page background (warm paper) |
| Ink | `#22212a` | Body text |
| Accent | `#5a4f8a` | Section headings, active nav, tags, focus states |
| Card name | `#2a2933` | Plant labels |
| Eyebrow | `#9a97b0` | Season label above each month |
| Photo frame | `#eae8e3` | Empty photo-card background |
| Danger | `#c25b5b` | Delete / reset actions |

The accent is also exposed as a **tweakable prop** (`accent`) — change it once and
every heading, tag, active nav pill and count chip recolors together.

### Type

- **Signika** (Google Fonts, weights 400/500/600/700) throughout.
- Month title `42px / 600`, letter-spacing `-0.5px`.
- Season eyebrow `13px / 500`, uppercase, letter-spacing `0.14em`.
- Section heading `19px / 600` in accent purple, preceded by a small rotated square.
- Plant name `14.5px / 500`.
- Tags `11.5px / 600`; process & note lines `13–13.5px`.

### Layout

- Content column max-width `1280px`, side padding `34px`.
- Photo grid: `repeat(N, minmax(0, 1fr))` where **N = `columns` prop (default 5,
  range 3–6)**; gaps `34px` (row) × `28px` (column).
- Space between a section heading and its photos: **`14px`**.
- Space above each month block: `64px`.
- Photo cards: `1 / 1` aspect ratio, `16px` corner radius, no border; soft shadow
  that deepens and lifts (`translateY(-6px)`) on hover.
- Sticky header height `70px`, frosted (`backdrop-filter: blur(14px)`).

### Tweakable props

| Prop | Editor | Default | Notes |
|------|--------|---------|-------|
| `accent` | color | `#5a4f8a` | Global accent color |
| `columns` | int (3–6) | `5` | Photos per row |

---

## States

| State | Trigger | Behavior |
|-------|---------|----------|
| **Browse** (default) | — | Read the catalog; hover a photo to lift it and reveal View / Replace. |
| **Edit** | "✎ Edit" in header | Inline inputs for month/section/plant names; add / remove plants and planting periods; reset button appears. |
| **Focus / viewer** | "⤢ Focus" in header, or ⤢ on any card | Full-screen single-plant viewer with prev/next, keyboard, swipe, and position counter. |
| **Filter** | Type in "Filter plants…" | Non-matching cards fade to 20% opacity. |
| **Scroll-spy** | Scrolling | The month nearest the top is highlighted in the nav. |

### Persistence

- **Catalog text/structure** → `localStorage` (key `balcony-garden-catalog-v2`).
- **Photos** → `.image-slots.state.json`, keyed by a plant slug
  (e.g. `p-lettuce-little-gem`). Because photos are keyed by plant, the same photo
  shows on that plant in every month, and it survives edits, reordering, and this
  repo being cloned or deployed elsewhere.

---

## Happy paths

**Add or replace a plant's photo**
1. Hover the card → click **Replace** (top-right) — or drag an image file onto the slot.
2. Pick a photo. It saves under the plant's name and appears on that plant in every month.

**Browse photos one by one**
1. Click **⤢ Focus** (header) or the ⤢ on any card.
2. Use the on-screen arrows, ← / → keys, or swipe. Esc closes.

**Jump to a month**
1. Click a month in the nav. The page smooth-scrolls to it; the active month stays highlighted as you scroll.

**Edit the catalog**
1. Click **✎ Edit**.
2. Rename anything inline; use **+ Add plant** / **+ Add planting period**; remove
   with the × / "Remove section" controls.
3. Click **✓ Done**. Everything is saved automatically; **Reset catalog to original**
   restores the seed (your uploaded photos are kept).

---

## Deploying

This is a static site. To publish with **GitHub Pages**:

1. Push these files to the repo (root).
2. Settings → Pages → Build from branch → `main` / root.
3. Visit `https://<user>.github.io/<repo>/Garden%20Catalog%202026.dc.html`.

(Optionally rename the entry file to `index.html` so the site opens at the repo root.)
