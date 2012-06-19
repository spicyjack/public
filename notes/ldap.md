## Links ##
- http://tldp.org/HOWTO/LDAP-HOWTO/moreonldif.html
- http://www.openldap.org/doc/admin24/
- http://www.openldap.org/doc/admin24/quickstart.html
- http://www.zytrax.com/books/ldap/

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
