#!/bin/sh
# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

for RCFILE in ~/.bashrc.d/*; do
    # skip the bashrc script template file
    if [ "x$RCFILE" = "xtemplate" ]; then
        continue
    fi
    source $RCFILE
done

# vi: set ft=sh sw=4 ts=4
# fin!
