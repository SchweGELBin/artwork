#!/usr/bin/env nix-shell
#!nix-shell -p bash imagemagick -i bash

file=$1
name="${file%.svg}"

if [ -z "$file" ]; then
  echo "Usage: $0 path/to/file.svg"
  exit 1
fi

if [ ! -f "$file" ]; then
    echo "File not found: $file"
    exit 1
fi

declare -A sizes
sizes=(
  ["1920x1080"]="1920 1080"
  ["2560x1440"]="2560 1440"
  ["3440x1440"]="3440 1440"
)

for label in "${!sizes[@]}"; do
  read -r width height <<< "${sizes[$label]}"


  output="${name}_${label}.png"
  magick -density 300 "$file" -resize "${width}x${height}^" -gravity center -extent "${width}x${height}" "$output"

  echo "Generated: $output"
done
