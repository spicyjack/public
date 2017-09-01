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

## Installation ##
- https://pilsniak.com/how-to-install-docker-on-mac-os-using-brew/

You can download the _Docker_ DMG and install from there, or install via
_Homebrew_

### Docker Commands ###
- `docker info` - Shows info about Docker on the host system
- `docker images` - Shows available Docker images that can be launched
- `docker ps` - List running images
- `docker run <image>:<version> <command> <arguments>` - Launches a
  Docker session, runs the listed command
- `docker run -t -i <image>:<version> <command> <arguments>` - Launches
  an interactive session, keeps control of the TTY, then passes control of the
  terminal to the Docker process
- `docker pull <image name>` - Downloads the listed image; you can see
  the downloaded image with `sudo docker images`
- `docker login` - Logs in to Docker Hub; saves credentials in `~/.dockercfg`
  in the Docker VM
- `docker search <search string>` - Searches for a Dockerized application
- `docker pull <imagename>` - Pulls an image described by a Dockerfile

vim: filetype=markdown shiftwidth=2 tabstop=2
