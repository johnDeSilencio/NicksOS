#!/usr/bin/env fish

set HOME "/home/nicholas"

set phone_vault_directory "/sdcard/Documents/Pixel"

# Modify this list to add directories in the Vault
set directories \
    "" \
    "templates/" \

set -l options (fish_opt -s h -l help)
set options $options (fish_opt -s n -l dry-run)

argparse $options -- $argv

if set -q _flag_help
    echo "[*] Push Obisidan Vault to Nick's Phone [*]"
    echo ""
    echo "This script uses adb to push Markdown files from the Obsidian vault"
    echo "on my phone. Requires that the phone be plugged into the computer and"
    echo "that the command 'sudo adb attach' has already ran successfully."
    echo ""
    echo "Use the flag '--dry-run' to check if any files would be overwritten"
    echo "to avoid losing data."
    echo ""
    echo "    [-h|--help]     Show this message"
    echo "    [-n|--dry-run]  Don't actually write the phone files to disk"

    exit 0
end

if set -q _flag_dry_run
    set dry_run true
else
    set dry_run false
end

# --- Done parsing arguments ---

cd /home/nicholas/Documents/Zettelkasten/

if $dry_run
    for directory in $directories
        sudo adb push -n $directory*.md "$phone_vault_directory/$directory/"
    end
else
    for directory in $directories
        sudo adb push $directory*.md "$phone_vault_directory/$directory/"
    end
end
