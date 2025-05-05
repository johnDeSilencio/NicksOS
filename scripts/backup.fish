#!/usr/bin/env fish

set -l options (fish_opt -s f -l full)
set options $options (fish_opt -s i -l incremental)
set options $options (fish_opt -s h -l help)

argparse $options -- $argv

if set -q _flag_help
    echo "[*] Backup Script for Nick's OS [*]"
    echo ""
    echo "This script uses rsync to send files to a directory on a remote host."
    echo "A 'full' backup refers to an exact copy of the chosen files from this"
    echo "local host. An 'incremental' backup uniquely includes either new files"
    echo "or modified files with hardlinks to the most recent full backup. Full"
    echo "backups should be performed at least once a month to reduce disk usage."
    echo ""
    echo "    [-h|--help]        Show this message"
    echo "    [-f|--full]        Perform a full backup"
    echo "    [-i|--incremental] Perform an incremental backup"

    exit 0
end

if set -q _flag_full
    set full true
else
    set full false
end

if set -q _flag_incremental
    set incremental true
else
    set incremental false
end

if $full; and $incremental
    echo "Backup can be of only one type, incremental or full"
    exit 1
end

if not $full; and not $incremental
    echo "You must specify what type of backup to perform, incremental or full"
    exit 1
end

# --- Done parsing arguments ---

cd /home/nicholas

set HOME "/home/nicholas"

# Modify this list to add things that should be backed up
set files_and_directories \
    "$HOME/Desktop/" \
    "$HOME/Documents/" \
    "$HOME/Pictures/"

set -l CURRENT_DATE (date +%Y%m%d)

if $full
    set -l CURRENT_DATE (date +%Y%m%d)
    
    rsync \
        --archive \
        --verbose \
        --recursive \
        --relative \
        --compress \
        # Use each directories .gitignore to ignore the stuff we don't care about
        --filter=":- .gitignore" \
        # Ignore all .git/ directories
        --exclude=".git/" \
        # File where rsync logs go on the local host
        --log-file=/var/log/rsync.log \
        # Enumerated list of what is being backed up on the local host
        $files_and_directories \
        nicholas@jerusalem:/mnt/raid/FRAMEWORK/"$CURRENT_DATE"/

    # Mark this backup as a full backup (all other backups are incremental)
    ssh nicholas@jerusalem "touch /mnt/raid/FRAMEWORK/$CURRENT_DATE/FULL_BACKUP"

    # Update the date of the last full backup
    ssh nicholas@jerusalem "echo $CURRENT_DATE > /mnt/raid/FRAMEWORK/LAST_FULL_BACKUP"

    exit 0
end

if $incremental
    # Find the date of the last full backup 
    set -l LAST_FULL_BACKUP (ssh nicholas@jerusalem cat /mnt/raid/FRAMEWORK/LAST_FULL_BACKUP)

    rsync \
        --archive \
        --verbose \
        --recursive \
        --relative \
        --compress \
        # Use each directories .gitignore to ignore the stuff we don't care about
        --filter=":- .gitignore" \
        # Ignore all .git/ directories
        --exclude=".git/" \
        # File where rsync logs go on the local host
        --log-file=/var/log/rsync.log \
        # Enumerated list of what is being backed up on the local host
        $files_and_directories \
        # If files have been deleted locally, delete them in the incremental backup
        --delete \
        # The last full backup that the local files will be diff'ed against
        --link-dest=/mnt/raid/FRAMEWORK/"$LAST_FULL_BACKUP"/ \
        nicholas@jerusalem:/mnt/raid/FRAMEWORK/"$CURRENT_DATE"/

    exit 0
end
