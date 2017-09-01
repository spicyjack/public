# boot2docker #

## Notes ##
- On OS X, you can install both _Docker_ and `boot2docker` from `brew`
  - `brew install docker boot2docker`

## boot2docker ##
App for running Docker on OS X.  Uses a minimal Linux install running under
VirtualBox to simulate "running" Docker.

### Links ###
- http://boot2docker.io/

### boot2docker Commands ###
- `boot2docker help` - Shows full help and options
- `boot2docker status` - Shows current `boot2docker`/Docker VM status
- `boot2docker info` - Shows extended info about VM
- `boot2docker ip` - Shows IP address of VM, so you can SSH to the VM, and so
  the `docker` command can be run correctly
- `boot2docker [up|start]` - Start the `boot2docker`/Docker VM
- `boot2docker [down|stop]` - Stop the `boot2docker`/Docker VM
- `boot2docker [save|suspend]` - Suspend the `boot2docker`/Docker VM and save
  state to disk
- `boot2docker download` - Download the latest `boot2docker.iso` image, which
  runs `docker` in a Linux VM
- `boot2docker shellinit` - Sets up the environment in the current shell so
  you can log on to the Docker instance that's running on the current host
- `boot2docker ssh` - Logs in to the running Docker VM via SSH; needs
  `boot2docker shellinit` to be run first

vim: filetype=markdown shiftwidth=2 tabstop=2
