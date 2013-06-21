#!/bin/bash
#
# Vim configuration for pd (~/.vim/after/ftplugin/perl.vim):
#     :setlocal keywordprg=pd
#     :setlocal iskeyword+=:,$,@,%
# As Gisted by Chris Grau (http://sirhc.us)
 
pd=$(type -P cpandoc)
pd=${pd:-"$(type -P perldoc)"}
 
$pd -f "$@" 2>/dev/null && exit
$pd    "$@" 2>/dev/null && exit
$pd -q "$@" 2>/dev/null && exit
man "$@"    2>/dev/null && exit
 
echo "$0: $@: No match" 1>&2
exit 1
