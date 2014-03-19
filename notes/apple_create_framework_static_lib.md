## How to create both a framework and static library in one project ##

Based on:
- http://www.blackdogfoundry.com/blog/creating-a-library-to-be-shared-between-ios-and-mac-os-x/
- http://blog.pioneeringsoftware.co.uk/2011/08/05/developing-a-project-as-an-os-x-framework-and-ios-static-library-at-the-same-time/

But updated for Xcode 5, and includes renaming of the test targets that Xcode
5 automagically creates now for every new Project.

In Xcode:
- File -> New -> Project
- Choose Mac OS X -> Framework & Library -> Cocoa Framework
- Enter the name of the Project in the `Product Name` box, then click `Next`
  to create the new Project
- Click on Targets -> _<your project name>_ -> Build Settings -> Packaging
  -> Product Name, and put your Project's name in the box (instead of
  `$(TARGET)`)
  - The icon is a yellow toolbox
  - Do the same thing for _<your project name>Tests_, 
    use _<your project name>Tests_ in the Product Name box
  - The icon is a white Lego brick
  - This test target will test the **OS X** target, so you can verify this by
    looking at the `Base SDK` setting in the Architectures section
- In the `Targets` pane, Rename the Target _<your project name>_ and 
  _<your project name>Tests_, add a `.framework` extension to both targets
  (the framework target and the framework test target)
- Rename the Scheme as well
  - Product -> Scheme -> Manage Schemes
  - Click on the scheme in the box to rename it
- Build the target by pressing `⌘B`
- Commit changes to `git`

Now add the iOS target; in Xcode:
- File -> New -> Target
- Choose iOS -> Framework & Library -> Cocoa Touch Static Library
- Enter the name of the Project in the `Product Name` box, then click `Next`
  to create the new target
- In the Targets list, choose the new static Cocoa library -> Build Settings
  -> Packaging -> Product Name, and put your Project's name in the box
  (instead of `$(TARGET)`)
  - The icon is a white Greek-style building/temple
  - Do the same thing for _<your project name>Tests_, 
    use _<your project name>Tests_ in the Product Name box
  - The icon is a white Lego brick, directly below the icon for the static
    Cocoa library
  - This test target will test the **iOS** target, so you can verify this by
    looking at the `Base SDK` setting in the Architectures section
- In the `Targets` pane, Rename the Target _<your project name>_ to
  _lib<your project name>.a_ for both targets (the framework target and the
  framework test target)
- Rename the Scheme as well
  - Product -> Scheme -> Manage Schemes
  - Click on the scheme in the box to rename it
- Build the target by pressing `⌘B`
- Delete the extra _<your project name>_ and _<your project name>Tests_ groups
  in the Project navigator
  - Make sure you **Remove References**, don't actually delete the files
- Commit changes to `git`

When you are done, you should have 4 targets in the list of Targets in your
Project (_<your project name>.framework_, _<your project name>Tests.framework_,
_lib<your project name>.a_, and _lib<your project name>Tests.a_), and two
groups in the Project Navigator (_<your project name>_ and 
_<your project name>Tests_).

vim: filetype=markdown shiftwidth=2 tabstop=2
