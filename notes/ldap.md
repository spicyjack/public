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

    ldapsearch -H ldap://ldap.example.com \
      -x -b '' -s base '(objectClass=*)' namingContexts

Same search, remote host, using a 'binddn' user and password in a file

    # write the password to a file
    echo -n "foobarbaz" > ~/creds/example.query_user.pass_only.txt
    chmod 600 ~/creds/example.query_user.pass_only.txt

    # run the search
    ldapsearch -H ldap://ldap.example.com \
      -D 'query_user@example.com' \
      -y ~/creds/example.query_user.pass_only.txt \
      -x -b '' -s base '(objectClass=*)' namingContexts


## Active Directory LDAP Queries ##
List all catalogs in the global directory

    ldapsearch -H ldap://ldap.example.com \
      -D 'query_user@example.com' \
      -y ~/creds/example.query_user.pass_only.txt \
      -x -b '' -s base '(objectClass=*)' namingContexts

List all entries in the 'Users' OU

    ldapsearch -H ldap://ldap.example.com \
      -D 'query_user@example.com' \
      -y ~/creds/example.query_user.pass_only.txt \
      -x \
      -b 'ou=Users,ou=DOMAIN,dc=example,dc=com' \
      -s sub '(objectClass=*)' namingContexts

List all entries in the 'Computers' OU

    ldapsearch -H ldap://ldap.example.com \
      -D 'query_user@example.com' \
      -y ~/creds/example.query_user.pass_only.txt \
      -x \
      -b 'ou=Computers,ou=DOMAIN,dc=example,dc=com' \
      -s sub '(objectClass=*)' namingContexts


List all users that have their accounts disabled

    ldapsearch -H ldap://ldap.example.com \
      -D 'query_user@example.com' \
      -y ~/creds/example.query_user.pass_only.txt \
      -x \
      -b 'ou=Users,ou=DOMAIN,dc=example,dc=com' \
      -s sub \
      '(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))' namingContexts

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

# vim: filetype=markdown tabstop=2
