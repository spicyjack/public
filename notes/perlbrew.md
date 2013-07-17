# Life with Perlbrew #

## Links ##
- http://perlbrew.pl/
- https://metacpan.org/module/App::perlbrew

## Using Perlbrew ##
Get the current status

    perlbrew info

List the current installed Perls

    perlbrew list

Get Perl version availability

    perlbrew available

- Also shows installed versions of Perl, with an `i` character next to an
  installed version of Perl.

Switch to a different Perl

    perlbrew switch perl-5.X.X

Install a different version of Perl

    perlbrew install perl-5.X.X

Install Perl with specific options

    perlbrew install --switch --thread --multi --64int --64all --ld \
    --as perl-5.18.0-with_threads -j 4 perl-5.18.0

Create an alias to an existing install of Perl

    perlbrew alias create perl-5.18.0 5.18.0-no_threads

Uninstall an existing install

    perlbrew uninstall perl-5.18.0

Delete a previously created alias

    perlbrew alias delete 5.18.0-no_threads

Use a different installed Perl

    perlbrew use perl-5.18.0-with_threads

Install `cpanminus/cpanm`

    perlbrew install-cpanm

- See the section below on working with `cpanm`

Turn perlbrew off completely

    perlbrew off

Use 'switch' command to turn it back on.

    perlbrew switch perl-5.12.2

Temporarily use another version only in current shell ##

    perlbrew use perl-5.8.1
    perl -v

Perlbrew Installation

    curl -kL http://install.perlbrew.pl | bash

## Using `cpanm` ##
Installing a module + dependencies

    cpanm Module::Name
    cpanm ExtUtils::Depends
    cpanm ExtUtils::PkgConfig

"Looking" into a module distribution
- `cpanm --look Module::Name`

## Working with CPAN module bundles ##
Create CPAN bundle

    perl -MCPAN -e autobundle

Re-install modules listed in the bundle

    perl -MCPAN -e 'install Bundle::Snapshot_2010_09_20_00'

## Links ##
- http://www.dagolden.com/index.php/2134/how-i-manage-new-perls-with-perlbrew/

## Problems installing Gtk2: Cairo won't build ##
Unlink and relink all of the dependencies for `cairo`;
- `brew link --force pixman`
- `brew link --force fontconfig`
- `brew link --force freetype`
- `brew link --force cairo`

Then build `Cairo` via `cpanm` with `PKG_CONFIG_PATH` set to the system X11
path;

    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig cpanm Gtk2

## Problems installing Gtk3: Cairo-GObject won't build ##
Verify your `libcairo` was built with `GObject` support.  You would have built
`libcairo` like this:

    brew install --with-glib cairo

Same deal with `Gtk2` above; install `Cairo::GObject` with extra paths set in
the environment.

    cpanm --look Cairo::GObject

    CPPFLAGS="-I/usr/local/cairo/include" \
      LDFLAGS="-L/usr/local/lib" \
      PKG_CONFIG_PATH="/usr/X11/lib/pkgconfig" \
      perl Makefile.PL

Edit the resulting `Makefile` and remove references to `include` in
`/usr/lib`.  Also, add a reference to the `Freetype` include files in
`/usr/local/include/freetype2`

    INC = -I/usr/X11/include -I/usr/local/include/freetype2 \
    -I/usr/local/Cellar/cairo/1.12.14/include/cairo \
    -I/usr/local/Cellar/glib/2.36.2/include/glib-2.0 \
    -I/usr/local/Cellar/glib/2.36.2/lib/glib-2.0/include

Then run `make && make test && make install` to install `Cairo::GObject`.

vim: filetype=markdown shiftwidth=2 tabstop=2
