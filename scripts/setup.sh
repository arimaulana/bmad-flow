#!/bin/bash
# setup.sh — Set up BMAD + bmad-flow in a new project
# Run from your new project root: bash path/to/bmad-flow/scripts/setup.sh

set -e

BMAD_FLOW_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "📦 Installing BMAD..."
npx bmad-method install

echo "🔗 Linking bmad-flow expansion pack..."
mkdir -p _bmad/expansion-packs
if [ -d "_bmad/expansion-packs/bmad-flow" ]; then
  echo "   bmad-flow already present — skipping clone."
else
  git clone https://github.com/arimaulana/bmad-flow _bmad/expansion-packs/bmad-flow
fi

echo "📁 Setting up context files..."
mkdir -p .claude/context .claude/commands docs/decisions docs/brainstorm

PACK="$BMAD_FLOW_DIR"
[ -d "_bmad/expansion-packs/bmad-flow" ] && PACK="_bmad/expansion-packs/bmad-flow"

for f in current decisions patterns; do
  dest=".claude/context/${f}.md"
  if [ ! -f "$dest" ]; then
    cp "$PACK/templates/${f}.md" "$dest"
    echo "   Created $dest"
  else
    echo "   Skipping $dest (already exists)"
  fi
done

if [ ! -f ".claude/settings.json" ]; then
  cp "$PACK/templates/settings.json" ".claude/settings.json"
  echo "   Created .claude/settings.json (SessionStart hook)"
else
  echo "   Skipping .claude/settings.json (already exists)"
fi

if [ ! -f "PROJECT.md" ]; then
  cp "$PACK/templates/project-map.md" "PROJECT.md"
  echo "   Created PROJECT.md"
fi

mkdir -p .claude/templates
for t in brainstorm-log adr; do
  dest=".claude/templates/${t}.md"
  if [ ! -f "$dest" ]; then
    cp "$PACK/templates/${t}.md" "$dest"
    echo "   Created $dest"
  fi
done

echo "📋 Setting up slash commands..."
mkdir -p .claude/commands
for agent in session-start session-end brainstorm design decide sync-check review; do
  dest=".claude/commands/${agent}.md"
  if [ ! -f "$dest" ]; then
    cp "$PACK/agents/${agent}.md" "$dest"
    echo "   Linked /$(echo $agent | tr '-' '') → $dest"
  else
    echo "   Skipping $dest (already exists)"
  fi
done

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .claude/context/CURRENT.md   — fill in active phase"
echo "  2. Edit .claude/context/DECISIONS.md — add initial decisions"
echo "  3. Edit .claude/context/PATTERNS.md  — add code patterns"
echo "  4. Edit CLAUDE.md                    — add project-specific instructions"
echo "  5. Edit PROJECT.md                   — customize artifact map"
echo "  6. (Optional) Copy templates/core-config.yaml → _bmad/core/core-config.yaml"
echo "     and set devLoadAlwaysFiles for the Dev agent"
echo ""
echo "Start your first session: /session-start"
