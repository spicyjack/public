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
## DNS/BIND9 Management ##

## Todo ##
- Post these howtos on the net for use with cloud clicker/puppet/chef

## Ideas for what to document ##
- nslookup
  - update delete
  - update add
- TSIG access control
- DNSSEC signing of zone files

## Creating keys ##
B9ARM: http://tinyurl.com/bt389nr
- sudo dnssec-keygen -a hmac-md5 -b 512 -n HOST lg-oc
  - -a is algorithm type
  - -b is number of bits; see dnssec-keygen manpage for a list of valid bit
    sizes
  - -n is the key type; see dnssec-keygen manpage for a list of valid key
    types
  - <name of the keyfile>
- Create a new shared secret file on both machines.  The contents the shared
  secret file consists of the "Key:" string from the \*.private file, along
  with a description of the key format.  The new key file should look
  something like this:


    key host1-host2 {
      algorithm hmac-sha256;
      secret "La/E5CjG9O+os1jq0a2jdA==";
    };


## Adding subdomains ##
- Add the subdomain to the named.conf.local file
  - add the zone{} block
    - master/slave
    - add masters/allow-transfer
    - add allow-update to master with a list of allowed TSIG keys
  - add the server{} block
    - describes a keypair between this server and another server

# vim: filetype=markdown tabstop=2
