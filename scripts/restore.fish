#!/usr/bin/env fish

set -l options (fish_opt -s h -l help)
argparse $options -- $argv

if set -q _flag_help
    echo "[*] Restore Script for Nick's OS [*]"
    echo ""
    echo "This script uses rsync to restore files into the current directory"
    echo "on the local host from files that have been backed up by rsync on"
    echo "the remote host."
    echo ""
    echo "    [-h|--help]           Show this message"
    echo "    [FILES | DIRECTORIES] The files / directories you'd like to restore"

    exit 0
end

if test (count $argv) -lt 1
    echo "You must specify at least one file or directory to restore from the remote host"

    exit 1
end

set files_and_directories $argv[..-1]

# Assumes at least one backup exists on the backup server
set -l LAST_BACKUP (ssh nicholas@jerusalem "ls -l /mnt/raid/FRAMEWORK/ | grep -v 'total' | grep -v 'LAST_FULL_BACKUP' | awk '{print \$9}' | tail -1")

# --- Done parsing arguments ---

# First, do a sanity check to make sure that all the paths exist
for file_or_directory in $argv
    # Run our probe
    ssh -q nicholas@jerusalem "ls /mnt/raid/FRAMEWORK/$LAST_BACKUP/$file_or_directory" &>/dev/null

    if test $status -gt 0
        echo "ERROR: \"$file_or_directory\" does not exist on the remote host"
        exit 1
    end
end

# Now that we now that all of the files exist on the remote host,
# sync them to the local host
for file_or_directory in $argv
    rsync \
        --verbose \
        --recursive \
        --relative \
        --compress \
        --log-file=/var/log/rsync.log \
        nicholas@jerusalem:/mnt/raid/FRAMEWORK/"$LAST_BACKUP/./$file_or_directory" .
end
