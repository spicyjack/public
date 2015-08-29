## Links ##
- Older phone firmware - http://ios.e-lite.org/
- Restoring multiple iOS devices - http://tinyurl.com/3qct7er

## Basics of the iOS App Testing/Release Workflow ##
- Create Certificate Signing Request for a developer certificate; upload your
  certificate to: https://developer.apple.com/ios/manage/overview/index.action
- Add your testing device ID at
  https://developer.apple.com/ios/manage/devices/index.action
  - Get the device ID either in Xcode in the Organizer, or under iTunes, on
    the device summary screen, click on the Serial number label, which will
    then change to show the device ID
- Create an "App ID" at:
  https://developer.apple.com/ios/manage/bundles/index.action
  When creating the App ID, you can put anything in the description field, but
  the Bundle Identifier needs to match what Xcode is using in the Bundle
  Identifier field of the project file.
- Create a "provisioning profile" at: 
  https://developer.apple.com/ios/manage/provisioningprofiles/index.action
  The provisioning profile uses your developer certificate, the device ID, and
  the App ID in order to create a unique identifier that will be used when
  compiling the app in Xcode.  Once you request the provisioning profile, it
  will take a minute or two before you can download it.  Once you download it,
  double click on it or drag it on the Xcode icon to add it to Xcode

### Exporting your Developer Certificate from Keychain ###
- Devices Organizer Help - http://tinyurl.com/7k8ghoq

- Right Click on the iPhone Development Certificate for your development user
- Click on 'Export' to export a bundle that includes the development
  certificate and the key to unlock that certificate
- Choose a filename for your exported certificate bundle
- Enter a password in the password box, and the same password in the Verify
  box
- Click 'OK' to save the certificate bundle

### Importing your Developer Certificate into Keychain ###
- Devices Organizer Help - http://tinyurl.com/7k8ghoq

- Click File -> Import, navigate to the exported certificate bundle, and enter
  in the password that you used when you exported the bundle

### Building your app on a real device ###
- Select the "real device" in the dropdown list of targets next to the
  Run/Stop buttons in Xcode

### Publishing your app for user testing ###
- http://tinyurl.com/83epeqs
  - Add the user's device to your team's Provisioning Portal
  - Add the user's device to the Provisioning Profile for your app
  - Archive your app in Xcode
  - Generate an IPA file for your app in Xcode
  - Send the .mobileprovision provisioning profile and the .ipa file to the
    user who is doing the testing
  - The user will drag the .mobileprovision file on to the iTunes icon
  - The user will then double-click on the .ipa file, and the app will show up
    in iTunes

### Copying app data to/from an app sandbox to your computer ###
- Copying to: http://tinyurl.com/7nmcacx
- Copying from: http://tinyurl.com/74l57aw

- Open the Organizer
- Click on the Applications section of the device you want to manage
- Click on the file or folder you want to upload/download, and hit the upload
  or download button

# vim: filetype=markdown tabstop=2
