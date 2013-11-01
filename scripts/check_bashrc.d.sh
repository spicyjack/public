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

# execute script and modify files by default
DRY_RUN=0

# colorize? yes please (1=yes, colorize, 0=no, don't colorize)
COLORIZE=1

# default exit status
EXIT_STATUS=0

# path to ~/.bashrc.d
BASHRCD_PATH="~/.bashrc.d"
### SCRIPT SETUP ###
# source jenkins functions
source ~/src/public.git/scripts/common_functions.sh

GETOPT_SHORT="hqv"
GETOPT_LONG="help,quiet,view"
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
    -v|--view       View 'diff' of bashrc.d files in your \$EDITOR

    Example usage:
    # view diffs of bashrc.d files when diffs are found
    ${SCRIPTNAME} --view -- ~/src/path1.git ~/src/path2.git

    # don't view diffs of bashrc.d files, just show what's different
    ${SCRIPTNAME} -- ~/src/path1.git ~/src/path2.git
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
        -v|--view)
            VIEW_DIFFS=1
            shift;;
        # separator between options and arguments
        # note that arguments in this case is one or more repos with bashrc.d
        # scripts
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

if [ $# -eq 0 ]; then
    warn "ERROR: Please pass paths to bashrc.d directories after '--'"
    show_help
    exit 1
fi

### SCRIPT MAIN LOOP ###
show_script_header
info "Checking for differences in '~/.bashrc.d' files"
CONFIGS_DIFF_COUNT=0
SOURCE_PATHS=""
while [ $# -gt 0 ];
do
    DASH_PATH=$1
    if [ -d "${DASH_PATH}" ]; then
        info "Found valid path: ${DASH_PATH}"
        SOURCE_PATHS="${SOURCE_PATHS} ${DASH_PATH}"
    else
        warn "WARNING: ${DASH_PATH} not found"
        EXIT_STATUS=1
    fi
    # pop the file off of the arg stack
    shift
done
info "Searching for scripts in ${SOURCE_PATHS}"
TOTAL_BASHRC_SCRIPTS=$(/bin/ls -1 ~/.bashrc.d/* | wc -l)
BASHRC_MATCHED_COUNTER=0
DIFF_FILES=0
info "Total scripts found in ~/.bashrc.d: ${TOTAL_BASHRC_SCRIPTS}"
for BASHRC_SCRIPT_FULLPATH in ~/.bashrc.d/*
do
    BASHRC_SCRIPT=$(basename ${BASHRC_SCRIPT_FULLPATH})
    FOUND_FLAG=0
    for SOURCE_PATH in ${SOURCE_PATHS}
    do
        SOURCE_PATH=$(echo ${SOURCE_PATH} | sed 's!/$!!')
        #info "Checking for ${BASHRC_SCRIPT} in ${SOURCE_PATH}"
        if [ $FOUND_FLAG -eq 0 -a -f ${SOURCE_PATH}/${BASHRC_SCRIPT} ]; then
            #info "Found ${BASHRC_SCRIPT} in ${SOURCE_PATH}"
            FOUND_FLAG=1
            BASHRC_MATCHED_COUNTER=$((BASHRC_MATCHED_COUNTER + 1))
            diff --brief "${BASHRC_SCRIPT_FULLPATH}" \
                "${SOURCE_PATH}/${BASHRC_SCRIPT}" \
                1>/dev/null 2>&1
            DIFF_STATUS=$?
            if [ $DIFF_STATUS -gt 0 ]; then
                DIFF_FILES=$((${DIFF_FILES} + 1))
                say "- Found difference in script '${BASHRC_SCRIPT}';"
                echo "  bashrc.d script: ${BASHRC_SCRIPT_FULLPATH}"
                echo "  repo script: ${SOURCE_PATH}/${BASHRC_SCRIPT}"
            fi
        fi
    done
    if [ $FOUND_FLAG -eq 0 ]; then
        warn "- No match for bashrc script '${BASHRC_SCRIPT}'"
    fi
done
info "Total scripts found in ~/.bashrc.d: ${TOTAL_BASHRC_SCRIPTS}"
info "Total scripts matched in repos: ${BASHRC_MATCHED_COUNTER}"
info "Total bashrc.d scripts different from repo copies: ${DIFF_FILES}"

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
