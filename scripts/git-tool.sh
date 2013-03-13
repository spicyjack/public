#!/bin/bash

# git-tool.sh
# - manage multiple git repos quicker and easier than doing it by hand ;)

# Script can be obtained from:
# https://github.com/spicyjack/public/blob/master/scripts/git-tool.sh

# Copyright (c)2013 Brian Manning <brian at xaoc dot org>
# License: GPL v2 (see licence blurb at the bottom of the file)
# Get support and more info about this script at:
# https://github.com/spicyjack/public/issues

# - get a list of directories
# - filter the list for directories to exclude, and exclude those dirs
# - loop over the left-over directories
# - for each directory;
#   - if the directory ends in *.git, then enter it, and run the command
#   - if the directory does not end in *.git, push it to a stack, or enter it
#   and process it's contents

# what's my name?
SCRIPTNAME=$(basename $0)
# path to the perl binary

# set quiet mode by default, needs to be set prior to the getops call
QUIET=0

# colorize? yes please (0=yes, colorize, 1=no, don't colorize)
NO_COLORIZE=0

# global variable for measuring how many directories deep we currently are
RECURSION_DEPTH=0

### OUTPUT COLORIZATION VARIABLES ###
START="["
END="m"

# text attributes
NONE=0; BOLD=1; NORM=2; BLINK=5; INVERSE=7; CONCEALED=8

# background colors
B_BLK=40; B_RED=41; B_GRN=42; B_YLW=43
B_BLU=44; B_MAG=45; B_CYN=46; B_WHT=47

# foreground colors
F_BLK=30; F_RED=31; F_GRN=32; F_YLW=33
F_BLU=34; F_MAG=35; F_CYN=36; F_WHT=37

# some shortcuts
MSG_FAIL="${BOLD};${F_YLW};${B_RED}"
MSG_DRYRUN="${BOLD};${F_CYN};${B_BLU}"
MSG_OK="${BOLD};${F_WHT};${B_GRN}"
MSG_INFO="${BOLD};${F_WHI};${B_BLU}"
MSG_FLUFF="${BOLD};${F_BLU};${B_BLK}"

### FUNCTIONS ###
# wrap text inside of ANSI tags, unless --nocolor is set
colorize () {
    local COLOR="$1"
    local TEXT="$2"

    if [ $NO_COLORIZE -eq 0 ]; then
        COLORIZE_OUT="${COLORIZE_OUT}${START}${COLOR}${END}${TEXT}"
        COLORIZE_OUT="${COLORIZE_OUT}${START};${NONE}${END}"
    else
        COLORIZE_OUT="${COLORIZE_OUT}${TEXT}"
    fi
}

# clear the COLORIZE_OUT variable
colorize_clear () {
    COLORIZE_OUT=""
}

# check the exit status of a sub-process that was run
check_exit_status() {
    local ERROR=$1
    local CMD_RUN="$2"
    local CMD_OUT="$3"

    # check for errors from the script
    if [ $ERROR -ne 0 ] ; then
        if [ $QUIET -eq 0 ]; then
            colorize $MSG_FAIL "${CMD_RUN} exited with error: $ERROR"
            echo $COLORIZE_OUT
            colorize $MSG_FAIL "${CMD_RUN} output: "
            echo $COLORIZE_OUT
            echo $CMD_OUT
        fi
        SCRIPT_EXIT=1
#    else
#        if [ $QUIET -eq 0 ]; then
#            colorize $MSG_OK "${CMD_RUN} exited with no errors"
#            echo $COLORIZE_OUT
#            colorize $MSG_INFO "${CMD_RUN} output:"
#            echo $COLORIZE_OUT
#            echo $CMD_OUT
#        fi
#        SCRIPT_EXIT=0
    fi
} # check_exit_status

