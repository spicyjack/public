## Links ##
- http://tldp.org/HOWTO/LDAP-HOWTO/moreonldif.html
- http://www.openldap.org/doc/admin24/
- http://www.openldap.org/doc/admin24/quickstart.html
- http://www.zytrax.com/books/ldap/

## Querying LDAP ##
Basic query to see if the LDAP server running on the same machine is
functioning correctly:

    ldapsearch -x -b '' -s base '(objectclass=\*)' namingContexts

Same search, remote host

    ldapsearch -x -b '' -s base '(objectclass=\*)' namingContexts

### ldapsearch options ###
- `-x` - Simple auth, not SASL auth
- `-b` - Search base, or where in the LDAP tree to start search queries
- `-s` - Search scope, one of `{base|one|sub|children}`
- `(filter)` - The string used to filter search results
- `attr` - The LDAP attribute to search for

## Creating initial LDAP organization entries ##
Create a text file that contains the following:

    dn: dc=example,dc=org
    objectClass: dcObject
    objectClass: organization
    o: example
    cn: example

    dn: cn=Manager,dc=example,dc=org
    objectclass: organizationRole
    cn: Manager

## Adding organization .ldif file to LDAP ##

    ldapadd -x -D "cn=Manager,dc=example,dc=org" -W -f org.ldif
    ldapadd -x -D "cn=Manager,dn=example,dn=org" -W -f example.ldif \
      -H ldap://host.example.org

### ldapadd options ###
- `-x` - Simple auth, not SASL auth
- `-D` - bind DN, or the "identity" of the user making changes in the LDAP
  directory
- `-W` - Prompt for simple authentication
- `-f` - File (in `.ldif` format) to read directory modifications from
- `-H` - LDAP URI to connect to; example: `ldaps:///example.com:636`

## Creating initial users in LDAP ##
Create a text file that contains the following:

    # First User
    dn: cn=First User,dc=example,dc=org
    cn: First User
    cn: 1st User
    objectClass: person
    sn: User

    # Second User
    dn: cn=Second User,dc=example,dc=org
    cn: Second User
    cn: 2nd User
    objectClass: person
    sn: User


## Set up rsyslog to log slapd to a separate file ##
Edit /etc/rsyslog.conf, set the following:

    # logging for slapd; leading dash disables write sync
    local4.debug     -/var/log/slapd.log

Change:

    *.=debug;\
        auth,authpriv.none;\
        news.none;mail.none -/var/log/debug

to:

    *.=debug;\
      auth,authpriv.none;\
      news.none;mail.none;\
      local4.none -/var/log/debug

Restart `rsyslog` for your changes to take effect.

## Installing the MacPorts openldap daemon ##
- launchctl and !MacPorts - http://tinyurl.com/6benazm
- http://old.nabble.com/Problems-with-startup-on-OpenLDAP-td23262775.html

- Install openldap via macports
- Create the directory `/opt/local/var/run/slapd`, and change ownership of
  that directory so it's owned by user `ldap`
- Make a copy of the sample config file
  `/opt/local/etc/openldap/slapd.conf.sample`, and make the following changes
  - `pidfile` should be `/opt/local/var/run/slapd/slapd.pid`
  - `argsfile` should be `/opt/local/var/run/slapd/slapd.args`
  - Change the `suffix` and `rootdn` to match the domain that this copy of
    `slapd` will be used with
  - `directory` should be `/opt/local/var/run/openldap-data`

## Starting MacPorts OpenLDAP daemon ##

    sudo port load openldap

## Stopping Macports OpenLDAP daemon ##

    sudo port unload openldap

# vim: filetype=markdown tabstop=2
