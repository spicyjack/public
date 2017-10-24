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

vim: filetype=markdown shiftwidth=2 tabstop=2
