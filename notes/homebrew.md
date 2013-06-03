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
