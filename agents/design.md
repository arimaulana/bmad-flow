You are generating a UI design sketch for $PROJECT_NAME.

---

## Step 1: Understand the Request

Ask if not already clear:
- What screen or component is this?
- Is it a new idea or an iteration of an existing sketch?
- Any specific interaction, state, or edge case to show?
- Which section of the product does this belong to?

---

## Step 2: Load Design Context

Read if they exist:
1. `design/system/colors.md` — color token reference
2. `design/system/tokens.css` — CSS variables (use these in all HTML)
3. `design/system/guide.md` — component specs, naming conventions, design direction

---

## Step 3: Check Existing Sketches

Read `design/sketches/index.html` to see what already exists.

If iterating on an existing sketch: read that file first. Use `v2`, `v3` etc — never overwrite.

---

## Step 4: Generate HTML Sketch

### Folder structure

Organise sketches by section of the app. Always put the file in the correct subfolder:

```
design/sketches/
  index.html           ← gallery (update this too)
  [section]/           ← one folder per app section
  shared/              ← cross-section components
```

Determine the correct folder from the section the feature belongs to.

### Token path

Files in subfolders are two levels deep — use:
```html
<link rel="stylesheet" href="../../system/tokens.css">
```

### Rules
- Use CSS variables from `tokens.css` — never hardcode hex colors or px values with token equivalents
- Use realistic content — real names, real numbers, real copy (not Lorem Ipsum)
- Include both light and dark mode where relevant (`@media (prefers-color-scheme: dark)`)
- Mobile viewport: 390px width when applicable
- Interactive states where helpful (hover, active, transition)
- One sketch = one idea variant. Create `v2`, `v3` for iterations

### Filename convention

`[feature]-[variant]-v[n].html`

---

## Step 5: Update Index

Add an entry to `design/sketches/index.html` under the correct section:
- Name, date, description
- Status: `Exploring` | `Adopted` | `Discarded`

---

## Step 6: Open Preview

Start the preview server if configured, or instruct user to open the file directly.

Take a screenshot if possible and show it. Ask: "Does this capture what you had in mind? What to adjust?"

---

## Step 7: Log to Brainstorm

If this sketch represents a new idea (not just a UI iteration), create or update a brainstorm log:
- File: `docs/brainstorm/[feature-name].md`
- Use template: `.claude/templates/brainstorm-log.md`
- Link the sketch in the log

---

## ⛔ Phase Boundary

This command is now complete.

Do NOT automatically proceed to any implementation command.
Wait for the user to explicitly type the next command.

$ARGUMENTS
