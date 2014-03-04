## Create ISO images in OS X ##

- Open Disk Utility
- Select the named disk image (not the drive)
- Click File -> New -> Disk image from "<named image>"
- Choose CD/DVD Master in the dropdown
- Choose a location and filename
- Click Save
- After the image has been created, convert to ISO with:
  - `hdiutil makehybrid -iso -joliet -o Master.iso Master.cdr`

Convert ISO to DMG

    hdiutil convert file.iso -format UDRW -o file.dmg

Create an install disk for Mavericks

    sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled \
    --applicationpath /Applications/Install\ OS\ X\ Mavericks.app \
    --nointeraction

vim: filetype=markdown shiftwidth=2 tabstop=2
