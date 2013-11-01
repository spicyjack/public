#!/bin/bash

# Library of common shell functions

# Copyright (c)2013 by Brian Manning (brian at xaoc dot org)
# License terms are listed at the bottom of this file
#
# Impotant URLs:
# Clone:    https://github.com/spicyjack/public.git
# Issues:   https://github.com/spicyjack/public.git/issues

## FUNC: say()
## ARG:  MESSAGE to be written on STDOUT
## ENV:  QUIET - the quietness level of the script
## DESC: Check if $QUIET is set, and if not, write MESSAGE to STDOUT
function say {
    local MESSAGE="$1"
    if [ $QUIET -ne 1 ]; then
        echo "$MESSAGE"
    fi
}

## FUNC: info()
## ARG:  MESSAGE to be written on STDOUT, with an arrow '->'
## ENV:  QUIET - the quietness level of the script
## DESC: Check if $QUIET is set, and if not, write MESSAGE to STDOUT
function info {
    local MESSAGE="$1"
    if [ $QUIET -ne 1 ]; then
        echo "-> $MESSAGE"
    fi
}

## FUNC: warn()
## ARG:  MESSAGE - the message to be written to STDERR
## DESC: Always writes MESSAGE to STDERR (ignores $QUIET)
function warn {
    local MESSAGE="$1"
    echo $MESSAGE >&2
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
    for GETOPT_CHECK in "/opt/local/bin/getopt" "/usr/bin/getopt";
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
    if [ $OS_NAME = "Darwin" -a $GETOPT_BIN != "/opt/local/bin/getopt" ]; then
        # Use short options if we're using Darwin's getopt
        GETOPT_TEMP=$(${GETOPT_BIN} ${GETOPT_SHORT} $*)
    else
        # Use short and long options with GNU's getopt
        GETOPT_TEMP=$(${GETOPT_BIN} -o ${GETOPT_SHORT} \
            --long ${GETOPT_LONG} \
            -n "${SCRIPTNAME}" -- "$@")
    fi

    # if getopts exited with an error code, then exit the script
    #if [ $? -ne 0 -o $# -eq 0 ] ; then
    if [ $? != 0 ] ; then
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
