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

## Links ##
- http://www.dagolden.com/index.php/2134/how-i-manage-new-perls-with-perlbrew/

## Problems installing Gtk2: Cairo won't build ##
Unlink and relink all of the dependencies for `libcairo`;
- `brew link --force pixman`
- `brew link --force fontconfig`
- `brew link --force freetype`
- `brew link --force libpng`

Then build `Cairo` via `cpanm` with `PKG_CONFIG_PATH` set to the system X11
path;

    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig cpanm Gtk2

## Problems installing Gtk3: Cairo-GObject won't build ##
Verify your `libcairo` was built with `GObject` support.  You would have built
`libcairo` like this:

    brew install cairo --with-glib

Same deal with `Gtk2` above; install Gtk3 with `PKG_CONFIG_PATH` set to the
system X11 path;

    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig cpanm Gtk2


vim: filetype=markdown shiftwidth=2 tabstop=2
