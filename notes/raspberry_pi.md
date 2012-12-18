# Raspberry Pi #
See also notes/arm_projects/arm_notes.md

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


# vim: filetype=markdown shiftwidth=2 tabstop=2
