# Android/Android Studio Notes #

## URLs ##
- https://developer.android.com/training/index.html
- Run Apps on a hardware device
  - https://developer.android.com/studio/run/device.html
- Android Debug Bridge
  - https://developer.android.com/studio/command-line/adb.html
  - https://www.shredzone.de/cilla/page/374/validating-the-android-422-rsa-fingerprint.html

## Android Virtual Devices ##
A virtual device needs to be set up in Android Studio before you can try and
run projects.

To set up a virtual device, click on the AVD icon in the toolbar of the IDE
(looks like a phone with an android icon peeking up over the bottom), or
navigate to `Tools -> Android -> AVD Manager`

## Android Debug Bridge ##
Android Debug Bridge (adb) is a versatile command line tool that lets you
communicate with an emulator instance or connected Android-powered device.

(https://developer.android.com/studio/command-line/adb.html)

Commands:
- `adb devices`
  - List devices connected to/emulated on the computer it's run from
  - The first time you connect a new device to the computer, the device will
    show in `adb` as "unauthorized"; you need to unlock the device and follow
    the prompts provided by the device in order to authorize it to be used
    with the computer that it's connected to
  - You can show the computer's current ADB RSA key with this command:
    - `cat ~/.android/adbkey.pub | awk '{print $1}' \
          | openssl base64 -A -d -a | openssl md5 -c`

vim: filetype=markdown shiftwidth=2 tabstop=2
