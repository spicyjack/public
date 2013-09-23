# Virtual Machine Setup #

What to put on your virtual machine after you set it up.  See also
`notes/qemu/host_setup.md`.

## Installing Debian ##
- Create 'lack' user with lack's password
- Add SSH Server in tasksel

## Basics ##
- lode-lat1u-16 font to /usr/share/consolefonts
  - URL: 
  - install console-setup, edit /etc/default/console-setup, then run 'setupcon'
- GRUB splashscreen image
  - URL:
  - what does the filename need to be?
  - where should the file be located?
- Install any extra packages
  - locales
  - loop-aes-utils
  - less
  - bzip2
  - lvm2
  - vim-nox
  - screen
  - git
  - zip
  - sudo
  - linuxlogo
- linuxlogo
  - trim the logo down/add newlines so it doesn't wrap off the screen and
    screw up the swirl
    - there's a few linux_logo.conf files floating around in places; try lack
  - test by catting /etc/issue.linuxlogo
  - add to /etc/inittab when it's done
- config files
  - URL: 
  - bashrc.d
  - vimrc
  - dircolors
- SSH authorized keys
- Add 'lack' to 'sudo' group in /etc/group

# vim: filetype=markdown tabstop=2
