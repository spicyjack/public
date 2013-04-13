# Life with Perlbrew #

https://metacpan.org/module/App::perlbrew

## Get the current status ##

    perlbrew info

## Get Perl version availability ##
Also shows installed versions of Perl, with an `i` character next to an
installed version of Perl.

    perlbrew available

## Switch to a different Perl ##

    perlbrew switch perl-5.X.X

# Turn perlbrew off completely

    perlbrew off

# Use 'switch' command to turn it back on.

    perlbrew switch perl-5.12.2

## Temporarily use another version only in current shell ##

    perlbrew use perl-5.8.1
    perl -v

## Installation ##

    curl -kL http://install.perlbrew.pl | bash

# vim: filetype=markdown shiftwidth=2 tabstop=2
