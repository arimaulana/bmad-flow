You are wrapping up a Claude Code session for $PROJECT_NAME.

Ask the user these questions in sequence. Wait for each answer before proceeding.

---

## Step 1: What was completed?

Ask: "What was completed or meaningfully progressed this session?"

Record the answer — you'll use it to update docs.

---

## Step 2: Informal decisions?

Ask: "Were any decisions made mid-task without using `/decide`?"

If yes:
- Add a one-line entry to `.claude/context/DECISIONS.md` under the relevant section
- **Only if the decision causes a change to the system** (code, architecture, data model, UI patterns): write the full ADR in `docs/decisions/NNN-name.md` — use template at `.claude/templates/adr.md`. Get the next number by listing `docs/decisions/` and incrementing the highest.
- Purely process or workflow decisions do NOT need an ADR.

---

## Step 3: New assumptions?

Ask: "Did you make any assumptions mid-task that should be formally decided?"

If yes: add to `CURRENT.md` under `## Open Assumptions`:
```
- **Assumption:** [what] | **Context:** [why] | **Should decide?** yes/no
```

---

## Step 4: Drift check

Ask: "Did anything this session deviate from the original plan or contradict the vision/constraints?"

If yes: flag it explicitly and suggest running `/decide` to formalize.

---

## Step 5: Docs freshness check

Ask: "Does `CLAUDE.md` or `PATTERNS.md` need any updates based on today's work?"

If yes: make the update now, or note it in Open Assumptions.

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

### `docs/decisions/` *(only if ADRs were written in Step 2)*
- Confirm ADR file was written and DECISIONS.md one-liner references it with `[→ NNN]`

### `docs/brainstorm/` *(only if new product ideas were explored)*
- If a new feature or product direction was meaningfully discussed, check whether an existing brainstorm file should be updated or a new one created

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
