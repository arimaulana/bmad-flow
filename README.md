# bmad-flow

A BMAD expansion pack that adds session lifecycle management, brainstorming,
UI/UX sketch generation, formal decision tracking (ADR), and code review to
your BMAD workflow.

## What's Included

| Agent | Command | Purpose |
|---|---|---|
| `session-start` | `/session-start` | Load context, print session briefing |
| `session-end` | `/session-end` | Wrap up session, update all docs |
| `brainstorm` | `/brainstorm` | Explore UI/UX ideas, generate HTML sketches |
| `design` | `/design` | Generate standalone HTML sketch for one feature |
| `design-system` | `/design-system` | Define or evolve the project-wide design system |
| `decide` | `/decide` | Formal decision → ADR |
| `sync-check` | `/sync-check` | Check context file staleness |
| `review` | `/review` | Review changed code against patterns & decisions |

## Requirements

- [BMAD](https://github.com/bmad-code-org/BMAD-METHOD) installed (`npx bmad-method install`)
- Node.js 20+

## Setup (New Project)

```bash
# 1. Install BMAD
npx bmad-method install

# 2. Clone bmad-flow
git clone https://github.com/arimaulana/bmad-flow _bmad/expansion-packs/bmad-flow

# 3. Run setup script
bash _bmad/expansion-packs/bmad-flow/scripts/setup.sh
```

The setup script will:
- Copy context file templates (CURRENT.md, DECISIONS.md, PATTERNS.md)
- Install the SessionStart hook (`.claude/settings.json`)
- Copy slash commands to `.claude/commands/`
- Create `PROJECT.md` artifact map

Then fill in your project-specific content in the context files and `CLAUDE.md`.

## Context Injection

bmad-flow uses two mechanisms to inject project context into all agents — no agent overrides needed:

**1. Claude Code SessionStart hook** (all agents)
Automatically loads `DECISIONS.md` + `PATTERNS.md` at the start of every session.

**2. BMAD `devLoadAlwaysFiles`** (Dev agent only)
Copy `templates/core-config.yaml` to `_bmad/core/core-config.yaml` and set:
```yaml
devLoadAlwaysFiles:
  - .claude/context/DECISIONS.md
  - .claude/context/PATTERNS.md
```

## Update

```bash
# From your project root
bash _bmad/expansion-packs/bmad-flow/scripts/update.sh
```

Or manually:
```bash
npx bmad-method install                                      # Update BMAD core
cd _bmad/expansion-packs/bmad-flow && git pull origin main  # Update bmad-flow
```

## Daily Workflow

```
/session-start          ← load context, get briefing

  Idea exploration:
    /brainstorm → /design → /decide → /dev

  Design system:
    /design-system (full or incremental — color, type, spacing, components)

  Quick task:
    /dev (or /task via BMAD)

  Architecture:
    /decide (single question) or /architect (BMAD, full design)

  Code review:
    /review

/session-end            ← update all docs
```

## Artifact Map

| Want to know | File |
|---|---|
| What's in progress? | `.claude/context/CURRENT.md` |
| Settled decisions? | `.claude/context/DECISIONS.md` |
| Full ADR? | `docs/decisions/NNN-name.md` |
| Code patterns? | `.claude/context/PATTERNS.md` |
| UI sketches? | `design/sketches/` |
| Brainstorm logs? | `docs/brainstorm/` |
| BMAD stories? | `_bmad-output/stories/` |
| BMAD architecture? | `_bmad-output/architecture.md` |

## License

MIT

---

*Built with AI assistance.*
