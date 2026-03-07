#!/bin/bash
# update.sh — Update BMAD core + bmad-flow expansion pack
# Run from your project root: bash _bmad/expansion-packs/bmad-flow/scripts/update.sh

set -e

echo "🔄 Updating BMAD core..."
npx bmad-method install

echo "🔄 Updating bmad-flow..."
cd _bmad/expansion-packs/bmad-flow && git pull origin main && cd -

echo "✅ Done. BMAD core + bmad-flow are up to date."
