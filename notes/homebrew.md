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

### Gtk+3 ###

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig \
    ./configure --prefix="/usr/local/Cellar/gtk+3/3.8.2" --disable-debug \
    --enable-introspection=yes --enable-gtk-doc

vim: filetype=markdown shiftwidth=2 tabstop=2
