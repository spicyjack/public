#!/bin/bash

# Library of common shell functions

# Copyright (c)2013 by Brian Manning (brian at xaoc dot org)
# License terms are listed at the bottom of this file
#
# Impotant URLs:
# Clone:    https://github.com/spicyjack/public.git
# Issues:   https://github.com/spicyjack/public.git/issues

### OUTPUT COLORIZATION VARIABLES ###
START="\x1b["
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
MSG_WARN="${F_YLW};${B_BLK}"
MSG_DRYRUN="${BOLD};${F_CYN};${B_BLU}"
#MSG_OK="${BOLD};${F_WHT};${B_GRN}"
MSG_OK="${BOLD};${F_BLU};${B_BLK}"
MSG_REMOTE="${F_CYN};${B_BLK}"
MSG_INFO="${BOLD};${F_WHI};${B_BLU}"
MSG_FLUFF="${BOLD};${F_BLU};${B_BLK}"

# BSD's getopt is simpler than the GNU getopt; we need to detect it
if [ -x /usr/bin/uname ]; then
    OSDETECT=$(/usr/bin/uname -s)
elif [ -x /bin/uname ]; then
    OSDETECT=$(/bin/uname -s)
else
    echo "ERROR: can't run 'uname -s' command to determine system type"
    exit 1
fi

# compensate for different 'echo' commands on different platforms
# we need an echo that works with backslash escaped characters
if [ $OSDETECT = "Darwin" ]; then
    ECHO_CMD="echo -e"
elif [ $OSDETECT = "Linux" ]; then
    ECHO_CMD="builtin echo -e"
else
    ECHO_CMD="echo"
fi

