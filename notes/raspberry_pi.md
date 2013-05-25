# Raspberry Pi #
See also `arm_notes.md`

## Setting up the default Raspbian image ##
- Run `apt-get update`
- Install new window manager, then update-alternatives x-window-manager
- Install new terminal emulator
- Create `~/.ssh` and add `authorized_keys`
- Install `git` and clone `rcfiles-lack`
- Remove LXDE packages
  - lxde-common lxde-core lxde lxappearance lxde-icon-theme lxinput
    lxmenu-data lxpanel lxpolkit lxrandr lxsession lxsession-edit lxshortcut
    lxtask lxterminal libfm1 libfm-gtk1 libfm-gtk-bin pcmanfm
- Install new packages
  - vim linuxlogo console-tools cvs git screen less bzip2 zip unzip
    kernel-package debhelper dh-make-perl fluxbox zenity libgtk2-perl
    libdancer-perl sqlite3 sqlite3-doc libdbd-sqlite3-perl
- If you install a session manager by mistake, you can remove it from
  `/etc/init.d` with:
  - `sudo update-rc.d -f <session manager package name> remove`

## Alternate Host Setup ##
In the `raspi-config` setup tool:
- Expand rootfs
- Change the password to be the default `lack` password
- Set up locales
  - Set up default locale to be `en_US.UTF-8`
- Set up the timezone
- Start the SSH server
- Update the `raspi-config` setup tool
- Reboot

After the system comes up, set up the `pi` user
- Install `authorized_keys` file
- Set up `.bashrc`
- Start setting up the machine based on
  `personal.git/notes/qemu/host_setup.md`
- Install the following packages:


    autofs vim-nox console-tools git-core screen bzip2 zip unzip 
    sysv-rc-conf stow linuxlogo cvs fluxbox slim zenity libgtk2-perl
    kernel-package debhelper dh-make-perl

For *Jenkins*, use the setup notes in `personal.git/notes/jenkins/notes.md`.
Test SSH connectivity after setting up the user and dropping the SSH key into
the `jenkins` user's home directory.

## Links ##
- http://www.raspberrypi.org/
  - Downloads 
  - http://www.raspberrypi.org/downloads
  - https://github.com/raspberrypi/quake3
    - Includes cross-compilation scripts
- Quick Start Guide
  - http://www.raspberrypi.org/quick-start-guide
- Resellers
  - Newark - http://tinyurl.com/bs7vzty
- elinux.org
  - Toolchains - http://elinux.org/Toolchains
  - RPi Advanced Setup - http://elinux.org/RPi_Advanced_Setup
  - RPi Verified Peripherals - http://elinux.org/RPi_VerifiedPeripherals
  - RPi Hub - http://elinux.org/RPi_Hub
  - RPi Software (building software for Raspberry Pi)
    http://elinux.org/RPi_Software

## Distros ##
- Raspbian
  - http://www.raspbian.org/
- Embedian
  - Cross-development toolchains
    - http://www.emdebian.org/crosstools.html
  - Embedian Toolchain
    - http://wiki.debian.org/EmdebianToolchain

## Add-on Hardware ##
- WI-PI WiFi USB dongle
  - http://www.element14.com/community/docs/DOC-48541
  - Users manual
    - http://www.element14.com/community/docs/DOC-51147

vim: filetype=markdown tabstop=2 shiftwidth=2
