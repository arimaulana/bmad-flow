#!/bin/bash
# update.sh — Update BMAD core + bmad-flow expansion pack
# Run from your project root: bash _bmad/expansion-packs/bmad-flow/scripts/update.sh

set -e

PACK="_bmad/expansion-packs/bmad-flow"

echo "🔄 Updating BMAD core..."
npx bmad-method install

echo "🔄 Updating bmad-flow..."
cd "$PACK" && git pull origin main && cd - > /dev/null

# ── Sync slash commands ──────────────────────────────────────────────────────
echo ""
echo "📋 Syncing slash commands..."
for agent in session-start session-end design design-system sync-check; do
  src="$PACK/agents/${agent}.md"
  dest=".claude/commands/${agent}.md"
  if [ -f "$src" ]; then
    cp "$src" "$dest"
    echo "   Updated /${agent}"
  fi
done

# ── Sync design scaffolding ─────────────────────────────────────────────────
echo ""
echo "🎨 Syncing design scaffolding..."
mkdir -p design/sketches design/system

if [ ! -f "design/sketches/preview-shell.html" ]; then
  cp "$PACK/templates/preview-shell.html" "design/sketches/preview-shell.html"
  echo "   Created design/sketches/preview-shell.html"
else
  echo "   Skipping preview-shell.html (already exists — update manually if needed)"
fi

if [ ! -f "design/system/components.html" ]; then
  cp "$PACK/templates/components.html" "design/system/components.html"
  echo "   Created design/system/components.html"
else
  echo "   Skipping components.html (already exists — update manually if needed)"
fi

echo ""
echo "✅ Done. BMAD core + bmad-flow are up to date."
