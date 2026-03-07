You are wrapping up a Claude Code session for $PROJECT_NAME.

**Do NOT ask the user to summarize the session.** You have full access to the conversation history.
Analyze it yourself, present your findings, and ask the user only to confirm or correct.

---

## Step 1–5: Analyze session (do this silently, then present)

Review the full conversation and determine:

1. **Completed** — what was finished or meaningfully progressed
2. **Informal decisions** — choices made mid-task without `/decide` (look for "let's use X", "we'll go with Y", option selections, approach confirmations)
3. **New assumptions** — things assumed but not formally decided
4. **Drift** — anything that deviated from the original plan or contradicted CLAUDE.md constraints
5. **Docs freshness** — does CLAUDE.md or PATTERNS.md need updating based on this session's work

Then present a concise summary to the user:

```
Here's what I found from this session:

**Completed:** [list]

**Informal decisions that need logging:**
- [decision] → needs ADR? yes/no
- ...

**Assumptions to track:** [list or "none"]

**Drift:** [flagged items or "none"]

**Docs to update:** [list or "none"]

Confirm to proceed, or correct anything above.
```

Wait for user confirmation before executing Step 6.

If the user says "iya", "yes", "go ahead", or similar — proceed directly with all updates.

---

## Step 6: Update docs

Execute all applicable updates. Skip only if there is genuinely nothing new.

### `.claude/context/CURRENT.md` *(always)*
- Move completed items from `## In Progress` to `## Last Completed`
- Update `## Next Up` based on session results
- Run `date "+%Y-%m-%d %H:%M"` via Bash to get the current datetime, then update `last_verified`
- Update `## Active Task Journal` if a multi-session task is ongoing
- Clear resolved assumptions from `## Open Assumptions`

### `BACKLOG.md` *(if items were completed)*
- Mark completed items: `✅ Item — done YYYY-MM-DD`

### `CHANGELOG.md` *(if code or decisions changed)*
- Append entry at the top:
```
## [Phase/Feature — short description] — YYYY-MM-DD
### Added / Changed / Fixed / Decisions
- [one line per item]
```

### `docs/decisions/` *(only if ADRs were written)*
- Write ADR file and add one-liner to DECISIONS.md with `[→ NNN]`

### `docs/brainstorm/` *(only if new product ideas were explored)*
- Update existing brainstorm file or create a new one if a new feature direction was meaningfully discussed

---

## Step 7: Branch reminder

If code was written and not yet committed, remind:
- "Commit your changes: `git add -p && git commit -m 'feat: [description]'`"
- "If on a feature branch: merge to main when ready"

---

## Done

Print:
> Session wrapped. Updated: [list every file actually changed this session]
> Next session: `/session-start`

---

## ⛔ Phase Boundary

This command is now complete. Do NOT automatically proceed to any other command.

$ARGUMENTS
