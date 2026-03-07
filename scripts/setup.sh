#!/bin/bash
# setup.sh — Set up BMAD + bmad-flow in a new project
# Run from your new project root:
#   bash path/to/bmad-flow/scripts/setup.sh
# Or one-liner from scratch:
#   git clone https://github.com/arimaulana/bmad-flow && bash bmad-flow/scripts/setup.sh && rm -rf bmad-flow

set -e

BMAD_FLOW_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ── Ask for project name ──────────────────────────────────────────────────────
echo ""
printf "📝 Project name (e.g. MyApp): "
read -r PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  PROJECT_NAME="My Project"
fi

# ── Install BMAD ──────────────────────────────────────────────────────────────
echo ""
echo "📦 Installing BMAD..."
npx bmad-method install --directory . --tools claude-code --yes

# ── Link bmad-flow ────────────────────────────────────────────────────────────
echo ""
echo "🔗 Linking bmad-flow expansion pack..."
mkdir -p _bmad/expansion-packs
if [ -d "_bmad/expansion-packs/bmad-flow" ]; then
  echo "   bmad-flow already present — skipping clone."
  PACK="_bmad/expansion-packs/bmad-flow"
elif [ "$(basename "$BMAD_FLOW_DIR")" = "bmad-flow" ] && [ -d "$BMAD_FLOW_DIR/.git" ]; then
  # Running from a cloned bmad-flow — copy it into the project
  cp -r "$BMAD_FLOW_DIR" _bmad/expansion-packs/bmad-flow
  echo "   Copied bmad-flow into expansion-packs/"
  PACK="_bmad/expansion-packs/bmad-flow"
else
  git clone https://github.com/arimaulana/bmad-flow _bmad/expansion-packs/bmad-flow
  PACK="_bmad/expansion-packs/bmad-flow"
fi

# ── Context files ─────────────────────────────────────────────────────────────
echo ""
echo "📁 Setting up context files..."
mkdir -p .claude/context .claude/commands .claude/templates docs/decisions docs/brainstorm

for f in current decisions patterns; do
  dest=".claude/context/${f}.md"
  if [ ! -f "$dest" ]; then
    sed "s/\$PROJECT_NAME/$PROJECT_NAME/g" "$PACK/templates/${f}.md" > "$dest"
    echo "   Created $dest"
  else
    echo "   Skipping $dest (already exists)"
  fi
done

# ── SessionStart hook ─────────────────────────────────────────────────────────
if [ ! -f ".claude/settings.json" ]; then
  cp "$PACK/templates/settings.json" ".claude/settings.json"
  echo "   Created .claude/settings.json (SessionStart hook)"
else
  echo "   Skipping .claude/settings.json (already exists)"
fi

# ── devLoadAlwaysFiles (BMAD Dev agent) ───────────────────────────────────────
CORE_CONFIG="_bmad/core/core-config.yaml"
if [ ! -f "$CORE_CONFIG" ]; then
  sed "s/\$PROJECT_NAME/$PROJECT_NAME/g" "$PACK/templates/core-config.yaml" > "$CORE_CONFIG"
  echo "   Created $CORE_CONFIG (devLoadAlwaysFiles)"
else
  echo "   Skipping $CORE_CONFIG (already exists)"
fi

# ── PROJECT.md ────────────────────────────────────────────────────────────────
if [ ! -f "PROJECT.md" ]; then
  sed "s/\$PROJECT_NAME/$PROJECT_NAME/g" "$PACK/templates/project-map.md" > "PROJECT.md"
  echo "   Created PROJECT.md"
fi

# ── Templates ─────────────────────────────────────────────────────────────────
for t in brainstorm-log adr; do
  dest=".claude/templates/${t}.md"
  if [ ! -f "$dest" ]; then
    cp "$PACK/templates/${t}.md" "$dest"
    echo "   Created $dest"
  fi
done

# ── Slash commands ────────────────────────────────────────────────────────────
echo ""
echo "📋 Setting up slash commands..."
for agent in session-start session-end brainstorm design decide sync-check review; do
  dest=".claude/commands/${agent}.md"
  if [ ! -f "$dest" ]; then
    cp "$PACK/agents/${agent}.md" "$dest"
    echo "   Installed /${agent}"
  else
    echo "   Skipping /${agent} (already exists)"
  fi
done

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "✅ Setup complete for: $PROJECT_NAME"
echo ""
echo "Fill in your project context:"
echo "  • .claude/context/CURRENT.md   — active phase + next up"
echo "  • .claude/context/DECISIONS.md — settled decisions"
echo "  • .claude/context/PATTERNS.md  — code patterns"
echo "  • CLAUDE.md                    — project-specific instructions"
echo ""
echo "Start your first session: /session-start"
