#!/bin/bash
# Holt die gerenderten Beiträge aus render/out und lädt sie hoch.
set -e
cd "$(dirname "$0")"
cp ../render/out/*.jpg ../render/out/*.mp4 . 2>/dev/null || true
git add -A
if git diff --cached --quiet; then
  echo "Keine Änderungen — nichts hochzuladen."
  exit 0
fi
git commit -q -m "Beiträge aktualisiert $(date +%d.%m.%Y)"
git push -q origin main
echo "Hochgeladen. Adressen:"
konto=$(git remote get-url origin | sed -E 's#.*github.com[:/]([^/]+)/([^/.]+).*#\1/\2#')
for f in beitrag-*.jpg; do echo "  https://raw.githubusercontent.com/${konto}/main/${f}"; done
