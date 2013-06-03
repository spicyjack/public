# Homebrew Notes #

## Todo ##

## Homebrew Command Summary ##
List installed packages
- `brew list`

List files installed by a package
- `brew list <package name>`

- How to find out what files belong to which packages?
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

## Problems installing gtk-doc ##
`libxml2` needs to be installed so it also installs it's python module.

- `brew install python`
- `brew install gnome-doc-utils`
  - Edit `/usr/local/bin/xml2po` and change the bangpath to 
    `#!/usr/bin/env python`
- `brew install --with-python libxml2`
- `brew install gtk-doc`

vim: filetype=markdown shiftwidth=2 tabstop=2
