## ISC's BIND 9 Software Notes ##

## Todo ##
- Post these howtos on the net for use with cloud clicker/puppet/chef

## Ideas for what to document ##
- nslookup
  - update delete
  - update add

### Checking configuration of 'named' files in BIND9 ###
Check configuration of `named` config files with:

    sudo /usr/sbin/named-checkconf -p -z -j named.conf

Options:
- `-p`: Print out the `named.conf` and included files in canonical form if no
  errors were detected
- `-z`: Perform a test load of all master zones found in `named.conf`
- `-j`: When loading a zonefile, read the journal, if it exists

### Checking all zone files in a server under BIND9 ###

    /usr/sbin/named-checkconf -z

### Checking individual zone files BIND9 ###

    sudo /usr/sbin/named-checkzone -j -s relative <zone name> <zone file>

- `-s relative`: The style of the dumped zone file; `relative` is easier for
  humans to parse than `full`, the default
- `-j`: When loading a zonefile, read the journal, if it exists

## Fun 'rndc' commands ##
Reload BIND

    rndc reload

Get BIND stats

    rndc stats

Get BIND status

    rndc status

Get a list of TSIG keys

    rndc tsig-list

Get the status of zones in BIND

    rndc zonestatus <zone>

## Generate TSIG keys ##
You can create TSIG keys using `tsig-keygen`, if it's available on the machine

    /usr/sbin/tsig-keygen -a hmac-sha512 pq-lg.2017-11-02 \
      | sudo tee /etc/bind/key.pq-lg.2017-11-02

    /usr/sbin/tsig-keygen -a hmac-sha512 rndc-key \
      | sudo tee /etc/bind/rndc.key

You can also use `dnssec-keygen` to generate TSIG keys

    sudo dnssec-keygen -a hmac-md5 -b 512 -n HOST lg-oc

- `-a` - algorithm type
- `-b` - number of key bits
- `-n` - key type
- See `dnssec-keygen` manpage for a list of valid bit sizes and key types

Create a new TЅIG shared secret file on both machines.  The contents the
shared secret file consists of the "Key:" string from the \*.private file,
along with a description of the key format.  The new key file should look
something like this:


    key host1-host2 {
      algorithm hmac-sha256;
      secret "La/E5CjG9O+os1jq0a2jdA==";
    };


# vim: filetype=markdown shiftwidth=2 tabstop=2
