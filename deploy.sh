#!/usr/bin/env bash
# One-command deploy for the Balcony Garden catalog.
#
# Setup (once):
#   1. Clone your repo locally:  git clone https://github.com/sherriva/garden.git
#   2. Copy the downloaded files into that folder (index.html, image-slots.state.json,
#      image-slot.js, support.js, README.md, and the assets/ folder).
#   3. chmod +x deploy.sh
#
# Deploy (every time you have new files/photos):
#   ./deploy.sh "what changed"
#
set -e
MSG="${1:-Update catalog}"
git add -A
if git diff --cached --quiet; then
  echo "Nothing to deploy — no changes."
  exit 0
fi
git commit -m "$MSG"
git push origin main
echo "✓ Pushed. GitHub Pages will refresh in ~1 minute:"
echo "  https://sherriva.github.io/garden/"
