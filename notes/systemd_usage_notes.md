## CentOS/Red Hat 7 Usage Notes ##

### Links ###
- Managing System Services (Red Hat)
  - http://red.ht/1Vg0Giy
- Common administrative commands in Red Hat Enterprise Linux 5, 6 and 7
  - https://access.redhat.com/articles/1189123
- Red Hat Linux Security Guide
  - http://tinyurl.com/kn2g5mz
- SELinux Users and Administrator's Guide; how to disable SELinux
  - http://tinyurl.com/htdpr2z
  - Edit `/etc/selinux/config`

### Starting/Stopping Services ###
To get the status of a service

    systemctl status <service name>

To stop a service

    systemctl stop <service name>

To start a service

    systemctl start <service name>

To restart a service (no matter what)

    systemctl restart <service name>

To restart a service (only if it was previously running)

    systemctl try-restart <service name>

To reload the configuration for a service

    systemctl reload <service name>

To restart a service after making changes to that service or a dependency

    systemctl reload-or-restart <service name>

To display the enabled services in a "tree"

    systemctl status

Display status of all services

    systemctl list-units --type service --all

To show all unit files

    systemctl list-unit-files

To show dependencies for a service

    systemctl list-dependencies <service name>

To enable a service

    systemctl enable <service name>

To enable a service and immediately start it

    systemctl enable --now <service name>

To disable a service

    systemctl disable <service name>

To enable a service and immediately stop it

    systemctl enable --now <service name>


To mask a service (strongly disable)

    systemctl mask <service name>

To unmask a service

    systemctl unmask <service name>

To show all installed services

    systemctl --all

List what services are active

    systemctl

Unit files are located in:

    /usr/lib/systemd/system

## Apache ##
For Apache, the `apachectl` script can be used to run `configtest`

    sudo /usr/sbin/apachectl configtest

## firewalld ##
To check to see if `firewalld` is enabled (versus `iptables`):

    systemctl status firewalld
    firewall-cmd --state

