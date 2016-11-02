#!/usr/bin/env bash

# Copyright (c)2004,2012, 2013
# by Brian Manning.  License terms are listed at the bottom of this file
#
# Install a set of modules via the 'cpanm' command

BASE_MODULES="
   App::FatPacker Capture::Tiny Config::IniFiles
   Cpanel::JSON::XS DBM::Deep Devel::NYTProf Devel::Size
   Digest::SHA1 Dist::Zilla Error File::Find::Rule
   File::Path::Tiny File::Slurp::Tiny Getopt::Long
   IO::Socket::SSL Image::ExifTool JSON JSON::Any JSON::XS
   Log::Log4perl LWP LWP::Protocol::https Moo
   MooX::Types::MooseLike Net::OpenSSH Number::Format
   Path::Tiny Rex Role::Tiny Template Test::More Throwable
   Tree::Simple Try::Tiny Type::Tiny YAML YAML::Tiny
   autodie
"

ARCHIVE_MODULES="
   Archive::Extract Archive::Tar Archive::Zip Compress::Bzip2
"

DB_MODULES="
   DBI DBD::CSV DBD::ODBC DBD::Pg DBD::SQLite DBD::mysql
"

# NOTE: XML::LibXML requires that `brew link libxml2 --force` be run, so that
# the symlink to `xml2-config` is created in `/usr/local/bin`
MISC_MODULES="
   Algorithm::Diff Class::Tiny Config::Tiny Config::Std Data::Compare
   Date::Parse Date::Tiny DateTime DateTime::Locale DateTime::TimeZone
   DateTime::Tiny Mac::SystemDirectory PDF::API2 PDF::Table
   Parse::RecDescent Perl::Critic Perl::Tidy Pod::Weaver
   Pod::Webserver Template::Tiny Text::CSV Text::CSV_XS Text::Markdown
   WWW::Shorten::Simple XML::LibXML XML::Parser XML::Simple
   App::Ack strictures syntax
"

GTK_MODULES="
   Glib Cairo Cairo::GObject ExtUtils::Depends ExtUtils::PkgConfig
   Glib::Object::Introspection Gtk2 Gtk3 Pango
"

WEBAPP_MODULES="
   Mojo::Pg Mojolicious Mojolicious::Plugin::RenderFile Dancer2
"

# what's my name?
SCRIPTNAME=$(basename $0)

# assume everything will go well
EXIT_STATUS=0

# set quiet mode by default, needs to be set prior to the getops call
QUIET=0

# colorize? yes please (1=yes, colorize, 0=no, don't colorize)
COLORIZE=1
# always colorize?  set via --colorize
ALWAYS_COLORIZE=0

# dry-run, i.e. show commands, don't run them? (0 = no, 1 = yes)
DRY_RUN=0

# what sets of modules to install
INSTALL_MODULES=""
INSTALL_ALL=0
INSTALL_BASE=0
INSTALL_ARCHIVE=0
INSTALL_DB=0
INSTALL_MISC=0
INSTALL_GTK=0
INSTALL_WEBAPP=0

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
MSG_OK="${BOLD};${F_WHT};${B_GRN}"
MSG_REMOTE="${F_CYN};${B_BLK}"
MSG_INFO="${BOLD};${F_WHI};${B_BLU}"
MSG_FLUFF="${BOLD};${F_BLU};${B_BLK}"

### FUNCTIONS ###
# wrap text inside of ANSI tags, unless --nocolor is set
colorize () {
   local COLOR="$1"
   local TEXT="$2"

   if [ $COLORIZE -eq 1 ]; then
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
         colorize_clear
         colorize $MSG_FAIL "${CMD_RUN} exited with error: $ERROR"
         $ECHO_CMD $COLORIZE_OUT
         colorize_clear
         colorize $MSG_FAIL "${CMD_RUN} output: "
         $ECHO_CMD $COLORIZE_OUT
         colorize_clear
         colorize $MSG_WARN "${CMD_OUT}"
         $ECHO_CMD $COLORIZE_OUT
         colorize_clear
      fi
      EXIT_STATUS=1
   fi
} # check_exit_status

