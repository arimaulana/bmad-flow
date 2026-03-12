You are wrapping up a Claude Code session for $PROJECT_NAME.

**Do NOT ask the user to summarize the session.** You have full access to the conversation history.
Analyze it yourself, present your findings, and ask the user only to confirm or correct.

---

## Step 1–5: Analyze session (do this silently, then present)

Review the full conversation and determine:

1. **Completed** — what was finished or meaningfully progressed
2. **Informal decisions** — choices made mid-task (look for "let's use X", "we'll go with Y", option selections, settled preferences, approach confirmations)
3. **New assumptions** — things assumed but not formally decided
4. **Drift** — anything that deviated from the original plan or contradicted CLAUDE.md constraints
5. **Docs freshness** — does CLAUDE.md or PATTERNS.md need updating based on this session's work
6. **BMAD doc impact** — did any discussion touch on requirements, architecture, UX, or business logic that would make existing BMAD output docs stale?

Then present a concise summary to the user:

```
Here's what I found from this session:

**Completed:** [list]

**Decisions to record as ADR:**
- [decision] — [one-line summary]
- ...
(or "none")

**Assumptions to track:** [list or "none"]

**Drift:** [flagged items or "none"]

**Docs to update:** [list or "none"]

**BMAD docs potentially stale:**
- [doc name] — [why, based on what was discussed]
  -> run /[bmad-command-to-re-run]
(or "none")

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
- Mark completed items: `[checkmark] Item — done YYYY-MM-DD`

### `CHANGELOG.md` *(if code or decisions changed)*
- Append entry at the top:
```
## [Phase/Feature — short description] — YYYY-MM-DD
### Added / Changed / Fixed / Decisions
- [one line per item]
```

### `docs/decisions/` *(if decisions were identified in Step 1–5)*

For each decision identified and confirmed by the user:

1. Determine the next ADR number: read `docs/decisions/` directory to find the highest existing number
2. Create `docs/decisions/NNN-[slug].md` using the template at `_bmad/expansion-packs/bmad-flow/templates/adr.md`
   - `NNN` = next number (zero-padded to 3 digits)
   - `[slug]` = kebab-case short name
3. Update `.claude/context/DECISIONS.md`:
   - Add one-line entry under the appropriate section
   - Format: `- **[topic]** -> [decision in one sentence]. [-> NNN]`
   - Run `date "+%Y-%m-%d %H:%M"` via Bash, then update `_Last synced_` to that value

### `docs/brainstorm/` *(only if new product ideas were explored)*
- Update existing brainstorm file or create a new one if a new feature direction was meaningfully discussed

---

## Step 7: BMAD Stale Doc Reminder

If Step 1–5 identified BMAD docs that may be stale, print a clear reminder:

```
## BMAD Docs to Re-run

The following BMAD output docs may be outdated based on this session's discussions.
Re-run the corresponding BMAD workflow to update them properly.

| Stale Doc | Reason | Command to Re-run |
|---|---|---|
| PRD | [what changed] | /bmad-bmm-edit-prd |
| Architecture | [what changed] | /bmad-bmm-create-architecture |
| UX Design | [what changed] | /bmad-bmm-create-ux-design |
| Epics | [what changed] | /bmad-bmm-create-epics-and-stories |
```

Only show rows for docs that are actually affected. If no BMAD docs are stale, skip this step entirely.

---

## Step 8: Branch reminder

If code was written and not yet committed, remind:
- "Commit your changes: `git add -p && git commit -m 'feat: [description]'`"
- "If on a feature branch: merge to main when ready"

---

## Done

Print:
> Session wrapped. Updated: [list every file actually changed this session]
> Next session: `/session-start`

---

## Phase Boundary

This command is now complete. Do NOT automatically proceed to any other command.

$ARGUMENTS
