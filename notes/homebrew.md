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

To have launchd start mysql at login:

    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

Then to load mysql now:

    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

Or, if you don't want/need launchctl, you can just run:

    mysql.server start

## Homebrew problems encountered ##
- `libtiff` not linking it's `include` files
  - `brew unlink libtiff && brew link libtiff`

## Compiling a Gtk+3 stack under Homebrew ##

### libgobject-introspection ###
- Install, and use `brew link --force gobject-introspection` to create the
  `gir/girepository` links back to `gobject-introspection`

### libcairo ###
- Install `cairo` via Homebrew
  - `brew install --with-glib cairo`
- Force link the `cairo` library
  - `brew link --force cairo`

### libatk ###

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
      ./configure --prefix=/usr/local/Cellar/atk/2.8.0 \
      --enable-introspection=yes

### libpango ###

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
      ./configure --prefix=/usr/local/Cellar/pango/1.34.1 \
      --enable-introspection=yes

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
      ./configure --prefix=/usr/local/Cellar/glib/2.36.3 \
      --enable-introspection=yes

### gdk-pixbuf ###

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    GI_TYPELIB_PATH=/usr/local/share/gir-1.0 \
    ./configure --prefix=/usr/local/Cellar/gdk-pixbuf/2.28.1 \
      --disable-dependency-tracking --disable-maintainer-mode \
      --enable-debug=no --enable-introspection=yes \
      --disable-Bsymbolic --without-gdiplus


### libgtk3 ###

    XML_CATALOG_FILES="/usr/local/etc/xml/catalog" \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig \
    ./configure --prefix="/usr/local/Cellar/gtk+3/3.8.2" --disable-debug \
    --enable-introspection=yes --enable-gtk-doc

- Had to enable introspection on Pango, Cairo, Gdk-pixbuf, Atk, etc.
- Had to mangle something in the Gtk3 source tree (I think docs/gtk/) to get
  Gtk3 to install.  It could have been the docbook catalog in
  /usr/local/etc/xml.


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

### Pango, Cairo and Gtk2 Perl Modules ###

    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig/ perl Makefile.PL cpanm Pango
    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig/ perl Makefile.PL cpanm Cairo
    PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig/ perl Makefile.PL cpanm Gtk2
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/X11/lib/pkgconfig/ \
      cpanm Cairo::GObject
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/X11/lib/pkgconfig/ \
      GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0/
      cpanm Gtk3

Gtk3 still needs to be installed by hand (`cpanm --look Gtk3`) for some reason
:/

vim: filetype=markdown shiftwidth=2 tabstop=2
