#!/bin/bash

# Compare bashrc scripts in git with bashrc scripts in ~/.bashrc.d, and warn
# of differences between two scripts with the same filename

# Copyright (c)2013 by Brian Manning (brian at xaoc dot org)
# License terms are listed at the bottom of this file
#
# Impotant URLs:
# Clone:    https://github.com/spicyjack/jenkins-config.git
# Issues:   https://github.com/spicyjack/jenkins-config/issues

### MAIN SCRIPT ###
# what's my name?
SCRIPTNAME=$(basename $0)
# path to the perl binary

# verbose script output by default
QUIET=0

# verbose script output by default
DRY_RUN=0

# default exit status
EXIT_STATUS=0

# path to ~/.bashrc.d
BASHRCD_PATH="~/.bashrc.d"
### SCRIPT SETUP ###
# source jenkins functions
source ~/src/public.git/scripts/common_functions.sh

GETOPT_SHORT="hqns:"
GETOPT_LONG="help,quiet,dry-run,source:"
# sets GETOPT_TEMP
# pass in $@ unquoted so it expands, and run_getopt() will then quote it "$@"
# when it goes to re-parse script arguments
run_getopt "$GETOPT_SHORT" "$GETOPT_LONG" $@

show_help () {
cat <<-EOF

    ${SCRIPTNAME} [options]

    SCRIPT OPTIONS
    -h|--help       Displays this help message
    -q|--quiet      No script output (unless an error occurs)
    -n|--dry-run    Explain what would be done, don't actually do it

    Example usage:
    ${SCRIPTNAME} --dry-run -- ~/src/path1.git ~/src/path2.git
    ${SCRIPTNAME} --source -- ~/src/path1.git ~/src/path2.git
EOF
}

# Note the quotes around `$GETOPT_TEMP': they are essential!
# read in the $GETOPT_TEMP variable
eval set -- "$GETOPT_TEMP"

# read in command line options and set appropriate environment variables
while true ; do
    case "$1" in
        # show the script options
        -h|--help)
            show_help
            exit 0;;
        # don't output anything (unless there's an error)
        -q|--quiet)
            QUIET=1
            shift;;
        # don't actually do anything
        -n|--dry-run)
            DRY_RUN=1
            shift;;
        # Source path(s)
        #-s|--source)
        #    REPO_SOURCE_PATHS="$2";
        #    shift 2;;
        # separator between options and arguments
        --)
            shift;
            break;;
        # we shouldn't get here; die gracefully
        *)
            warn "ERROR: unknown option '$1'"
            warn "ERROR: use --help to see all script options"
            exit 1
            ;;
    esac
done

if [ "x$REPO_SOURCE_PATHS" = "x" ]; then
    warn "ERROR: Please pass a source path to bashrc.d repos (--source)"
    exit 1
fi

### SCRIPT MAIN LOOP ###
show_script_header
info "Checking for differences in '~/.bashrc.d' files"
CONFIGS_DIFF_COUNT=0
SOURCE_PATHS=$(echo $REPO_SOURCE_PATHS | sed 's/:/ /')
info "Searching for scripts in ${SOURCE_PATHS}"
TOTAL_BASHRC_SCRIPTS=$(/bin/ls -1 ~/.bashrc.d/* | wc -l)
info "Total scripts found in ~/.bashrc.d: ${TOTAL_BASHRC_SCRIPTS}"
for BASHRC_SCRIPT_FULLPATH in ~/.bashrc.d/*
do
    BASHRC_SCRIPT=$(basename ${BASHRC_SCRIPT_FULLPATH})
    for SOURCE_PATH in ${SOURCE_PATHS}
    do
        info "Checking for ${BASHRC_SCRIPT} in ${SOURCE_PATH}"
        if [ -f ${SOURCE_PATH}/${BASHRC_SCRIPT} ]; then
            info "Found ${BASHRC_SCRIPT} in ${SOURCE_PATH}"
        fi
#        diff --brief "${JENKINS_CFG}" "${TARGET_FILE}" 1>/dev/null 2>&1
#    DIFF_STATUS=$?
#    if [ $DIFF_STATUS -gt 0 ]; then
#        CONFIGS_COPIED=$((${CONFIGS_COPIED} + 1))
#        echo $CONFIGS_COPIED > $BACKUP_JENKINS_STATEFILE
#        if [ $DRY_RUN -eq 0 ]; then
#            say "- Has changes: $JENKINS_CFG"
#            /bin/cp --force --verbose "$JENKINS_CFG" "$TARGET_FILE"
#            EXIT_STATUS=$?
#        else
#            echo "  Would have copied: $JENKINS_CFG"
#        fi
#    fi
    done
done

if [ $EXIT_STATUS -gt 0 ]; then
    warn "ERROR: ${SCRIPTNAME} completed with errors"
fi

exit $EXIT_STATUS

#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; version 2 dated June, 1991.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program;  if not, write to the Free Software
#   Foundation, Inc.,
#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

# vi: set filetype=sh shiftwidth=4 tabstop=4
# end of line