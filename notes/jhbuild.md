# jhbuild Notes #

- Use jhbuild 
  - https://live.gnome.org/Jhbuild
  - https://live.gnome.org/Jhbuild/FAQ
  - https://live.gnome.org/JhbuildDependencies/Debian
  - http://developer.gnome.org/jhbuild/unstable/
  - Build on OS X
    - OS X under VMWare?
  - Build on Lagrange for testing

## Installation ##
- `git clone git://git.gnome.org/jhbuild jhbuild.git`
- `cd jhbuild.git`
- `./autogen.sh`
- `time make`
- `time make install` 
  - Installs into `~/.local`
- Add `~/.local/bin` to your `$PATH`
- There's a sample config file located in
  `jhbuild.git/examples/sample.jhbuildrc`
  - Copy it to `~/.config`, and modify it to suit

## Running ##
- `jhbuild sanitycheck`
- `jhbuild sysdeps --install`
- On Wheezy, install the following:
  - python2.7-dev (jhbuild)
  - python-libxml2 (yelp-xsl)
  - xsltproc (yelp-tools)
- Create symlinks so jhbuild can find different Python tools;
  - `sudo ln -s /usr/lib/pkgconfig/python-2.7.pc /usr/lib/pkgconfig/python.pc`
  - `sudo ln -s /usr/bin/python2.7-config /usr/bin/python-config`
- `jhbuild build gtk+`

## jhbuild usage ##
- Check for missing dependencies needed to run jhbuild
  - `jhbuild sanitycheck`
- Check for and install missing dependencies needed to build Gnome stack
  - `jhbuild sysdeps --install`
- Build everything
  - `jhbuild build`
- Build only a specific module and it's dependencies
  - `jhbuild build gtk+`
  - `jhbuild build gtk+-2`
- Build only a specific module, without it's dependencies
  - `jhbuild buildone gtk+`
  - `jhbuild buildone gtk+-2`
- To get info about a module:
  - `jhbuild info gtk+`
- To list all modules
  - `jhbuild list`
  - `jhbuild list | sort | less`
- To restart `jhbuild` at a specific module:
  - `jhbuild build --start-at=pango`
- To run a program from within the `jhbuild` environment:
  - `jhbuild run *program*`
- To get a shell in the `jhbuild` environment:
  - `jhbuild shell`
- To update all sources without building:
  - `jhbuild update`

See http://developer.gnome.org/jhbuild/unstable/getting-started.html.en for
more info on different build commands

## GTK Build Sequence ##
Write a sync script that syncs the git trees for libgtk/gtk-perl
- Perl
- GTK
  - Cairo
    - requires: libpixman newer than 0.18.4, x11-dev
  - Glib
  - Pango
  - ATK?
  - GTK+
    - GTK+ 2.x
    - GTK+ 3.x
- Gtk-Perl
  - Pango
  - Cairo
  - Glib
  - Gtk2
  - Gtk3

## Build Issues ##
- Can't run `make test` in libglib because the tests require pygobject newer
  than 3.x, and only pygobject 2.x is available on Debian squeeze
- New prerequisites - 08Apr2013
  - libtasn1 > 2.4
  - intltool > 0.50.0

# vim: filetype=markdown tabstop=2
