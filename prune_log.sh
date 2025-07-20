#!/bin/bash
script_dir="$(dirname "$(readlink -f "$0")")"
source "${script_dir}/variables.sh"

find "$BACKUP_LOG_DIR" -name "*.log" -mtime +7 -daystart -delete
