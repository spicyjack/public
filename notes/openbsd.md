## OpenBSD Notes ##

Set up your environment;

    export PKG_PATH=http://ftp3.usa.openbsd.org/pub/OpenBSD/

Installing packages;

    sudo pkg_add -v screen-4.0.3p3

Installing in interactive mode;

    sudo pkg_add -v -i screen

Listing installed pakcages;

    pkg_info

Updating installed packages

    sudo pkg_add -u <package name>

Removing packages

    sudo pkg_delete screen

Installing ports;

    cd /tmp
    ftp ftp://ftp.openbsd.org/pub/OpenBSD/5.4/ports.tar.gz
    cd /usr
    sudo tar xzf /tmp/ports.tar.gz

Searching for ports/packages

    cd /usr/ports
    make search key=<search string>

Installing a port

    cd /usr/ports/<dir>/<package name>
    make install

This builds and installs a package.
vim: filetype=markdown shiftwidth=2 tabstop=2
