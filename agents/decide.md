You are helping make a formal decision for $PROJECT_NAME.

---

## Step 1: Check If Already Decided

Read `.claude/context/DECISIONS.md` first.

If the decision is already there: show the user the existing entry and ask "This is already settled — do you want to revisit it?" Do not proceed unless they confirm.

---

## Step 2: Understand the Question

Ask the user to clarify (if not already clear):
- What is the specific decision to be made?
- What are the constraints? (timeline, performance, user experience, platform)
- Is there a direction already in mind, or is this fully open?

---

## Step 3: Load Relevant Context

Read based on decision type:
- **Architecture decision** → `CLAUDE.md` hard constraints + relevant source files
- **Product/UX decision** → `docs/brainstorm/vision.md` + `CLAUDE.md` domain concepts
- **Data model decision** → `CLAUDE.md` data models section + relevant model files
- **UI decision** → `design/system/guide.md` + design system files

---

## Step 4: Present Options

For each option (2–4 max):

```
### Option A: [Name]
**What it is:** [one sentence]
**Pros:**
-
**Cons:**
-
**Fits with:** [existing decisions it aligns with]
**Conflicts with:** [existing decisions it would contradict, if any]
```

End with:
> **Recommendation:** Option [X] because [1–2 specific reasons grounded in this project's constraints]

---

## Step 5: Wait for Decision

Do not write any files until the user confirms which option.

---

## Step 6: Write ADR

Determine the next ADR number: read `docs/decisions/` directory to find the highest existing number.

Create `docs/decisions/NNN-[slug].md` using the template at `.claude/templates/adr.md`.
- `NNN` = next number (zero-padded to 3 digits)
- `[slug]` = kebab-case short name (e.g. `audio-as-variant`)

---

## Step 7: Update Digest (mandatory)

Update `.claude/context/DECISIONS.md`:
1. Add one-line entry under the appropriate section
2. Format: `- **[topic]** → [decision in one sentence]. [→ NNN]`
3. Run `date "+%Y-%m-%d %H:%M"` via Bash and update `_Last synced_`

---

## Step 8: Confirm

Print:
```
Decision recorded:
- ADR: docs/decisions/NNN-[slug].md
- Digest: .claude/context/DECISIONS.md updated
```

---

## ⛔ Phase Boundary

This command is now complete.

Do NOT automatically proceed to any other command.
Wait for the user to explicitly type the next command.

$ARGUMENTS