# recurse a path, looking for directories to either run git commands in, or to
# enter to look for more directories
recurse_path() {
    local RECURSE_PATH=$1
    find $RECURSE_PATH -maxdepth 1 -type d -name "[a-zA-Z0-9_]*" -exec
    for ENTRY in $(/bin/ls -1 $RECURSE_PATH);
    do
        if [ $(stat -f "%HT" "${RECURSE_PATH}/${ENTRY}" \
                | grep -c "Directory" ) -gt 0 ];
        then
            echo "$ENTRY is a directory"
        fi
    done
}

rungitcmd() {
    local GIT_CMD=$1
    local GIT_SUCCESS_PATTERN=$2

    if [ $GIT_DEBUG -gt 0 ]; then echo "command: ${GIT_CMD}"; fi
    GIT_OUTPUT=$(${GIT_CMD} 2>&1)
    if [ $(echo $GIT_OUTPUT | grep -c "${GIT_SUCCESS_PATTERN}") -ne 1 ]; then
        echo $GIT_OUTPUT
    fi
}

# check the status in git directories
gitstat() {
    local EXCLUDE_DIRS=$1
    GIT_DEBUG=0
    unset GIT_CMD
    if [ $# -gt 0 ]; then GIT_DEBUG=1; echo "GIT_DEBUG set to ${GIT_DEBUG}"; fi
    START_DIR=$PWD
    cd $SOURCE_DIR
    echo "=== Running 'git status' in ${SOURCE_DIR} ==="
    for DIR in $(/bin/ls | grep 'git$');
    do
        if [ $(echo ${DIR} | egrep -c "${EXCLUDE_DIRS}") -gt 0 ]; then
            continue
        fi
        echo "- $DIR";
        cd $DIR
        IFS=$' \t'
        git status --short
        IFS=$' \t\n'
        cd $SOURCE_DIR
    done
    cd $START_DIR
} # gitstat


# git pull in all git directories
gitpullall() {
    GIT_DEBUG=0
    unset GIT_CMD
    if [ $# -gt 0 ]; then GIT_DEBUG=1; echo "GIT_DEBUG set to ${GIT_DEBUG}"; fi
    set_git_source_dir
    START_DIR=$PWD
    cd $SOURCE_DIR
    for DIR in $(/bin/ls | grep 'git$');
    do
        echo "=== git pull: $DIR ===";
        cd $DIR
        IFS=$' \t'
        GIT_CMD="git pull --all"
        GIT_SUCCESS_PATTERN="Already up-to-date."
        rungitcmd "$GIT_CMD" "$GIT_SUCCESS_PATTERN"
        IFS=$' \t\n'
        cd $SOURCE_DIR
    done
    cd $START_DIR
    set_git_source_dir
} # gitpullall

# git pull in all git directories
gitupdatechk() {
    local CHECK_DATE=$1

    if [ -z $CHECK_DATE ]; then
        echo "ERROR: need a date to check; date format is YYYY-MM-DD"
    else
        GIT_DEBUG=0
        unset GIT_CMD
        set_git_source_dir
        START_DIR=$PWD
        cd $SOURCE_DIR
        for DIR in $(/bin/ls | grep 'git$');
        do
            echo "=== git log: $DIR ===";
            cd $DIR
            GIT_FORMAT="%h %cd %an %s"
            IFS=$' \t'
            GIT_OUTPUT=$(git log --pretty=format:"${GIT_FORMAT}" \
                --after="${CHECK_DATE}" | cut -c -80)
            if [ -n "$GIT_OUTPUT" ]; then
                echo $GIT_OUTPUT
            fi
            IFS=$' \t\n'
            cd $SOURCE_DIR
        done
        cd $START_DIR
    fi
    unset_git_source_dir
} # gitupdatechk


# check for inbound changes to git directories
gitinchk() {
    GIT_DEBUG=0
    unset GIT_CMD
    if [ $# -gt 0 ]; then GIT_DEBUG=1; echo "GIT_DEBUG set to ${GIT_DEBUG}"; fi
    set_git_source_dir
    START_DIR=$PWD
    cd $SOURCE_DIR
    for DIR in $(/bin/ls | grep git);
    do
        echo "=== git pull --dry-run $DIR ===";
        cd $DIR
        IFS=$' \t'
        GIT_CMD="git pull --dry-run"
        GIT_SUCCESS_PATTERN="Already up-to-date."
        rungitcmd "$GIT_CMD" "$GIT_SUCCESS_PATTERN"
        IFS=$' \t\n'
        cd $SOURCE_DIR
    done
    cd $START_DIR
    unset_git_source_dir
} # gitinchk

# check for outbound changes in git directories
gitoutchk() {
    GIT_DEBUG=0
    unset GIT_CMD
    if [ $# -gt 0 ]; then GIT_DEBUG=1; echo "GIT_DEBUG set to ${GIT_DEBUG}"; fi
    set_git_source_dir
    START_DIR=$PWD
    cd $SOURCE_DIR
    for DIR in $(/bin/ls | grep git);
    do
        echo "=== git push --dry-run $DIR ===";
        cd $DIR
        IFS=$' \t'
        GIT_CMD="git push --dry-run"
        GIT_SUCCESS_PATTERN="Everything up-to-date"
        rungitcmd "$GIT_CMD" "$GIT_SUCCESS_PATTERN"
        IFS=$' \t\n'
        cd $SOURCE_DIR
    done
    cd $START_DIR
    unset_git_source_dir
} # gitoutchk

# check for outbound changes in git directories
gitrefchk() {
    GIT_DEBUG=0
    unset GIT_CMD
    if [ $# -gt 0 ]; then GIT_DEBUG=1; echo "GIT_DEBUG set to ${GIT_DEBUG}"; fi
    set_git_source_dir
    START_DIR=$PWD
    cd $SOURCE_DIR
    for DIR in $(/bin/ls | grep git);
    do
        echo "=== git status $DIR ===";
        cd $DIR
        IFS=$' \t'
        GIT_CMD="git status"
        GIT_SUCCESS_PATTERN="branch is ahead"
        if [ $GIT_DEBUG -gt 0 ]; then echo "command: ${GIT_CMD}"; fi
        GIT_OUTPUT=$(${GIT_CMD} 2>&1)
        if [ $(echo $GIT_OUTPUT | grep -c "${GIT_SUCCESS_PATTERN}") -eq 1 ];
        then
            echo $GIT_OUTPUT
        fi
        IFS=$' \t\n'
        cd $SOURCE_DIR
    done
    cd $START_DIR
    unset_git_source_dir
} # gitrefchk


show_examples() {
# show script usage examples
cat <<-EOE

==== ${SCRIPTNAME} Examples ====

  # run on all *.git dirs in /path/to/src/tree,
  # exclude /path/to/tree/dirA, /path/to/src/tree/dirB
  ${SCRIPTNAME} --path=/path/to/src/tree --exclude="dirA|dirB"

EOE

}

show_help() {
# show script options
cat <<-EOH

${SCRIPTNAME} [options] <command>

    GENERAL SCRIPT OPTIONS
    -h|--help       Displays this help message
    -e|--examples   Show examples of script usage
    -q|--quiet      No script output (unless an error occurs)
    -n|--dry-run    Explain what will be done, don't actually do it
    -c|--nocolor    Don't use colorized status messages (good for scripting)

    OPTIONS FOR DIRECTORY PATHS
    -p|--path       Starting path for searching for Git repos
    -e|--exclude    Exclude these paths from the search

    COMMANDS
    stat            Run 'git status --short' in all repos found
    pullall         Run 'git pull' in all repos found
    refchk          Run 'git status', can show files not synced with remote
    outchk          Run 'git push --dry-run'; shows commits needing pushing
    inchk           Run 'git pull --dry-run'; shows commits needing pulling
    updatechk       Shows all repos that have been updated since YYYY-MM-DD

NOTE: Long switches (GNU extension) do not work with BSD systems

EOH

}

### SCRIPT SETUP ###
# BSD's getopt is simpler than the GNU getopt; we need to detect it
if [ -x /usr/bin/uname ]; then
    OSDETECT=$(/usr/bin/uname -s)
elif [ -x /bin/uname ]; then
    OSDETECT=$(/bin/uname -s)
else
    echo "ERROR: can't run 'uname -s' command to determine system type"
    exit 1
fi

for GETOPT_CHECK in "/opt/local/bin/getopt" "/usr/bin/getopt";
do
    if [ -x "${GETOPT_CHECK}" ]; then
        GETOPT_BIN=$GETOPT_CHECK
        break
    fi
    if [ -z "${GETOPT_BIN}" ]; then
        echo "ERROR: getopt binary not found; exiting...."
        exit 1
    fi
done

# Use short options if we're using Darwin's getopt
if [ $OSDETECT = "Darwin" -a $GETOPT_BIN != "/opt/local/bin/getopt" ]; then
    GETOPT_TEMP=$(${GETOPT_BIN} heqc $*)
else
# Use short and long options with GNU's getopt
    GETOPT_TEMP=$(${GETOPT_BIN} -o heqncp:e: \
        --long help,examples,quiet,dry-run,explain \
        --long color,nocolor,no-color \
        --long path:,exclude: \
        -n "${SCRIPTNAME}" -- "$@")
fi

# if getopts exited with an error code, then exit the script
#if [ $? -ne 0 -o $# -eq 0 ] ; then
if [ $? != 0 ] ; then
    echo "Run '${SCRIPTNAME} --help' to see script options" >&2
    exit 1
fi

# Note the quotes around `$GETOPT_TEMP': they are essential!
# read in the $GETOPT_TEMP variable
eval set -- "$GETOPT_TEMP"

# read in command line options and set appropriate environment variables
# if you change the below switches to something else, make sure you change the
# getopts call(s) above
while true ; do
    case "$1" in
        -h|--help) # show the script options
            show_help
            exit 0;;
        -e|--examples)
            show_examples
            exit 0;;
        # Don't output anything (unless there's an error)
        -q|--quiet)
            QUIET=1
            shift;;
        # Don't use color in the output
        -c|--nocolor|--color|--no-color)
            NO_COLORIZE=1
            shift;;
        # Explain what will be done, don't actually do
        -n|--dry-run|--explain)
            DRY_RUN=1
            shift;;
        # Path to the directory with one or more git repos
        -p|--path|--dir)
            REPO_PATH=$2;
            shift 2;;
        # Paths to exclude
        -e|--exclude)
            EXCLUDE_PATH=$2;
            shift 2;;
        # everything else
        --)
            shift;
            break;;
        # we shouldn't get here; die gracefully
        *)
            echo "ERROR: unknown option '$1'" >&2
            echo "ERROR: use --help to see all script options" >&2
            exit 1
            ;;
    esac
