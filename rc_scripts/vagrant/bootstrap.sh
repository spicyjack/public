#!/bin/bash
echo "Provisioning host..."
echo "Running 'apt-get update'"
aptitude update
aptitude upgrade
echo "Installing base system packages"
apt-get --assume-yes install git vim-nox screen less bzip2 zip unzip \
    sysv-rc-conf stow libgtk2-perl kernel-package debhelper dh-make-perl
su - vagrant
mkdir src
cd src
git clone git clone https://github.com/spicyjack/rcfiles-lack.git \
    rcfiles-lack.git
