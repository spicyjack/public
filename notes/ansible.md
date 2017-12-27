## Ansible Notes ##

## Module Lists ##
- http://docs.ansible.com/ansible/latest/modules_by_category.html
- http://docs.ansible.com/ansible/latest/list_of_all_modules.html

## Howto ##
Example of running an Ansible command

    ansible <hosts> ­-module-name=<module>

Get setup information about hosts

    ansible <hosts> --module-name=setup

Connect as one user, run commands as another user

    ansible <hosts> --inventory inventory.ini \
      --module-name=setup --user=cogmed --ask-pass \
      --become --become-method=su --ask-become-pass

Execute a command in a shell

    ansible all_vms --inventory inventory.ini --ask-pass \
      --module-name shell --args "ls -la ~"

Create a directory on a remote host

    ansible all_vms --inventory inventory.ini --ask-pass \
      --module-name file \
      --args "dest=~/.ssh mode=700 state=directory"

Copy a file to a remote host

    ansible all_vms --inventory inventory.ini --ask-pass \
      --module-name copy \
      --args "src=~/.ssh/authorized_keys dest=~/.ssh/authorized_keys"

Fix borked perms on the Fedora box

    ansible all_vms --inventory inventory.ini --ask-pass \
      --module-name shell \
      --args "chmod 700 ~/.ssh; chmod 700 ~/.ssh/authorized_keys"

Get the `umask`

    ansible all_vms --inventory inventory.ini \
      --module-name shell --args "umask"

Get a list of `python-*` packages on a given host


    # Debian/Buntu - 'python-apt' is required
    ansible debian_vms --inventory inventory.ini \
        --module-name shell --args "dpkg -l | grep python | sort"

    # Red Hat/Fedora - 'python-dnf' is required
    ansible fedora_vms --inventory inventory.ini \
        --module-name shell --args "rpm -qa | grep python | sort"

Create a directory as `root` on a remote host


    ansible all_vms --inventory inventory.ini \
      --module-name file \
      --become --become-method=su --ask-become-pass \
      --args "dest=/root/.ssh mode=700 state=directory"

Copy a file on a remote host


    ansible all_vms --inventory inventory.ini \
      --module-name shell \
      --become --become-method=su --ask-become-pass \
      --args "cp ~username/.ssh/authorized_keys /root/.ssh/authorized_keys"

Change file ownership of a file on the remote host


    ansible all_vms --inventory inventory.ini --ask-pass \
      --module-name shell \
      --become --become-method=su --ask-become-pass \
      --args "chown root.root /root/.ssh/authorized_keys"
    ansible all_vms --inventory inventory.ini --ask-pass \
      --module-name shell \
      --become --become-method=su --ask-become-pass \
      --args "chmod 600 /root/.ssh/authorized_keys"

Verify the `/root` directory on a remote host


    ansible all_vms --inventory inventory.ini \
      --become --become-method=su --ask-become-pass \
      --module-name shell --args "ls -laR /root"

Power off all machines


    ansible all_vms --inventory inventory.ini \
      --become --become-method=su --ask-become-pass \
      --module-name shell --args "halt -p"

vim: filetype=markdown shiftwidth=2 tabstop=2
