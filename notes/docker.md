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

## Installation ##
You can install _Docker_ on _macOS_ from a package supplied by the _Docker_
team, or from _Homebrew_.

### Docker Commands ###
Docker info
- `docker info` - Shows info about Docker on the host system
- `docker ps` - List running images
- `docker ps --all` - List *all* running images, including images that aren't
  currently running

Running things, connecting to running containers
- `docker run <image>:<version> <command> <arguments>` - Launches a
  Docker session, runs the listed command
- `docker run -t -i <image>:<version> <command> <arguments>` - Launches
  an interactive session, keeps control of the TTY, then passes control of the
  terminal to the Docker process

Running things, deleting image when the command exits
- `docker run --rm <image>`

Running things in existing running containers
- `docker exec --tty <image> /bin/echo foo`

Running more complex things
- `docker exec --tty <image> sh -c "echo 'SHOW DATABASES;' | \
    /usr/bin/mysql -u root -h 127.0.0.1 --database='mysql'"`

Running a container and piping a file to that container
- `docker exec --interactive <image> /usr/bin/mysql --user=root \
    --host=127.0.0.1 --password='changeme' < cora_db_init.sql`

Getting a shell in a running Docker container
- `docker exec --tty --interactive [<container name>|<container ID>] bash`

Getting info about a running Docker container, or about a Docker image
- `docker inspect [<container ID>|<container name>|<image name>]`

Filtering the output of `docker inspect` (via `jq`)
- Note: requires having the `jq` binary installed
- `docker inspect <container [ID|name]> | jq '.[] | {"Mounts"}'`

Stopping a container
- `docker stop <image name>`

Docker Images
- `docker images` - Shows available Docker images that can be launched
- `docker images -a` - Shows all local Docker images, images that can be
  launched, and "dangling images"
- `docker images -f dangling=true` - Shows only dangling images
- `docker rmi "Image"` - Removes an image named "Image"
- `docker rmi $(docker images -f dangling=true -q)` - Removes dangling images
- `docker rmi $(docker images -a -q)` - Removes all images
- `docker pull <image name>` - Downloads the listed image; you can see
  the downloaded image with `sudo docker images`
- `docker login` - Logs in to Docker Hub; saves credentials in `~/.dockercfg`
  in the Docker VM
- `docker search <search string>` - Searches for a Dockerized application
- `docker pull <imagename>` - Pulls an image described by a Dockerfile

Links
- https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

vim: filetype=markdown shiftwidth=2 tabstop=2
