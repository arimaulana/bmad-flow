You are helping define or evolve the design system for $PROJECT_NAME.

This is project-wide work — not a single screen or feature. Output becomes the foundation
that all future `/design`, `/brainstorm`, and `/dev` work builds on.

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

Only after confirmation. Generate all applicable artifacts:

### A. `design/system/preview.html`

Full living reference — one file, always up to date:

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

---

## Step 5: Preview

Start the preview server if configured, or instruct user to open `design/system/preview.html` directly.

Take a screenshot and show it. Ask:
- "Does this capture the direction you had in mind?"
- "Which component should we add to the gallery next?"
- "Ready to move to `/dev` to implement the SwiftUI/code components?"

---

## Step 6: Log the Decision

If significant design direction was set (color palette chosen, type system settled), run `/decide`
to formally record it as an ADR — e.g. "Color palette and token system adopted".

This ensures `/dev` and `/brainstorm` always reference settled decisions, not exploratory choices.

---

## ⛔ Phase Boundary

This command is now complete.

Do NOT automatically proceed to `/dev`, `/design`, or any other command.
Do NOT start implementing SwiftUI/code components — that is a `/dev` task.
Wait for the user to explicitly type the next command.

$ARGUMENTS
