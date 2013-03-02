## Perl mirrors ##
- set in /opt/local/var/macports/sources/rsync.macports.org/release/ports/\_resources/port1.0/fetch/mirror_sites.tcl

'resources' above should have an underscore prefixed to it

## Default version of Perl ##
- set in /opt/local/var/macports/sources/rsync.macports.org/release/tarballs/ports/\_resources/port1.0/group/perl5-1.0.tcl

## Troubleshooting missing Perl module dependencies ##
Run `port rdeps p5-package-name`, and usually, it will print out any missing
port files at the very top of the output.

## mjpegtools ##
From: https://trac.macports.org/ticket/32207

    port -sv install mjpegtools configure.compiler=llvm-gcc-4.2

## launchctl ##
- launchctl and !MacPorts - http://tinyurl.com/6benazm 

To start a program that's installed via MacPorts, you can either use
`launchctl`:

    launchctl load -w /Library/LaunchDaemons/org.macports.slapd.plist

or you can use the name of the port with the `port` command:

    sudo port load openldap

To stop a program that's installed via MacPorts, you can either go through
`launchctl`:

    launchctl remove org.macports.slapd

or you can use the name of the port with the `port` command:

    sudo port unload openldap

# vim: filetype=markdown tabstop=2
