# Docker #

## Links ##
- Installation
  - https://docs.docker.com/installation/mac
  - https://docs.docker.com/installation/debian/
- Using Docker
  - https://docs.docker.com/userguide/
- Installing on Linode
  - https://filippo.io/customizing-a-linode-kernel/
  - https://github.com/docker/docker/issues/629
  - https://www.linode.com/docs/tools-reference/custom-kernels-distros/run-a-distributionsupplied-kernel-with-pvgrub/
  - https://www.linode.com/docs/applications/containers/docker

## Notes ##
- On OS X, you can install both _Docker_ and `boot2docker` from `brew`
  - `brew install docker boot2docker`

## boot2docker ##
App for running Docker on OS X.  Uses a minimal Linux install running under
VirtualBox to simulate "running" Docker.

### Links ###
- http://boot2docker.io/

### Commands ###
- `boot2docker help` - Shows full help and options
- `boot2docker status` - Shows current `boot2docker`/Docker VM status
- `boot2docker info` - Shows extended info about VM
- `boot2docker ip` - Shows IP address of VM, so you can SSH to the VM, and so
  the `docker` command can be run correctly
- `boot2docker [up|start]` - Start the `boot2docker`/Docker VM
- `boot2docker [down|stop]` - Stop the `boot2docker`/Docker VM
- `boot2docker [save|suspend]` - Suspend the `boot2docker`/Docker VM and save
  state to disk

vim: filetype=markdown shiftwidth=2 tabstop=2
