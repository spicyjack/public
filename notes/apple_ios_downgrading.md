# Apple iOS Upgrading/Downgrading #

## Software ##
- TinyUmbrella
  - http://blog.firmwareumbrella.com/change-log/
- iDownloadBlog
  - http://www.idownloadblog.com/
  - Downloads: http://www.idownloadblog.com/download/
- RedSn0w
  - http://www.idownloadblog.com/redsn0w/

## Saving SHSH Blobs with TinyUmbrella ##
- Launch TinyUmbrella
- Connect the iOS device to the computer
- Click on the `Save SHSH` button
- Repeat the process for each device

## How to load a specific version of iOS ##
**NOTE:** You will only be able to load iOS versions for which you have a
valid signature from Apple for.  What this means is that if you never ran
`TinyUmbrella` in the past in order to back up your `SHSH` blobs, you will
only be able to use the latest firmware for the current major release and
previous major release, or for the last major release for devices that are not
supported with the most current firmware.

For example, an iPod Touch 4th Gen can run iOS 7 or older, so you can load any
version of iOS 7 that you have the `SHSH` saved for, plus the last version of
iOS 6 that you have a `SHSH` saved for.

To use the "allowed" upgrade path:
- Download the `ipsw` file from Apple's server, and use the Device Manager in
  Xcode to restore that version of iOS to the device.

To use TinyUmbrella to load an older version of iOS:
- Open TinyUmbrella, select _Start TSS Server_
- Open iTunes, and hold down **Option** while clicking on the _Restore_
  button, then select the firmware file you want to load
- The device should be loaded with the ѕelected firmware file

vim: filetype=markdown shiftwidth=2 tabstop=2
