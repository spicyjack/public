# Writing Frameworks For Apple Operating Systems #

## Xcode Workspaces ##
If you put your frameworks and apps together inside of a single workspace,
_Xcode_ will generally taked care of app/project dependencies for you, and you
will be able to run the app both on the simulator and a real device

- https://objectivetidbits.com/multi-project-setups-fee9d235d857
- https://developer.apple.com/library/archive/samplecode/UnitTests/Introduction/Intro.html

## Embedding a framework in another project ##
Adding new classes to the framework...
- Create a folder for new classes called "Classes"
- Click on the new "Classes" folder
- File -> New File, choose "Cocoa Touch Class"
- Enter the name of your class, choose "Next"
- Click the "Create" button on the next screen if all of the paths look
  correct
- Add the filenames of the header files to the framework's public header file
  - For a framework named "FooFramework", the public header file could be
    named `FooFramework.h`
  - Add the header files for new classes to the public header file as `#import
    "ClassName.h"`
- Mark any new headers that you create in the framework as "public"
  - Click on each header file
  - In the _Inspector_ pane, look for the section "Target Membership"
  - The header's visibility in the framework target will be shown, by default
    it will be "Project"
  - Change the dropdown in the framework target for the header from "Project"
    to "Public"
- After changing the visibility for a header, you may have to perform an
  action in _Xcode_ (Build, Test, Run) in order to get rid of the _Xcode_
  errors
- Adding valid architectures for the framework
  - Project -> Targets -> FrameworkName
  - Search for "Valid Architectures"
  - Press the "+" sign to the right of the word "Debug"
  - Set the dropdown in the line that appears to "Any iOS Simulator SDK"
  - Set the value for "Any iOS Simulator SDK" to "x86_64"
  - Press the "+" sign to the right of the word "Release"
  - Set the dropdown in the line that appears to "Any iOS Simulator SDK"
  - Set the value for "Any iOS Simulator SDK" to "x86_64"

Adding tests for new classes in the framework...
- Open the test implementation file
- Add the headers for the classes being tested
  - `#import "FrameworkName/ClassName.h"`
- In the test file(s), add objects from the framework, and start writing tests
  for them

Adding the framework to the app...
- Run a build of the framework (`⌘ - B`)
- Show the location of the framework in _Finder_, so you can drag/drop it to
  the app project
  - In the framework project, click on `Products -> Framework` in the "Project
    navigator"
  - Right click on the framework object, choose `Show in Finder`
- Drag and drop the framework object icon in _Finder_ into the "Project
  navigator" box for the app project
  - In the dialog box that pops up, check the "Copy items if needed" checkbox
    if it's unchecked
  - Add the framework to the test target, if you use that framework in your
    tests (probably yes)
  - Click on the "General" tab of the "target" app, and scroll down to
    "Embedded Binaries"
  - Click on the "+" sign in the "Embedded Binaries" section to add the
    framework previously dragged/dropped from _Finder_ to the "Link Binary
    with Libraries" section
  - The dragged/dropped framework can show up multiple times in the "Linked
    Frameworks and Libraries" section of the "General" tab; feel free to
    delete extra copies of the framework from that section so that only one
    copy is shown

Verify that the framework is listed in the correct places in _Xcode_
- Targets -> "AppName" -> General
  - Embeded Binaries
  - Linked Frameworks and Libraries
- Targets -> "AppName" -> Build Phases
  - Link Binary with Libraries
  - Embed Frameworks

Adding new classes to the app...
- Create a folder for new classes called "Classes"
- Click on the new "Classes" folder
- File -> New File, choose "Cocoa Touch Class"
- Enter the name of your class, choose "Next"
- Click the "Create" button on the next screen if all of the paths look
  correct

Writing tests for classes in the framework and in the app...
- For classes in the app that need to create objects that live in the imported
  framework, `#import` the header for the framework in the header for each
  class that needs to create objects using that framework
  - `#import <FrameworkName/FrameworkName.h>`

If your app crashes...
- Verify that the embedded framework is listed in the "Embedded Binaries"
  section of the "General" tab of the app's target
  - https://stackoverflow.com/questions/24333981/ios-app-with-framework-crashed-on-device-dyld-library-not-loaded-xcode-6-beta
  - https://stackoverflow.com/questions/26024100/dyld-library-not-loaded-rpath-libswiftcore-dylib

vim: filetype=markdown shiftwidth=2 tabstop=2

