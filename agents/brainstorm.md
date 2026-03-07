You are helping the user brainstorm and visualize a UI/UX idea for $PROJECT_NAME.

**Never assume. Always ask before generating anything visual.**

---

## Workflow

### Step 1: Explore
Use `AskUserQuestion` to understand what the user has in mind. Ask focused questions such as:
- What screen, feature, or flow are you thinking about?
- What feeling or tone should it convey? (calm / focused / celebratory / minimal / etc.)
- Which user segment is this for?
- Any references or inspiration — other apps, screenshots, sketches?
- Where does this fit in the product? (which section, tab, or flow)

Keep questions concise. 2–3 focused questions is better than a long list.

### Step 2: Restate + Validate
Summarize what you understood from the user's answers. Be specific about:
- The exact screen/component being designed
- The user goal it serves
- The intended feel and tone

Then ask: "Is this what you had in mind?" — wait for confirmation before proceeding.

### Step 3: UI/UX Framing
Connect the idea to:
- Relevant UX patterns (navigation model, interaction paradigm)
- Existing app screens and components (reference the project's `Features/` or equivalent)
- Design direction from `design/system/guide.md` if it exists
- Potential UX risks, edge cases, or tradeoffs worth flagging

Then add **Acceptance Criteria (draft)** if the feature is clear enough:
```
**Acceptance Criteria:**
- Given [context], when [action], then [outcome]
- Given [context], when [action], then [outcome]
```
Skip if still very exploratory — add it once the idea is concrete.

Then confirm: "Does this framing resonate? Any adjustments before I build the sketch?"

### Step 4: Generate + Preview
Only after user validation:

1. Choose a descriptive filename: `[feature]-[variant]-v[n].html`

2. Create `design/sketches/[section]/[filename].html` with:
   ```html
   <link rel="stylesheet" href="../../system/tokens.css">
   ```
   Use `tokens.css` CSS variables throughout — never hardcode hex colors or px values that have token equivalents.

3. Start the preview server if configured, or instruct user to open the file directly.

4. Show the sketch and ask: "Does this capture what you had in mind? What would you like to adjust?"

---

## Rules
- Use design system CSS variables — never hardcode brand colors
- Keep sketches self-contained (single HTML file + shared tokens.css)
- Label sketches clearly — descriptive filenames, easy to identify and delete
- One sketch per idea variant — create `v2`, `v3` for iterations, never overwrite
- If the idea requires understanding existing code, read relevant files first
- Do not generate production code during a brainstorm session — that is a separate task

---

## ⛔ Phase Boundary

This command is now complete.

Do NOT automatically proceed to `/design`, `/decide`, `/task`, or any other command.
Wait for the user to explicitly type the next command.

$ARGUMENTS
