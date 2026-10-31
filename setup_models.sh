#!/usr/bin/env bash
# Sürdürülebilir Beslenme Macerası — model boru hattı
# Quaternius OBJ/FBX paketlerini GLB'ye çevirir, draco sıkıştırır, manifest.json üretir.
# Gereksinim: node + npm (npx obj2gltf, npx @gltf-transform/cli)
# Kullanım:  bash setup_models.sh food.zip crops.zip
set -euo pipefail
OUT="$(cd "$(dirname "$0")" && pwd)/models"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

KEYS="apple steak egg milk carrot lentil chickpea beans meat strawberry artichoke watermelon tomato grapes orange spinach cucumber pepper banana kiwi wheat barley broccoli bulgur cheese bread chicken lettuce yogurt"

mkdir -p "$OUT"
for z in "$@"; do
  if command -v unzip >/dev/null; then unzip -q -o "$z" -d "$WORK"; else 7z x -o"$WORK" "$z" >/dev/null; fi
done

M="$OUT/manifest.json"; echo "{" > "$M"; first=1
for key in $KEYS; do
  pat="$key"
  f=$(find "$WORK" -type f \( -iname "*$pat*.obj" -o -iname "*$pat*.glb" -o -iname "*$pat*.gltf" \) | head -1)
  [ -z "$f" ] && continue
  if [[ "$f" == *.glb ]]; then
    cp "$f" "$OUT/$key.glb"
  else
    ( cd "$(dirname "$f")" && npx --yes obj2gltf -i "$(basename "$f")" -o "$OUT/$key.glb" >/dev/null 2>&1 || true )
  fi
  [ -f "$OUT/$key.glb" ] || continue
  npx --yes @gltf-transform/cli draco "$OUT/$key.glb" "$OUT/$key.glb" >/dev/null 2>&1 || true
  if [ $first -eq 1 ]; then first=0; else echo "," >> "$M"; fi
  printf '  "%s": "assets/models/%s.glb"' "$key" "$key" >> "$M"
  echo "  -> $key.glb"
done
echo "" >> "$M"; echo "}" >> "$M"
echo "manifest.json üretildi: $M"
