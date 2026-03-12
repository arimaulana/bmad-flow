You are helping define or evolve the design system for $PROJECT_NAME.

This is project-wide work — not a single screen or feature. Output becomes the foundation
that all future `/design` and implementation work builds on.

---

## Step 1: Understand Scope

Ask if not already clear:
- Is this starting from scratch or evolving an existing system?
- What aspect? (choose one or more)
  - **Full** — color, typography, spacing, components all at once
  - **Color** — palette, semantic tokens, dark mode
  - **Typography** — type scale, font choice, weights, line heights
  - **Spacing** — grid, padding/margin scale, border radius
  - **Components** — component anatomy, states, variants

For each aspect: any reference apps, brand guidelines, or mood words to work from?
(e.g. "calm, minimal, premium" / "playful, energetic" / "serious, trustworthy")

---

## Step 2: Load Existing System

Read if they exist:
1. `design/system/tokens.css` — current design tokens
2. `design/system/guide.md` — component specs and design direction
3. `design/system/colors.md` — color token reference
4. `design/system/preview.html` — existing preview (if iterating)
5. `design/system/components.html` — existing component snippets (if iterating)

If files don't exist yet: this is a greenfield design system — note that.

---

## Step 3: Propose the System

Based on scope and references, propose concretely. Do NOT ask another round of questions
unless something is genuinely blocking — make a well-reasoned proposal and show it.

For each aspect in scope:

### Color
```
Primary:     #XXXXXX — [usage: CTAs, active states]
Secondary:   #XXXXXX — [usage: accents, highlights]
Surface:     #XXXXXX — [usage: cards, sheets]
Background:  #XXXXXX — [usage: base layer]
Text:        #XXXXXX — [usage: primary text]
Text muted:  #XXXXXX — [usage: secondary text, labels]
Success:     #XXXXXX
Warning:     #XXXXXX
Danger:      #XXXXXX
Dark mode equivalents for each
```

### Typography
```
Display:  [font] [weight] [size] / [line-height] — [usage]
H1–H3:    ...
Body:     ...
Caption:  ...
```

### Spacing (4pt or 8pt grid)
```
xs:  4px
sm:  8px
md:  16px
lg:  24px
xl:  40px
gutter: 20px
```

### Components (list, not full spec yet)
```
Proposed components:
- Button (primary / secondary / ghost — 3 sizes — disabled state)
- Card (flat / elevated — tap state)
- [others based on project type]
```

Then ask: "Does this direction resonate? What to adjust before I generate the files?"

---

## Step 4: Generate Artifacts

Only after confirmation. Generate all applicable artifacts.

**Order matters — always generate A before anything else.**

### A. `design/system/preview.html` ← ALWAYS FIRST, ALWAYS REQUIRED

This is the living visual reference for all design tokens. Required for every project regardless of platform (web, iOS, Android, cross-platform). It is the "whiteboard" — the place to visually verify tokens before implementing anywhere.

```html
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="tokens.css">
  <title>Design System — $PROJECT_NAME</title>
</head>
```

Sections:
1. **Color palette** — swatches with token name + hex, light + dark side by side
2. **Typography scale** — each style rendered with sample text
3. **Spacing scale** — visual ruler showing each spacing value
4. **Component gallery** — all components with all states (default, hover, active, disabled)
5. **Dark mode** — full page dark mode toggle (JS `prefers-color-scheme` or button)

Use `tokens.css` variables throughout — never hardcode values.

After generating, start the preview server (if configured) and take a screenshot to confirm it renders correctly.

**Note on platform-native companions:** If the project has a native platform (iOS, Android, etc.), a platform-native component gallery may also be generated *in addition to* `preview.html` — never instead of it. The HTML preview remains the primary cross-platform reference. For iOS: `ComponentGalleryView.swift` (`#if DEBUG`, `#Preview` canvas).

### B. `design/system/tokens.css`

Create or update with all token variables:

```css
:root {
  /* Colors */
  --color-primary: #...;
  --color-primary-hover: #...;
  /* ... all tokens ... */

  /* Typography */
  --font-family-base: '...', sans-serif;
  --font-size-display: 32px;
  /* ... */

  /* Spacing */
  --spacing-xs: 4px;
  /* ... */

  /* Radius */
  --radius-sm: 8px;
  /* ... */

  /* Shadows */
  --shadow-card: 0 2px 8px rgba(0,0,0,0.08);
  /* ... */
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-primary: #...;
    /* dark mode overrides */
  }
}
```

### C. `design/system/colors.md`

Token reference table:

```markdown
# Color Tokens

| Token | Light | Dark | Usage |
|---|---|---|---|
| `--color-primary` | #XXXXXX | #XXXXXX | CTAs, active states |
| ... | | | |
```

### D. `design/system/guide.md`

Component specs — each component gets:
```markdown
## ComponentName

**Variants:** primary / secondary / ghost
**Sizes:** sm / md / lg
**States:** default / hover / active / disabled / loading

**Usage:**
- Use primary for main CTAs (one per screen)
- Use ghost for destructive actions

**Do not:**
- Stack two primary buttons
- Use on colored backgrounds without checking contrast
```

### E. `design/system/components.html`

HTML file containing reusable component snippets as `<template>` tags. The `/design` agent reads this file and copies component HTML into sketches as building blocks.

Each component is a `<template>` with `id="comp-[name]"` and `data-category="[category]"`.

Categories: `navigation`, `form`, `feedback`, `layout`, `data-display`.

Generate components based on the component list proposed in Step 3. Each component should:
- Use CSS variables from `tokens.css` (with fallback values)
- Include all relevant variants (primary/secondary/ghost) as separate templates
- Include states (default, disabled) where applicable
- Use inline styles referencing CSS custom properties for portability

If `components.html` already exists, update it to match new/changed tokens — do not remove components that are still valid.

A starter template exists at `_bmad/expansion-packs/bmad-flow/templates/components.html` — use it as a base if starting fresh.

---

## Step 5: Preview

Start the preview server if configured, or instruct user to open `design/system/preview.html` directly.

Take a screenshot and show it. Ask:
- "Does this capture the direction you had in mind?"
- "Which component should we add to the gallery next?"
- "Ready to move to `/dev` to implement the SwiftUI/code components?"

---

## Step 6: Log the Decision

If significant design direction was set (color palette chosen, type system settled),
note it for `/session-end` to auto-harvest as an ADR — e.g. "Color palette and token system adopted".

This ensures future implementation and design work always references settled decisions, not exploratory choices.

---

## ⛔ Phase Boundary

This command is now complete.

Do NOT automatically proceed to `/design` or any implementation command.
Do NOT start implementing code components — that is a dev task.
Wait for the user to explicitly type the next command.

$ARGUMENTS
