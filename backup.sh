#!/usr/bin/bash

# Set up some variables
script_dir="$(dirname "$(readlink -f "$0")")"
source "${script_dir}/variables.sh"
TIMESTAMP=$(date "+%Y%m%dT%H%M")
LOG="${BACKUP_LOG_DIR}/borgbackup_${TIMESTAMP}.log"


# Write logfile
exec > >(tee -i "${LOG}")
exec 2>&1
echo "###### Starting backup on $(date) ######"

# Create list of installed software
dpkg --get-selections > "${BACKUP_LOG_DIR}/software.list"

# Create list of installed vscode extensions
jq -r '.[] | .identifier.id' ~/.vscode-server/extensions/extensions.json > "${BACKUP_LOG_DIR}/vscode-server-extensions.list"
code --list-extensions > "${BACKUP_LOG_DIR}/vscode-extensions.list"

# Sync backup data
echo "Syncing backup files ..."
borg create -v --stats                                  \
    $REPOSITORY::'{now:%Y%m%d-%H%M}'                    \
    $BACKUP_PATH                                               

echo "###### Finished backup on $(date) ######"
