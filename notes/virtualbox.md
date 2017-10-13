# Virtualbox Notes #

VirtualBox docs: Click on `Help -> Contents` to open the `UserManual.pdf` file

## Virtual Machine Info ##
Show all of the VMs available in _VirtualBox_

    VBoxManage list vms

Show info about a specific VM

    VBoxManage showvminfo <uuid>|<vm name>
    VBoxManage showvminfo --machinereadable <uuid>|<vm name>

## Networking Info ##
List configured _VirtualBox_ NAT networks

    VBoxManage natnetwork list

List all configured _VirtualBox_ NAT networks, with port mappings

    VBoxManage list natnets

## Setting up private NAT networks in VirtualBox ##
Add a new network (with IPv6) support

    VBoxManage natnetwork add --netname <foo> --network "192.168.15.0/24" \
      --ipv6 on --enable

Modify an existing network:

    VBoxManage natnetwork modify --netname <foo> --network "10.0.0.0/24"
    VBoxManage natnetwork modify --netname <foo> --dhcp [off|on]

Add a port forwarding rule named `sshfoo` to virtual network `baz`

    VBoxManage natnetwork modify --netname baz \
      --port-forward-4 "sshfoo:tcp:[]:1022:[192.168.15.5]:22"

Delete a port forwarding rule named `sshfoo` from virtual network `baz`

    VBoxManage natnetwork modify --netname baz \
      --port-forward-4 delete sshfoo

Start a natnetwork named `baz`

    VBoxManage natnetwork start --netname baz

Stop a natnetwork named `baz`

    VBoxManage natnetwork stop --netname baz

# vim: filetype=markdown shiftwidth=2 tabstop=2
