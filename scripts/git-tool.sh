#!/bin/bash

# - get a list of directories
# - filter the list for directories to exclude, and exclude those dirs
# - loop over the left-over directories
# - for each directory;
#   - if the directory ends in *.git, then enter it, and run the command
#   - if the directory does not end in *.git, push it to a stack, or enter it
#   and process it's contents

### FUNCTIONS ###
rungitcmd() {
    local GIT_CMD=$1
    local GIT_SUCCESS_PATTERN=$2

    if [ $GIT_DEBUG -gt 0 ]; then echo "command: ${GIT_CMD}"; fi
    GIT_OUTPUT=$(${GIT_CMD} 2>&1)
    if [ $(echo $GIT_OUTPUT | grep -c "${GIT_SUCCESS_PATTERN}") -ne 1 ]; then
        echo $GIT_OUTPUT
    fi
}

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
} # check the status in git directories

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
} # git pull in all git directories

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
            OUTPUT=$(git log --pretty=format:"${GIT_FORMAT}" \
                --after="${CHECK_DATE}" | cut -c -80)
            if [ -n "$OUTPUT" ]; then
                echo $OUTPUT
            fi
            IFS=$' \t\n'
            cd $SOURCE_DIR
        done
        cd $START_DIR
    fi
    unset_git_source_dir
} # git pull in all git directories

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
} # check for inbound changes to git directories

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
} # check for outbound changes in git directories

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
} # check for outbound changes in git directories

check_exit_status() {
    ERROR=$1
    QUIET=$2
    OUTPUT=$3

    # check for errors from the script
    if [ $ERROR -ne 0 ] ; then
        if [ $QUIET -eq 0 ]; then
            echo -n "${START}${MSG_DELETE}${END}script exited with error:"
            echo "${START};${NONE}${END}"
            echo $? >&2
            echo -n "${START}${MSG_DELETE}${END}script output:"
            echo "${START};${NONE}${END}"
            echo $OUTPUT
        fi
         EXIT=1
    else
        if [ $QUIET -eq 0 ]; then
            echo -n "${START}${MSG_VERBOSE}${END}script exited with no errors"
            echo "${START};${NONE}${END}"
            echo -n "${START}${MSG_INFO}${END}script output:"
            echo "${START};${NONE}${END}"
            echo $OUTPUT
        fi
        EXIT=0
    fi
} # function check_exit_status

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
MSG_DELETE="${BOLD};${F_YLW};${B_RED}"
MSG_DRYRUN="${BOLD};${F_WHT};${B_BLU}"
MSG_VERBOSE="${BOLD};${F_WHT};${B_GRN}"
MSG_INFO="${BOLD};${F_BLU};${B_WHT}"

### MAIN SCRIPT ###
# what's my name?
SCRIPTNAME=$(basename $0)
# path to the perl binary

# set quiet mode by default, needs to be set prior to the getops call
QUIET=1

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

# FIXME MacPorts can install getopt to /opt/local/bin/getopt; check for it
if [ ${OSDETECT} = "Darwin" ]; then
    # this is the BSD part
    echo "WARNING: BSD OS Detected; long switches will not work here..."
    GETOPT_TEMP=$(/usr/bin/getopt heqc $*)
elif [ ${OSDETECT} = "Linux" ]; then
    # and this is the GNU part
    GETOPT_TEMP=$(/usr/bin/getopt -o heqncp:e: \
        --long help,examples,quiet,dry-run,explain,color,nocolor \
        --long path:,exclude: \
        -n '${SCRIPTNAME}' -- "$@")
else
    echo "Error: Unknown OS Type.  I don't know how to call"
    echo "'getopts' correctly for this operating system.  Exiting..."
    exit 1
fi

# if getopts exited with an error code, then exit the script
#if [ $? -ne 0 -o $# -eq 0 ] ; then
if [ $? != 0 ] ; then
    echo "Run '${SCRIPTNAME} --help' to see script options" >&2
    exit 1
fi

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
        -c|--nocolor|--color) 
            NO_COLOR=1
            shift;;
        # Explain what will be done, don't actually do
        -n|--dry-run|--explain)
            NO_COLOR=1
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
if [ $QUIET -eq 0 ]; then
    # run the script
    echo
    echo -n "=-=-=-=-=-=-=-=${START}${MSG_INFO}${END}Displaying Date"
    echo "${START};${NONE}${END}=-=-=-=-=-=-=-="
fi

# generate a date for checking for errors
$OUTPUT=$(date)
check_exit_status $? $QUIET "$OUTPUT"


# exit cleanly if we reach here
if [ $QUIET -eq 0 ]; then
    echo "Hit <ENTER> to exit"
    read ANSWER
fi

exit ${EXIT}

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
