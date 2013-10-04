#!/bin/bash

### VARIABLES ###
# NOTE: if you plan on uploading to git.gnome.org, change the below to match
# your Gnome.org user ID and GPG key ID
GIT_USER="Brian Manning"
GIT_EMAIL="bmanning@src.gnome.org"
GIT_GPG_KEY="8D7CEDE6"

# base URL for all of the git source stored on gnome.org
GNOME_GIT_BASE_URL="https://git.gnome.org/browse"
#GNOME_GIT_BASE_URL="ssh://bmanning@git.gnome.org/git"
#GNOME_GIT_BASE_URL="http://git.gnome.org/browse"

## List of current gtk2-perl repos
GTK_PERL_REPOS='
perl-Cairo perl-Cairo-GObject perl-Champlain perl-Clutter
perl-ExtUtils-Depends perl-ExtUtils-PkgConfig
perl-GStreamer perl-GStreamer-GConf perl-GStreamer-Interfaces
perl-Glib perl-Glib-IO perl-Glib-Object-Introspection
perl-Gnome2 perl-Gnome2-Canvas perl-Gnome2-Dia perl-Gnome2-GConf
perl-Gnome2-PanelApplet perl-Gnome2-Print perl-Gnome2-Rsvg
perl-Gnome2-VFS perl-Gnome2-Vte perl-Gnome2-Wnck
perl-Goo-Canvas perl-Gtk2 perl-Gtk2-Champlain perl-Gtk2-GLExt
perl-Gtk2-GladeXML perl-Gtk2-Html2 perl-Gtk2-MozEmbed
perl-Gtk2-SourceView perl-Gtk2-SourceView2 perl-Gtk2-Spell
perl-Gtk2-Unique perl-Gtk3 perl-Pango
' # GTK_PERL_REPOS

    export SOURCE_DIR="$HOME/src/gtk-perl"
    if [ ! -d $SOURCE_DIR ]; then
        mkdir -p $SOURCE_DIR
    fi
    GTK_CLONE_OLDPWD=$PWD
    cd $SOURCE_DIR
    for PROJECT in $GTK_PERL_REPOS; do
        if [ -d ${PROJECT}.git ]; then
            echo "=== Running 'git pull' on ${SOURCE_DIR}/${PROJECT}.git ===";
            cd ${PROJECT}.git
            git pull
            if [ $? -gt 0 ]; then
                echo "ERROR: 'git clone' returned non-zero status"
                exit 1
            fi
            cd $OLDPWD
        else
            echo "=== Running 'git clone ${PROJECT}' into ${SOURCE_DIR} ===";
            git clone ${GNOME_GIT_BASE_URL}/$PROJECT ${PROJECT}.git
            if [ $? -gt 0 ]; then
                echo "ERROR: 'git clone' returned non-zero status"
                exit 1
            fi
        fi
        if [ -d ${PROJECT}.git ]; then
            cd ${PROJECT}.git
            echo "-- Setting user name/email/gpgkey via 'git config' --"
            git config user.name "${GIT_USER}"
            git config user.email "${GIT_EMAIL}"
            git config user.signkey "${GIT_GPG_KEY}"
            cd $SOURCE_DIR
        else
            echo "ERROR: project ${PROJECT}.git was not cloned!"
            exit 1
        fi
    done
    cd $GTK_CLONE_OLDPWD

# vi: set filetype=sh shiftwidth=4 tabstop=4
# fin!
