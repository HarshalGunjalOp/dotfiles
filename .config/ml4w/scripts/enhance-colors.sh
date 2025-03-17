#!/bin/bash

# Path to pywal's colors.json
COLORS_FILE="${HOME}/.cache/wal/colors.json"
BACKUP_FILE="${HOME}/.cache/wal/colors.json.backup"

# Create a backup
cp "$COLORS_FILE" "$BACKUP_FILE"

# Read the colors file
COLORS=$(cat "$COLORS_FILE")

# Function to increase saturation and brightness of a hex color
vibrantify() {
    python3 -c "
import colorsys
import sys

hex_color = sys.argv[1].lstrip('#')
r, g, b = tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))
h, s, v = colorsys.rgb_to_hsv(r/255, g/255, b/255)

# Increase saturation and brightness
s = min(s * 1.35, 1.0)  # Increase saturation by 35%
v = min(v * 1.25, 1.0)  # Increase brightness by 25%

r, g, b = colorsys.hsv_to_rgb(h, s, v)
r, g, b = int(r * 255), int(g * 255), int(b * 255)

print(f'#{r:02x}{g:02x}{b:02x}')
    " "$1"
}

# Process the colors
for i in {0..15}; do
    COLOR=$(echo "$COLORS" | jq -r ".colors.color$i")
    VIBRANT_COLOR=$(vibrantify "$COLOR")
    COLORS=$(echo "$COLORS" | jq ".colors.color$i = \"$VIBRANT_COLOR\"")
done

# Write the updated colors back to the file
echo "$COLORS" > "$COLORS_FILE"

# Update the sequences file to include the new colors
wal -q --theme "$COLORS_FILE"
