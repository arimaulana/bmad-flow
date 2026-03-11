# Project Map — $PROJECT_NAME

Quick reference for where to find things.

---

## Where to Look

| Looking for... | File |
|---|---|
| Current state? | `.claude/context/CURRENT.md` |
| Feature backlog? | `BACKLOG.md` |
| Sprint status? | `_bmad-output/implementation-artifacts/sprint-status.yaml` |
| Story files? | `_bmad-output/implementation-artifacts/*.md` |
| Requirements (PRD)? | `_bmad-output/planning-artifacts/prd.md` |
| Architecture? | `_bmad-output/planning-artifacts/architecture.md` |
| Epics & stories? | `_bmad-output/planning-artifacts/epics.md` |
| Technical decisions (digest)? | `.claude/context/DECISIONS.md` |
| ADR full text? | `docs/decisions/NNN-name.md` |
| Code patterns? | `.claude/context/PATTERNS.md` |
| UI sketches? | `design/sketches/` |
| Brainstorm logs? | `docs/brainstorm/` |
| Changelog? | `CHANGELOG.md` |

---

## Command → Output Map

| Command | Output |
|---|---|
| `/session-start` | Briefing (no file output) |
| `/session-end` | CURRENT.md, CHANGELOG.md, DECISIONS.md, docs/decisions/ |
| `/bmad-brainstorming` | `docs/brainstorm/` |
| `/design` | `design/sketches/`, `design/sketches/index.html` |
| `/design-system` | `design/system/tokens.css`, `design/system/preview.html` |
| `/bmad-bmm-create-story` | `_bmad-output/implementation-artifacts/` story file |
| `/bmad-bmm-dev-story` | Source code, tests, story file updated |
| `/bmad-bmm-code-review` | Story file updated, code fixes |
| `/bmad-bmm-quick-spec` | Quick tech spec |
| `/bmad-bmm-quick-dev` | Source code |
| `/sync-check` | Report (no file output) |

---

## Update Cadence

| File | Updated by | When |
|---|---|---|
| `CURRENT.md` | `/session-end` | Every session |
| `DECISIONS.md` | `/session-end` | When decisions are made (auto-harvested) |
| `CHANGELOG.md` | `/session-end` | When code or decisions change |
| `docs/decisions/` | `/session-end` | When formal decision is made |
| `design/sketches/` | `/design` | During design exploration |
