## Create ISO images in OS X ##

- Open Disk Utility
- Select the named disk image (not the drive)
- Click File -> New -> Disk image from "<named image>"
- Choose CD/DVD Master in the dropdown
- Choose a location and filename
- Click Save
- After the image has been created, convert to ISO with:
  - `hdiutil makehybrid -iso -joliet -o Master.iso Master.cdr`

vim: filetype=markdown shiftwidth=2 tabstop=2
