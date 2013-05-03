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

`vagrant init` creates the `Vagrantfile`, or the description of the VM
environment, and `vagrant up` launches it.

vim: filetype=markdown shiftwidth=2 tabstop=2
