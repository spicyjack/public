## Ansible Notes ##

Tagged releases: http://ansibleworks.com/releases

Prerequisites:
- python-jinja2 python-yaml python-paramiko 
  - Install with `aptitude` to catch dependencies

You can make Debian packages with `make debian` in the source tree.  Currently
(26Aug2013), this doesn't work.

Instead, check out the git tree, and run:

    cp -r packaging/debian ./
    chmod 755 debian/rules
    fakeroot debian/rules clean
    fakeroot dh_install
    fakeroot debian/rules binary


vim: filetype=markdown shiftwidth=2 tabstop=2
