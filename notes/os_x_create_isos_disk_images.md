
## Create DMG images in OS X ##
- Open Disk Utility
- Select the named disk image (not the drive)
- Click File -> New -> Disk image from "<named image>"
- Choose _compressed image_ in the dropdown
- Choose a location and filename
- Click Save

## Create ISO images in OS X ##
- Open Disk Utility
- Select the named disk image (not the drive)
- Click File -> New -> Disk image from "<named image>"
- Choose _CD/DVD Master_ in the dropdown
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

## Copy DMG image to Flash Disk ##
- Open Disk Utility
- Find the flash disk, and repartition it with one partition, making sure to
  choose **Apple Partition Map** by clicking on the **Options** button
- Click on the disk image that's mounted, and click the `Restore` button
- Drag the DMG file into the `Source:` box, and the mounted disk image into
  the `Destionation:` box, then click **Restore**
- Once the restore is complete, the raw device should have a Connection Bus of
  `USB`, a Partition Map Scheme of `Apple Partition Map`, and the mounted disk
  should have a format of `Mac OS Extended`

vim: filetype=markdown shiftwidth=2 tabstop=2
