## ISC's BIND 9 Software Notes ##

### named-checkconf ###
Check configuration of `named` config files with:

    sudo /usr/sbin/named-checkconf -p -z -j named.conf

Options:
- `-p`: Print out the `named.conf` and included files in canonical form if no
  errors were detected
- `-z`: Perform a test load of all master zones found in `named.conf`
- `-j`: When loading a zonefile, read the journal, if it exists

### named-checkzone ###
Check configuration of a BIND version 9 DNS zone file files with:

    sudo /usr/sbin/named-checkzone -j -s relative <zone name> <zone file>

Options:
- `-s relative`: The style of the dumped zone file; `relative` is easier for
  humans to parse than `full`, the default
- `-j`: When loading a zonefile, read the journal, if it exists

vim: filetype=markdown shiftwidth=2 tabstop=2
