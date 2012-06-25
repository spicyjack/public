## Links ##
- http://tldp.org/HOWTO/LDAP-HOWTO/moreonldif.html
- http://www.openldap.org/doc/admin24/
- http://www.openldap.org/doc/admin24/quickstart.html
- http://www.zytrax.com/books/ldap/

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

# vim: filetype=markdown tabstop=2
