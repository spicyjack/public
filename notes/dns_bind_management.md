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
