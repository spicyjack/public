# Vagrant Notes #

- Homepage: http://www.vagrantup.com/
- Docs: http://docs.vagrantup.com/
- Downloads: http://downloads.vagrantup.com/
- List of publicly available boxes - http://www.vagrantbox.es/

## Creating a new box ##
Change into the directory where you want to host the VirtualBox files in, and
run:

    vagrant init [box name] [box url]
    vagrant init precise32 http://files.vagrantup.com/precise32.box
    vagrant up

- `vagrant init` creates the `Vagrantfile`, or the description of the VM
environment
- `vagrant up` launches it
  - This needs to be run from the directory that contains the `Vagrantfile`
- Use `vagrant ssh` once the VM has launched to log into it
  - Needs an SSH client installed in your path, or use PuTTY to connect to
    `localhost:2222` with a key file; use `vagrant ssh-config` to get the full
    path to the keyfile
- `vagrant box list` lists configured Vagrant instances

vim: filetype=markdown shiftwidth=2 tabstop=2
