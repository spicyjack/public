
## Create DMG images in OS X ##
- Open Disk Utility
- Select the named volume (not the drive)
- Click File -> New -> Disk image from "<named image>"
- Choose _compressed image_ in the dropdown
- Choose a location and filename
- Click Save

## Create ISO images in OS X ##
- Open Disk Utility
- Select the named volume image (not the drive)
- Click File -> New -> Disk image from "<named image>"
- Choose _CD/DVD Master_ in the dropdown
- Choose a location and filename
- Click Save
- After the image has been created, convert to ISO with:
  - `hdiutil makehybrid -iso -joliet -o Master.iso Master.cdr`

Convert ISO to DMG

    hdiutil convert file.iso -format UDRW -o file.dmg

Convert DMG to ISO; you'll need to rename the output file to `*.iso`, instead
of `*.iso.cdr`

    hdiutil convert imagefile.dmg -format UDTO -o imagefile.cdr
    hdiutil makehybrid -iso -joliet -o imagefile.iso imagefile.cdr

Create an install disk for Mavericks

    sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled \
    --applicationpath /Applications/Install\ OS\ X\ Mavericks.app \
    --nointeraction

Or, just use `dd` (from http://superuser.com/questions/85987):

    sudo umount /dev/disk?
    sudo dd if=/dev/disk? of=CD.iso bs=2048 conv=sync,notrunc

## Copy DMG image to Flash Disk ##
- Open Disk Utility
- Find the flash disk, and repartition it with one partition, making sure to
  choose **Apple Partition Map** or **GUID Partition Map** by clicking on the
  **Options** button
  - **Apple Partition Map** is for PPC Macs
  - **GUID Partition Map** is for Intel Macs
- Unmount the mounted partition on the flash disk by choosing it on the left
  hand side, and clicking the **Unmount** button in the toolbar
- Click on the disk image in the left hand window that you want to copy to
  flash, and click the `Restore` button
- Drag the unmounted partition from the flash disk into the `Destination:`
  box, then click **Restore**
- Once the restore is complete, the raw device should have a Connection Bus of
  `USB`, a Partition Map Scheme of `Apple Partition Map` or `GUID Partition
  Map`, and the mounted disk should have a format of `Mac OS Extended`

## Creating a bootable USB flash disk from a bootable ISO ##

    diskutil list
    # find out which device the USB drive is seen as by the OS
    diskutil unmountDisk /dev/<name of whole disk device>
    time sudo dd if=image.iso of=/dev/<name of whole disk device> bs=1m

    # example with /dev/disk2:
    diskutil unmountDisk /dev/disk2
    time sudo dd if=image.iso of=/dev/rdisk2 bs=1m

http://osxdaily.com/2015/06/05/copy-iso-to-usb-drive-mac-os-x-command/

## Creating a DMG image from a bootable USB flash disk ##
- Select the OS X installer volume on the device (OS X up to Yosemite) or the
  whole device itself (OS X Yosemite) in Disk Utility
  - Click on `New Image` in the toolbar
    - Image Format: compressed
    - Name your image file, then press `Save`

vim: filetype=markdown shiftwidth=2 tabstop=2
