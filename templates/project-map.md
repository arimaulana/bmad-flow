# Project Map — $PROJECT_NAME

Quick reference for where to find things.

---

## Where to Look

| Mau tahu apa? | File |
|---|---|
| Lagi ngerjain apa? | `.claude/context/CURRENT.md` |
| Feature backlog? | `_bmad-output/epics/` |
| Story aktif? | `_bmad-output/stories/US-NNN.md` |
| Requirements formal? | `_bmad-output/prd.md` |
| Keputusan teknis (digest)? | `.claude/context/DECISIONS.md` |
| ADR lengkap? | `docs/decisions/NNN-name.md` |
| Desain sistem? | `_bmad-output/architecture.md` |
| Code patterns? | `.claude/context/PATTERNS.md` |
| Sketch UI? | `design/sketches/` |
| Brainstorm log? | `docs/brainstorm/` |
| Changelog? | `CHANGELOG.md` |

---

## Agent → Output Map

| Agent | Output |
|---|---|
| `/session-start` | Briefing (no file output) |
| `/session-end` | CURRENT.md, CHANGELOG.md, DECISIONS.md |
| `/brainstorm` | `design/sketches/`, `docs/brainstorm/` |
| `/design` | `design/sketches/`, `docs/brainstorm/` |
| `/decide` | `docs/decisions/NNN.md`, DECISIONS.md |
| `/sync-check` | Report (no file output) |
| `/review` | Report (no file output) |
| `/pm` | `_bmad-output/prd.md`, stories/ |
| `/architect` | `_bmad-output/architecture.md` |
| `/dev` | Source code |
| `/qa` | Test plan, acceptance validation |

---

## Update Cadence

| File | Updated by | When |
|---|---|---|
| `CURRENT.md` | `/session-end` | Every session |
| `DECISIONS.md` | `/decide`, `/session-end` | When decisions are made |
| `CHANGELOG.md` | `/session-end` | When code or decisions change |
| `docs/decisions/` | `/decide` | When formal decision is made |
| `design/sketches/` | `/brainstorm`, `/design` | During design exploration |
