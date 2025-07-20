#!/usr/bin/bash

script_dir="$(dirname "$(readlink -f "$0")")"
source "${script_dir}/variables.sh"

#borg prune -v --list --dry-run -d 7 -w 4 -m 12 $REPOSITORY
borg prune -H 12 -d 7 -w 4 -m 4 $REPOSITORY
