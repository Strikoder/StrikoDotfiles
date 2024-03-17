#!/bin/bash

# Define the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$screenshot_dir"

# Filename for the screenshot
filename="screenshot_$(date +%Y-%m-%d-%H%M%S).png"

# Full path for the screenshot file
filepath="$screenshot_dir/$filename"

# Geometry of the main monitor (replace with your monitor's geometry)
geometry="1920x1080+0+0"

# Use slop to select a region and maim to take a screenshot
selection=$(slop -f "%g")
if [ -z "$selection" ]; then
    # If no selection is made, capture the entire screen and copy to clipboard
    maim -g "$geometry" | tee "$filepath" | xclip -selection clipboard -t image/png
else
    # If a selection is made, capture the selected area and copy to clipboard
    maim -g "$selection" | tee "$filepath" | xclip -selection clipboard -t image/png
fi

# Notify the user
notify-send "Screenshot taken" "Saved as $filename and copied to clipboard"

