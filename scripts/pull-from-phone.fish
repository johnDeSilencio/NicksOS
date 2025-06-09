#!/usr/bin/env fish

set HOME "/home/nicholas"

set phone_vault_directory "/sdcard/Documents/Pixel"

# Modify this list to add things that should be backed up
set directories \
    "" \
    "templates/" \

set -l options (fish_opt -s h -l help)

argparse $options -- $argv

if set -q _flag_help
    echo "[*] Pull Obisidan Vault from Nick's Phone [*]"
    echo ""
    echo "This script uses adb to pull Markdown files from the Obsidian vault"
    echo "on my phone. Requires that the phone be plugged into the computer and"
    echo "that the command 'sudo adb attach' has already ran successfully."
    echo ""
    echo "    [-h|--help]     Show this message"

    exit 0
end

# --- Done parsing arguments ---

cd /home/nicholas/Documents/Zettelkasten/

for directory in $directories
    set files (sudo adb shell "ls $phone_vault_directory/$directory*.md")

    for file in $files
        sudo adb pull "$file" "./$directory"
    end
end