### FUNCTIONS ###
# wrap text inside of ANSI tags, unless --nocolor is set
colorize () {
    local TEXT="$1"
    local COLOR="$2"

    if [ $COLORIZE -ne 0 ]; then
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

## FUNC: say()
## ARG:  MESSAGE to be written on STDOUT
## ENV:  QUIET - the quietness level of the script
## DESC: Check if $QUIET is set, and if not, write MESSAGE to STDOUT
function say {
    local MESSAGE="$1"
    if [ $QUIET -ne 1 ]; then
        colorize "$MESSAGE" "${MSG_OK}"
        $ECHO_CMD "${COLORIZE_OUT}"
        colorize_clear
    fi
}

## FUNC: info()
## ARG:  MESSAGE to be written on STDOUT, with an arrow '->'
## ENV:  QUIET - the quietness level of the script
## DESC: Check if $QUIET is set, and if not, write MESSAGE to STDOUT
function info {
    local MESSAGE="$1"
    if [ $QUIET -ne 1 ]; then
        colorize "-> ${MESSAGE}" "${MSG_INFO}"
        $ECHO_CMD "${COLORIZE_OUT}"
        colorize_clear
    fi
}

## FUNC: warn()
## ARG:  MESSAGE - the message to be written to STDERR
## DESC: Always writes MESSAGE to STDERR (ignores $QUIET)
function warn {
    local MESSAGE="$1"
    colorize "${MESSAGE}" "${MSG_WARN}"
    $ECHO_CMD "${COLORIZE_OUT}"
    colorize_clear
}

## FUNC: check_exit_status()
## ARG:  EXIT_STATUS - Returned exit status code of that function
## ARG:  STATUS_MSG - Status message, usually the command that was run
## RET:  Returns the value of EXIT_STATUS
## DESC: Verifies the function exited with an exit status code (0), and
## DESC: exits the script if any other status code is found.
check_exit_status () {
    EXIT_STATUS="$1"
    DESC="$2"
    OUTPUT="$3"

    if [ $QUIET -ne 1 ]; then
        # check for errors from the script
        if [ $EXIT_STATUS -ne 0 ] ; then
            warn "${SCRIPTNAME}: ${DESC}"
            warn "${SCRIPTNAME}: error exit status: ${EXIT_STATUS}"
        fi
        if [ "x$OUTPUT" != "x" ]; then
            echo "${SCRIPTNAME}: ${DESC} output:"
            echo $OUTPUT
       fi
    fi
    return $EXIT_STATUS
} # check_exit_status

## FUNC: run_getopt status()
## ARG:  GETOPT_SHORT - 'short' values to be used with 'getopt'
## ARG:  GETOPT_LONG - 'long' values to be used with 'getopt'
## ARG:  $@ - The rest of the command-line arguments
## SETS: Sets $GETOPT_TEMP, a formatted list of command line options
## DESC: Sets up command line arguments for processing in the main script;
## DESC: Detects which OS and what versions of 'getopt' are available
run_getopt() {
    # use 'shift' to remove the first two arguments, prior to running getopt
    # with the value of "$@"
    local GETOPT_SHORT="$1"
    shift
    local GETOPT_LONG="$1"
    shift

    # these two paths cover a majority of my test machines
    for GETOPT_CHECK in \
        "/usr/local/bin/getopt" "/opt/local/bin/getopt" "/usr/bin/getopt";
    do
        if [ -x "${GETOPT_CHECK}" ]; then
            GETOPT_BIN=$GETOPT_CHECK
            break
        fi
    done

    # did we find an actual binary out of the list above?
    if [ -z "${GETOPT_BIN}" ]; then
        warn "ERROR: getopt binary not found; exiting...."
        exit 1
    fi

    OS_NAME=$(/usr/bin/env uname -s)
    # check to see if we're using Darwin's (BSD's) getopt
    if [ $OS_NAME = "Darwin" -a $GETOPT_BIN = "/usr/bin/getopt" ]; then
        # Yes, use short options only
        GETOPT_TEMP=$(${GETOPT_BIN} ${GETOPT_SHORT} $*)
    else
        # No, use both short and long options with GNU's getopt
        GETOPT_TEMP=$(${GETOPT_BIN} -o ${GETOPT_SHORT} \
            --long ${GETOPT_LONG} \
            -n "${SCRIPTNAME}" -- "$@")
    fi

    # if getopts exited with an error code, then exit the script
    #if [ $? -ne 0 -o $# -eq 0 ] ; then
    if [ $? != 0 ] ; then
        if [ $OS_NAME = "Darwin" -a $GETOPT_BIN = "/usr/bin/getopt" ]; then
            warn "GNU long options will not work with Darwin's 'getopt';"
            warn "If you used double-dash options (--help for example),"
            warn "they won't work, you need to switch to short options (-h)."
        fi
        warn "Run '${SCRIPTNAME} --help' to see script options"
        exit 1
    fi
}

## FUNC: check_env_variable()
## ARG:  ENV_VAR_NAME, display name of the environment variable
## ARG:  ENV_VAR, the environment variable to check
## DESC: Checks to see if a variable isset in the environment
check_env_variable () {
    local ENV_VAR_NAME="$1"
    local ENV_VAR="$2"

    if [ -z $ENV_VAR ]; then
        warn "ERROR: environment variable ${ENV_VAR_NAME} unset"
        exit 1
    fi
}

## FUNC: show_script_header()
## ENV:  QUIET - the quietness level of the script
## DESC: Prints out a nicely formatted script header, if $QUIET is not set
show_script_header () {
    if [ $QUIET -ne 1 ]; then
        RUN_DATE=$(date +"%a %b %d %T %Z %Y (%Y.%j)")
        say "=-=-= ${SCRIPTNAME} =-=-="
        info "Run date: ${RUN_DATE}"
    fi
}

## FUNC: generate_artifact_timestamp()
## SETS: ARTIFACT_TIMESTAMP, a timestamp showing when the artifact was built
## DESC: The ARTITFACT_TIMESTAMP is a simple file that is 'touch'ed in the
## DESC: output directory, so when the artifact is used at a later point in
## DESC: time, you can tell when it was built, and with what version of the
## DESC: source code it was built
function generate_artifact_timestamp {
    ARTIFACT_TIMESTAMP=$(date +%Y.%j-%H.%m)
}

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
