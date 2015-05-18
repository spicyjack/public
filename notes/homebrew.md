# Homebrew Notes #

## Todo ##
- Fix libcairo so that GObject support works, so that Gtk3 can be compiled

## Homebrew Command Summary ##
Update recipes
- `brew update`
- This will list what recipes got updated

Upgrade recipes
- `brew upgrade <recipe>`

How to find out what packages are out of date?
- `brew outdated`

List installed packages
- `brew list`

List files installed by a package
- `brew list <package name>`

How to find out what files belong to which packages?
- Do an `ls -l` on the file, it will pount back to the location of the
  installing package.

## Package Notes ##

### fuse4x ###

In order for FUSE-based filesystems to work, the fuse4x kernel extension
must be installed by the root user:

    sudo /bin/cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.2/Library/Extensions/fuse4x.kext /Library/Extensions
    sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x

If upgrading from a previous version of Fuse4x, the old kernel extension
will need to be unloaded before performing the steps listed above. First,
check that no FUSE-based filesystems are running:

    mount -t fuse4x

Unmount all FUSE filesystems and then unload the kernel extension:

    sudo kextunload -b org.fuse4x.kext.fuse4x

### MySQL ###
A "/etc/my.cnf" from another install may interfere with a Homebrew-built
server starting up correctly.

To connect:

    mysql -uroot

To set a password:

    SET PASSWORD FOR 'user'@'host' = PASSWORD('password');

To have launchd start mysql at login:

    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

Then to load mysql now:

    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

Or, if you don't want/need launchctl, you can just run:

    mysql.server start

## Homebrew problems encountered ##
- `libtiff` not linking it's `include` files
  - `brew unlink libtiff && brew link libtiff`

## Compiling a Gtk+3 stack under Homebrew and/or Debian ##

### gobject-introspection ###
- Install `gobject-introspection`
- Install `gettext`, and `--force link`
- On Debian, you need to install the `-dev` file `libgirepository1.0-dev` in
  order to get `gobject-introspection-1.0.pc` installed to
  `/usr/lib/pkgconfig`

### cairo ###
- Install `cairo` via Homebrew
  - `brew install --with-glib cairo`
- Force link the `cairo` library
  - `brew link --force cairo`
- Force link `libffi` (Glib dependency)
  - `brew link --force libffi`

### atk ###

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
      ./configure --prefix=/usr/local/Cellar/atk/2.8.0 \
      --enable-introspection=yes

### pango ###
Force link `cairo` and `fontconfig` in order to pick up `.pc` files

    brew link --force cairo
    brew link --force fontconfig

Then do an interactive install of pango

    brew install --interactive pango
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
      ./configure --prefix=/usr/local/Cellar/pango/1.34.1 \
      --enable-introspection=yes

You should see this after running `./configure`:

    configuration:
            backends: Cairo Xft FreeType

### glib ###
Note: may not be needed (02Sep2013), `cairo` may have built this with the
correct flags.

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
      ./configure --prefix=/usr/local/Cellar/glib/2.36.3 \
      --enable-introspection=yes

### gdk-pixbuf ###

    brew install jpeg libtiff libpng
    brew install --interactive gdk-pixbuf
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
    ./configure --prefix=/usr/local/Cellar/gdk-pixbuf/2.28.1 \
      --disable-dependency-tracking --disable-maintainer-mode \
      --enable-debug=no --enable-introspection=yes \
      --disable-Bsymbolic --without-gdiplus


### libgtk3 ###

    brew install d-bus at-spi2-core at-spi2-atk gtk-doc
    brew install --interactive gtk+3

Configure with:

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig \
    ./configure --prefix="/usr/local/Cellar/gtk+3/3.8.2" --disable-debug \
    --enable-introspection=yes --enable-gtk-doc

Note the addition of the two paths for `PKG_CONFIG_PATH`; this is only needed
to build `GTK+3`.

To build, add `PATH=$PATH:/usr/local/bin` to pick `gtkdoc-scan`, and add
`XML_CATALOG_FILES=""` to tell `gtk-doc` where to look for XML catalogs.

    PATH=$PATH:/usr/local/bin \
    XML_CATALOG_FILES="/usr/local/etc/xml/catalog" \
    time make

When trying to install, you'll get this error:

    Error: Could not symlink file:
    /usr/local/Cellar/gtk+3/3.8.2/bin/gtk-update-icon-cache
    Target /usr/local/bin/gtk-update-icon-cache already exists. You may need
    to delete it.
    To force the link and overwrite all other conflicting files, do:
      brew link --overwrite formula_name

      To list all files that would be deleted:
        brew link --overwrite --dry-run formula_name
        [гром][brian local](master)$ ls -l
        /usr/local/bin/gtk-update-icon-cache
        lrwxr-xr-x  1 brian  admin  48 May 24 21:59
        /usr/local/bin/gtk-update-icon-cache ->
        ../Cellar/gtk+/2.24.18/bin/gtk-update-icon-cache
        [гром][brian local](master)$ brew link --overwrite gtk+3
        Linking /usr/local/Cellar/gtk+3/3.8.2... 267 symlinks created

### Gtk-Perl Modules ###
Install order is Cairo, Glib, Pango, Gtk2, Glib::Object::Introspection, Gtk3

For Lion with built-in X server, use `/usr/X11/lib/pkgconfig/` for the path to
`pkg-config` files.
- With existing PKG_CONFIG_PATH:
  - `export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/usr/X11/lib/pkgconfig`
- No existing PKG_CONFIG_PATH:
  - `export PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig`

For Mavericks with XQuartz, use `/opt/X11/lib/pkgconfig` for the path to
`pkg-config` files.
- With existing PKG_CONFIG_PATH:
  - `export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/opt/X11/lib/pkgconfig`
- No existing PKG_CONFIG_PATH:
  - `export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig`

The module **Cairo::GObject** needs to use the `Cairo` that's been built with
`--with-gobject` support.  XQuartz supplies a version of `Cairo`, but without
GObject support.  Changing the order of the `PKG_CONFIG_PATH` environment
variable should make everything happy.

    cpanm Cairo
    cpanm Glib
    cpanm Pango
    cpanm Glib::Object::Introspection
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH cpanm Gtk2
    # Homebrew PKG_CONFIG_PATH first, then XQuartz PKG_CONFIG_PATH
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH \
      cpanm Cairo::GObject
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH \
      GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0/ \
      cpanm Gtk3

When running `Gtk3` scripts, `GI_TYPELIB_PATH` needs to point to the directory
that has the `.typelib` files; this is usually
`/usr/local/lib/girepository-X.X`.  Probably best to set it either in the
environment, or in scripts themselves.  There's also another directory with
`.gir` files that may be needed, to build `GTK+3` and friends I think.  The
`.gir` files are located at `/usr/local/share/gir-1.0`.

vim: filetype=markdown shiftwidth=2 tabstop=2
