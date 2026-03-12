You are starting a new Claude Code session for $PROJECT_NAME.

## Default Mode

Load context in this order:
1. Read `.claude/context/CURRENT.md` — current phase, in-progress, next steps
2. Read `.claude/context/DECISIONS.md` — settled decisions (never relitigate these)
3. Read `.claude/context/PATTERNS.md` — code patterns to follow

Then print this briefing:

---

## Session Briefing — $PROJECT_NAME

**Active Phase:** [from CURRENT.md]
**Last verified:** [date from CURRENT.md]

**In Progress:**
[list from CURRENT.md ## In Progress — skip section if empty]

**Next Up:**
[top 2–3 items from CURRENT.md ## Next Up]

**Active Task Journal:**
[show content if any multi-session task is running; skip if empty]

**Watch out for:**
[list any Open Assumptions or Pending Decisions from CURRENT.md; skip if empty]

**Suggested focus:**
[1–3 concrete things to work on today, based on In Progress + Next Up]

---

Then ask: "What do you want to work on?"

---

## Modes

Append a flag to change loading depth:

- `quick` — read CURRENT.md only, print a one-paragraph summary
- `full` — also read `CLAUDE.md` hard constraints + `docs/brainstorm/vision.md`
- `hook` — print instructions for setting up a SessionStart hook that auto-loads DECISIONS.md and PATTERNS.md on every conversation (not just `/session-start`). Show the user this JSON to add to `.claude/settings.json`:
  ```json
  {
    "hooks": {
      "SessionStart": [
        {
          "matcher": "",
          "hooks": [
            {
              "type": "command",
              "command": "[ -f .claude/context/DECISIONS.md ] && echo '=== DECISIONS ===' && cat .claude/context/DECISIONS.md; [ -f .claude/context/PATTERNS.md ] && echo '=== PATTERNS ===' && cat .claude/context/PATTERNS.md; true"
            }
          ]
        }
      ]
    }
  }
  ```
  Explain that with this hook, DECISIONS.md and PATTERNS.md will be injected into every session automatically — useful if the user frequently works outside of `/session-start`.

Default (no flag) = standard mode above.

---

## Context Rot Check

If `last_verified` in CURRENT.md is more than 7 days ago, add a warning:

> ⚠️ CURRENT.md was last verified [N] days ago. Consider running `/session-end` to refresh it after this session.

---

## ⛔ Phase Boundary

Do NOT automatically proceed to any command after the briefing.
Wait for the user to explicitly say what they want to work on.

$ARGUMENTS
