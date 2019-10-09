# Docker #

## Links ##
- Installation
  - https://docs.docker.com/installation/mac
  - https://docs.docker.com/installation/debian/
- Using Docker
  - https://docs.docker.com/userguide/

## Installation ##
You can install _Docker_ on _macOS_ from a package supplied by the _Docker_
team, or from _Homebrew_.

### Getting Info ###
Show info about Docker on the host system

    docker info

Get a list of currently running _Docker_ containers

    docker ps
    docker container ls

Get a list of currently running and recently exited containers

    docker ps --all
    docker container ls --all

Get a list of running containers, pretty-printed

    docker ps --format "table {{.Names}}\\t{{.Image}}\t{{.Command}}"


### Starting Docker Containers ###
Launch a Docker session, runs the listed command

    docker run <image>:<version> <command> <arguments>

Launch an interactive session, keeps control of the TTY, then passes control
of the terminal to the Docker process

    docker run --tty --interactive <image>:<version> <command> <arguments>

Running things, deleting image when the command exits

    docker run --rm <image>


### Getting info about a running container ###
Get info about a currently running container

    docker inspect [<container ID>|<container name>]

Get specific info about a currently running container (via `jq`)

    docker inspect [<container ID>|<container name>] | jq '.[] | {"<block>"}'
    docker inspect [<container ID>|<container name>] | jq '.[] | {"Mounts"}'

List the environment variables that the container was started with (via `jq`)

    docker inspect [<container ID>|<container name>] | jq '.[] | {"Env"}'

List the network ports that are mapped from the container to the host (via
`jq`)

    docker inspect [<container ID>|<container name>] | jq '.[] | {"Ports"}'

List the "bind mounts" or "volumes" of a running container (via `jq`)

    docker inspect [<container ID>|<container name>] | jq '.[] | {"Mounts"}'


### Running programs inside of a running container ###
Running things in existing running containers

    docker exec --tty [<container ID>|<container name>] /bin/echo foo

Running more complex things

    docker exec --tty <image> sh -c "echo 'SHOW DATABASES;' | \
      /usr/bin/mysql -u root -h 127.0.0.1 --database='mysql'"

Running a container and piping a file to that container

    docker exec --interactive <image> /usr/bin/mysql --user=root \
      --host=127.0.0.1 --password='changeme' < db_init.sql

Getting a shell in a running Docker container

    docker exec --tty --interactive [<container name>|<container ID>] bash

Listing files inside of a container

    docker exec --tty --interactive [<container ID>|<container name>] ls /


### Stopping a container ###
Get a list of existing containers, then run:

    docker stop [<container ID>|<container name>]


### Deleting a container ###
Get a list of existing containers, then run:

    docker rm <container ID>


## Docker Images ##
Get a list of downloaded images

    docker images
    docker image ls
    docker image list

Show all local Docker images, images that can be launched, and "dangling
images"

    docker images -a
    docker image ls -a
    docker image list -a

Show only dangling images

    docker images -f dangling=true
    docker image ls -f dangling=true
    docker image list -f dangling=true

Build a Docker image from a `Dockerfile` in the current directory

    docker build --tag=footest:1

Getting info about a running Docker container, or about a Docker image (see
also "Getting Info" above)

    docker inspect [<container ID>|<container name>|<image name>]

Deleting a Docker image

    docker rmi <image ID>

Remove dangling images

    docker rmi $(docker images -f dangling=true -q)

Removes all images

    docker rmi $(docker images -a -q)

## Docker Hub ##
Downloads the listed image; you can see the downloaded image with `docker images`

    docker pull <image name>

Log in to Docker Hub (saves credentials in `~/.dockercfg`)

    docker login

Searches for a Dockerized application

    docker search <search string>

Pulls an image described by a Dockerfile

    docker pull <imagename>

## Links ##
- https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

vim: filetype=markdown shiftwidth=2 tabstop=2
