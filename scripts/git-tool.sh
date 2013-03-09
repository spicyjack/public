#!/bin/bash

function rungitcmd {
    local GIT_CMD=$1
    local GIT_SUCCESS_PATTERN=$2

    if [ $GIT_DEBUG -gt 0 ]; then echo "command: ${GIT_CMD}"; fi
    GIT_OUTPUT=$(${GIT_CMD} 2>&1)
    if [ $(echo $GIT_OUTPUT | grep -c "${GIT_SUCCESS_PATTERN}") -ne 1 ]; then
        echo $GIT_OUTPUT
    fi
}

function gitstat {
    GIT_DEBUG=0
    unset GIT_CMD
    if [ $# -gt 0 ]; then GIT_DEBUG=1; echo "GIT_DEBUG set to ${GIT_DEBUG}"; fi
    START_DIR=$PWD
    cd $SOURCE_DIR
    echo "=== Running 'git status' in ${SOURCE_DIR} ==="
    for DIR in $(/bin/ls | grep 'git$');
    do
        echo "- $DIR";
        cd $DIR
        IFS=$' \t'
        git status --short
        IFS=$' \t\n'
        cd $SOURCE_DIR
    done
    cd $START_DIR
    unset_git_source_dir
} # check the status in git directories

function gitpullall {
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

function gitupdatechk {
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

function gitinchk {
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

function gitoutchk {
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

function gitrefchk {
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

# vi: set filetype=sh shiftwidth=4 tabstop=4
# fin!
#!/bin/sh
# other possible choices here are /bin/bash or maybe /bin/ksh

# Copyright (c)2004,2012 by Brian Manning.  License terms are listed at the
# bottom of this file
#
# shell script that does something

### FUNCTIONS ###
function check_exit_status()
{
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
OSDETECT=$(/usr/bin/uname -s)
if [ ${OSDETECT} == "Darwin" ]; then
    # this is the BSD part
    echo "WARNING: BSD OS Detected; long switches will not work here..."
    TEMP=$(/usr/bin/getopt hpqv: $*)
elif [ ${OSDETECT} == "Linux" ]; then
    # and this is the GNU part
    TEMP=$(/usr/bin/getopt -o hpqv: \
        --long help,prompt,quiet,verbose: -n '${SCRIPTNAME}' -- "$@")
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

function show_help () {
cat <<-EOF

    ${SCRIPTNAME} [options]

    SCRIPT OPTIONS
    -h|--help       Displays this help message
    -v|--verbose    Nice pretty output messages
    -q|--quiet      No script output (unless an error occurs)
    -p|--prompt     Don't prompt after each output run
    NOTE: Long switches do not work with BSD systems (GNU extension)

EOF
}

# Note the quotes around `$TEMP': they are essential!
# read in the $TEMP variable
eval set -- "$TEMP"

# read in command line options and set appropriate environment variables
# if you change the below switches to something else, make sure you change the
# getopts call(s) above
while true ; do
    case "$1" in
        -h|--help) # show the script options
            show_help
            exit 0;;
        -q|--quiet)    # don't output anything (unless there's an error)
            QUIET=1
            shift;;
        -v|--verbose) # output pretty messages
            QUIET=0
            shift;;
        -o|--option) # a month was passed in
            OPTION=$2;
            shift 2;;
        --) shift;
            break;;
        *) # we shouldn't get here; die gracefully
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