done

### SCRIPT MAIN LOOP ###
# do some error checking; we need at a minimum '--path' and a <command> to run
if [ -z $REPO_PATH ]; then
    colorize "$MSG_FAIL" "ERROR: missing repo path as --path"
    echo $COLORIZE_OUT
    exit 1
fi

colorize_clear
if [ $QUIET -eq 0 ]; then
    colorize "$MSG_FLUFF" "=-=-=-=-=-=-=-= "
    colorize "$MSG_INFO" "$SCRIPTNAME"
    colorize "$MSG_FLUFF" " =-=-=-=-=-=-=-="
    echo $COLORIZE_OUT
fi

# generate a date for checking for errors
#colorize_clear
#OUTPUT=$(date)
#check_exit_status $? "date" $OUTPUT
#colorize $MSG_INFO "$OUTPUT"
#echo $COLORIZE_OUT

# get a list of directories to enumerate over
colorize_clear
recurse_path "$REPO_PATH"

# exit cleanly if we reach here
#if [ $QUIET -eq 0 ]; then
#    echo "Hit <ENTER> to exit"
#    read ANSWER
#fi

exit ${SCRIPT_EXIT}

# ### begin license blurb ###
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
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111, USA.

# vi: set filetype=sh shiftwidth=4 tabstop=4
# end of line