show_help() {
# show script options
cat <<-EOH

${SCRIPTNAME} [options] <command>

   GENERAL SCRIPT OPTIONS
   -h|--help      Displays this help message
   -q|--quiet     No script output (unless an error occurs)
   -n|--dry-run   Explain what will be done, don't actually do it
   -c|--colorize  Always colorize output, ignore '-t' test

   OPTIONS FOR CPAN MODULES
   -l|--list      List all of the modules included in this script
   -a|--all       Install all modules included in this ѕcript
   -b|--base      Base set of modules
   -z|--archive   Archive modules
   -d|--db        Database modules
   -m|--misc      Misc. modules
   -g|--gtk       Gtk-Perl modules
   -w|--webap     WebApp (Mojolicious/Dancer2) modules

NOTES:
- Long switches (GNU extension) do not work with BSD 'getopt'
- Colorization is disabled when script outputs to pipe (-t set on filehandle)

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

if [ $OSDETECT = "Darwin" ]; then
    ECHO_CMD="echo -e"
elif [ $OSDETECT = "Linux" ]; then
    ECHO_CMD="builtin echo -e"
else
    ECHO_CMD="echo"
fi

# these paths cover a majority of my test machines
for GETOPT_CHECK in "/opt/local/bin/getopt" "/usr/local/bin/getopt" \
    "/usr/bin/getopt";
do
    if [ -x "${GETOPT_CHECK}" ]; then
        GETOPT_BIN=$GETOPT_CHECK
        break
    fi
done

# did we find an actual binary out of the list above?
if [ -z "${GETOPT_BIN}" ]; then
    echo "ERROR: getopt binary not found; exiting...."
    exit 1
fi

# Use short options if we're using Darwin's getopt
if [ $OSDETECT = "Darwin" -a $GETOPT_BIN = "/usr/bin/getopt" ]; then
    GETOPT_TEMP=$(${GETOPT_BIN} hqnclabzdmgj $*)
else
# Use short and long options with GNU's getopt
    GETOPT_TEMP=$(${GETOPT_BIN} -o hqnclabzdmgj \
        --long help,quiet,dry-run,colorize \
        --long list,all,base,archive,db,database,misc,gtk,mojo \
        -n "${SCRIPTNAME}" -- "$@")
fi

# if getopts exited with an error code, then exit the script
#if [ $? -ne 0 -o $# -eq 0 ] ; then
if [ $? != 0 ] ; then
    echo "Run '${SCRIPTNAME} --help' to see script options" >&2
    if [ $OSDETECT = "Darwin" -a $GETOPT_BIN = "/usr/bin/getopt" ]; then
        echo "WARNING: 'Darwin' OS and system '/usr/bin/getopt' detected;" >&2
        echo "WARNING: Only short options (-h, -e, etc.) will work" >&2
        echo "WARNING: with system '/usr/bin/getopt' under 'Darwin' OS" >&2
    fi
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
        -c|--colorize)
            ALWAYS_COLORIZE=1
            shift;;
        # Explain what will be done, don't actually do
        -n|--dry-run|--explain)
            DRY_RUN=1
            shift;;
        # Install the base set of modules
        -a|--all)
            INSTALL_ALL=1
            shift ;;
        # Install the base set of modules
        -b|--base)
            INSTALL_BASE=1
            shift ;;
        # Install archive format modules
        -z|--archive)
            INSTALL_ARCHIVE=1
            shift ;;
        # Install database modules
        -d|--db|--database)
            INSTALL_DB=1
            shift ;;
        # Install misc/uncategorized modules
        -m|--misc)
            INSTALL_MISC=1
            shift ;;
        # Install GTK-Perl modules
        -g|--gtk)
            INSTALL_GTK=1
            shift ;;
        # Install Mojolicious modules
        -j|--mojo)
            INSTALL_WEBAPP=1
            shift ;;
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
# if we're outputting to a pipe, don't colorize, unless ALWAYS_COLORIZE is set
if [ ! -t 1 ]; then
    if [ $ALWAYS_COLORIZE -eq 0 ]; then
        COLORIZE=0
    fi
fi

# do some error checking; we need at a minimum the 'cpanm' command
CPANM_CMD=$(which cpanm)
if [ $? -gt 0 ]; then
   colorize "$MSG_FAIL" "ERROR: can't find 'cpanm' command in your \$PATH"
   exit 1
fi


if [ $QUIET -eq 0 ]; then
   colorize_clear
   colorize "$MSG_FLUFF" "=-=-=-=-=-=-=-= "
   colorize "$MSG_INFO" "$SCRIPTNAME"
   colorize "$MSG_FLUFF" " =-=-=-=-=-=-=-="
   $ECHO_CMD $COLORIZE_OUT
   colorize_clear
fi

# generate the list of modules to install
if [ $INSTALL_BASE -gt 0 ]; then
   INSTALL_MODULES=$BASE_MODULES
fi

if [ $INSTALL_ARCHIVE -gt 0 ]; then
   INSTALL_MODULES="$INSTALL_MODULES $ARCHIVE_MODULES"
fi

if [ $INSTALL_DB -gt 0 ]; then
   INSTALL_MODULES="$INSTALL_MODULES $DB_MODULES"
fi

if [ $INSTALL_MISC -gt 0 ]; then
   INSTALL_MODULES="$INSTALL_MODULES $MISC_MODULES"
fi

if [ $INSTALL_GTK -gt 0 ]; then
   INSTALL_MODULES="$INSTALL_MODULES $GTK_MODULES"
fi

if [ $INSTALL_WEBAPP -gt 0 ]; then
   INSTALL_MODULES="$INSTALL_MODULES $WEBAPP_MODULES"
fi

# check the --all switch last; it will overwrite the rest
if [ $INSTALL_ALL -gt 0 ]; then
   INSTALL_MODULES="$BASE_MODULES $ARCHIVE_MODULES $DB_MODULES
      $MISC_MODULES $GTK_MODULES $WEBAPP_MODULES"
fi

if [ ! -z "${INSTALL_MODULES}" ]; then
   echo "Installing modules..."
else
   echo "No modules specified to install"
   echo "Use '$SCRIPTNAME --help' for script options"
   exit 1
fi

for CPAN_MOD in $(echo $INSTALL_MODULES);
do
   colorize_clear
   if [ $QUIET -eq 0 ]; then
      colorize "$MSG_FLUFF" "- ${CPAN_MOD}"
      $ECHO_CMD $COLORIZE_OUT
      colorize_clear
   fi
   if [ $DRY_RUN -eq 0 ]; then
      cpanm $CPAN_MOD
   else
      echo "cpanm $CPAN_MOD"
   fi
done

# exit cleanly if we reach here
#if [ $QUIET -eq 0 ]; then
#    echo "Hit <ENTER> to exit"
#    read ANSWER
#fi

exit ${EXIT_STATUS}

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
#   Foundation, Inc.,
#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

# vi: set filetype=sh shiftwidth=3 tabstop=3
# end of line
