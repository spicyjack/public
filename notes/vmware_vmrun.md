# VMWare's vmrun tool #

Command location: `/Applications/VMware\ Fusion.app/Contents/Library/vmrun`

Documentation on `vmrun`: http://www.vmware.com/pdf/vix180_vmrun_command.pdf

Setup
- Alias `/Applications/VMware\ Fusion.app/Contents/Library/vmrun` to `vmrun`

## Get help with the `vmrun` command #

    vmrun | $PAGER

## Start a VM ##

    vmrun start /Path/to/VMware/Virtual/Machine.vmwarevm

## List Snapshots ##

    vmrun listSnapshots /Path/to/VMware/Virtual/Machine.vmwarevm

## Create Snapshot ##

    vmrun snapshot /Path/to/VMware/Virtual/Machine.vmwarevm snapshot_name

## Merging Snapshots ##

http://tinyurl.com/a723odx

## Connecting via rdesktop ##

    rdesktop -g 900x700 -a 16 -u administrator <hostname>

# vim: filetype=markdown shiftwidth=2 tabstop=2
