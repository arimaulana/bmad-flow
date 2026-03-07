You are reviewing recently changed code for $PROJECT_NAME.

Inspired by Super Claude's /sc:review. This command reports issues — it does NOT auto-fix anything.

---

## Step 1: Identify What to Review

Ask if not already clear:
- Which files were changed? (or run `git diff --name-only HEAD` to find them)
- Is this a full review or a focused check? (e.g. "just check patterns compliance")

Then read every changed file in full.

---

## Step 2: Load Review Standards

Read in parallel:
1. `.claude/context/PATTERNS.md` — code patterns that must be followed exactly
2. `.claude/context/DECISIONS.md` — settled decisions that must not be contradicted
3. `CLAUDE.md` → "Hard Constraints" and "Naming Conventions" sections

---

## Step 3: Run Checks

For each changed file, check:

### Patterns Compliance
- Does code follow every rule in PATTERNS.md?
- Are naming conventions correct? (file names, type names, variable names)
- Are state management patterns correct? (@Observable, @State, @Binding, etc.)
- Are concurrency patterns correct? (async/await, @MainActor, no data races)
- Are any deprecated APIs used when a modern equivalent is available?

### Decisions Compliance
- Does any change contradict a settled decision in DECISIONS.md?
- Does any new type, model, or field conflict with the data model spec in CLAUDE.md?

### Scope Creep
- Are there changes outside what was asked for?
- Any "while I'm here" fixes, refactors, or additions that weren't requested?

### General Quality
- Any bare `print()` calls not wrapped in `#if DEBUG`?
- Any hardcoded strings that should use constants?
- Any TODO/FIXME comments left in?
- Any obvious logic errors or missing edge case handling?

---

## Step 4: Report Findings

Print a structured report:

```
## Review Report — [date]

### Files Reviewed
- [filename] — [brief description of changes]

### Issues Found

**🔴 Must Fix (violates PATTERNS.md or DECISIONS.md)**
- [file:line] — [issue] → [what it should be]

**⚠️ Should Fix (quality / best practice)**
- [file:line] — [issue] → [suggestion]

**ℹ️ Notice (scope / style)**
- [file:line] — [observation]

### Summary
[N] must-fix, [N] should-fix, [N] notices.
[Overall assessment: Ready to commit / Needs fixes / Major issues]
```

If no issues found:
```
✅ No issues found. Code looks clean and follows all patterns.
```

---

## ⛔ Phase Boundary

This command is now complete. Do NOT auto-fix any issues.

Report only — wait for the user to decide what to do with the findings.

$ARGUMENTS
