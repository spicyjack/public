# Life with Perlbrew #

https://metacpan.org/module/App::perlbrew

## Using Perlbrew ##
Get the current status
- `perlbrew info`

Get Perl version availability
- Also shows installed versions of Perl, with an `i` character next to an
  installed version of Perl.
- `perlbrew available`

Switch to a different Perl
- `perlbrew switch perl-5.X.X`

Turn perlbrew off completely
- `perlbrew off`

Use 'switch' command to turn it back on.
- `perlbrew switch perl-5.12.2`

Temporarily use another version only in current shell ##
- `perlbrew use perl-5.8.1`
- `perl -v`

Perlbrew Installation
- `curl -kL http://install.perlbrew.pl | bash`

# Using `cpanm` #
Installing a module + dependencies
- `cpanm Module::Name`

"Looking" into a module distribution
- `cpanm --look Module::Name`

## Links ##
- http://www.dagolden.com/index.php/2134/how-i-manage-new-perls-with-perlbrew/

## Problems installing Gtk2: Cairo won't build ##
Unlink and relink all of the dependencies for `cairo`;
- `brew link --force pixman`
- `brew link --force fontconfig`
- `brew link --force freetype`
- `brew link --force libpng`
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

    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig:/usr/local/lib/pkgconfig \
      perl Makefile.PL
    LDFLAGS="-L/usr/local/opt/cairo/lib" \
      CPPFLAGS="-I/usr/local/opt/cairo/include" \
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
