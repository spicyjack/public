# General Design #

## Coding Checklist ##
Things to check/think about when you're writing new code
- ability to localize
- testability (modules are written in such a way so that they can be tested
  without a lot of setup or hassle)
- creating objects; what do objects keep track of (what are the object's
  attributes), and what can objects do (what are the object's methods)

## Documenting source code ##
  - http://www.doxygen.org/
    - Clean up doxygen files - http://mattballdesign.com/blog/tag/doxyclean/
    - Using Doxygen to Create Xcode Documentation - http://tinyurl.com/7xkxfqe
  - appledoc - based on Doxygen - http://gentlebytes.com/appledoc/
    - uses Markdown as it's markup language
    - Formatting style - http://gentlebytes.com/appledoc-docs-comments/
  - Write in Markdown and convert - https://metacpan.org/module/Text::Markdown
  - HeaderDoc - http://tinyurl.com/7krgjwp
    - http://en.wikipedia.org/wiki/HeaderDoc
  - Autogsdoc - http://tinyurl.com/6cx28w
  - tohtml plugin in vim; http://tinyurl.com/6sdg53b
  - Use '#pragma mark' to mark code up for navigation from within Xcode
    - http://www.informit.com/articles/article.aspx?p=1829415&seqNum=14

## Creating Frameworks/Static Libraries ##
- Creating a library to be shared between iOS and Mac OS X
  - http://tinyurl.com/c5nrhul
- Developing Cocoa Frameworks using Xcode 4's Workspace Feature
  - http://tinyurl.com/pu9n5q2
- https://github.com/jverkoey/iOS-Framework
- Framework Programming Guide - http://tinyurl.com/cp7zt9p
  - Mentions "Universal Framework for iOS" - http://tinyurl.com/6e2nxj9
- http://www.cocoanetics.com/2010/04/making-your-own-iphone-frameworks/
- http://www.cocoanetics.com/2010/05/making-your-own-iphone-frameworks-in-xcode/
- stackoverflow; how to build a framework: http://tinyurl.com/7724ubt
- http://www.icodeblog.com/2011/04/07/creating-static-libraries-for-ios/
- stackoverflow; how to build a static library: http://tinyurl.com/25d2z8w
- http://www.noquarterarcade.com/xcode-sdl-development-setup
- http://www.noquarterarcade.com/os-x-sdl-development-command-line-setup

## Hardware links ##
  - http://stackoverflow.com/questions/4656379/bonjour-implementation-on-android
  - http://stackoverflow.com/questions/1427250/how-to-use-bluetooth-to-connect-two-iphone
  - http://arctouch.com/beamit/

## Mac OS X and iOS Common Programming Topics ##
- Core Data Programming Guide - http://tinyurl.com/b6782vc
- Finding Documentation Quickly - http://tinyurl.com/ce8mlww
- Instruments User Guide - http://tinyurl.com/6r6szns
- Unit Testing - http://tinyurl.com/7sgjq3v
- Creating custom Xcode templates
  - http://www.bobmccune.com/2012/03/04/creating-custom-xcode-4-file-templates/
    - Lots of tables with the key/value pairs that are usually used in
      property lists, and substitution values used in file templates
  - Copy Apple's default templates, and hack to suit
  - Create a new name and icon file for the template, so you don't mix them up
  - File/project template location for Mac OS X:
    - /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates
  - File/project template location for iOS:
    - /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates
  - Graphics libraries on iOS and OS X - http://tinyurl.com/aabg9fw

## iOS Documentation ##
  - License - http://tinyurl.com/7mhvwpz (Dated October 4th 2011)
  - Human Interface Guidelines - http://tinyurl.com/2alg7qc
    - UI Element Usage Guidelines; has images of all of the UI elements
      http://tinyurl.com/6gmn662
  - Coding How-Tos (list of howtos) - http://tinyurl.com/clmfkxs
  - Tools Workflow Guide for iOS - http://tinyurl.com/79rrum8
  - іOS Technology Overview - http://tinyurl.com/3qku7f9
  - iOS App Programming Guide - http://tinyurl.com/2wqg955
  - Your First iOS App - http://tinyurl.com/25qemtb
  - Your First App Store Submission - http://tinyurl.com/7fp2rz4
  - Adding runtime checks for newer symbols - http://tinyurl.com/cb2e8k5
  - SDK Compatability Guide - http://tinyurl.com/8y4h3mt
  - Developing for the App Store - http://tinyurl.com/7a2ovfj
  - View Controller Programming Guide for iOS - http://tinyurl.com/ca497nn
  - App related resources (icons, required device capabilitites) -
    http://tinyurl.com/82ueuj7
  - UIKit Keys (required device capabilities) - http://tinyurl.com/7zr7nht
  - Tech Q&A QA1686: App icons on iPad and iPhone;
    http://developer.apple.com/library/ios/#qa/qa1686/\_index.html
  - iOS Debugging Magic
    - http://developer.apple.com/library/ios/#technotes/tn2239/
  - NSLogv (Foundations reference) - http://tinyurl.com/mvh55gg
    - NSLogv string format specifiers: http://tinyurl.com/kyz783n

## iOЅ Tutorials ##
  - GKTapper - how to support leaderboards and achievements
  - WiTap - how to achieve network communication between apps using Bonjour
  - http://tinyurl.com/3frwzsn Game Kit Programming Guide - framework that
    helps you create games
  - http://news.ycombinator.com/item?id=3940429 Good iOS tutorials for 14yro's

## Mac OS X Documentation ##
  - OS X Technology Overview - http://tinyurl.com/cad5xzj
  - Cocoa Fundamentals Guide - http://tinyurl.com/a9ju5lf
  - Mac OS X Programming Guide - http://tinyurl.com/cumqrj5
  - Your First Mac App - http://tinyurl.com/a4uw59j
  - Streamline Your Apps with Design Patterns - http://tinyurl.com/atgphwc
  - Design with the User in Mind - http://tinyurl.com/awfy4on
  - Know the Core Objects of Your App - http://tinyurl.com/bu8komq
  - Meet User Expectations - http://tinyurl.com/bwf4br9
  - Prepare for App Store Submission - http://tinyurl.com/cgyt7qz
  - Mac OS X Debugging Magic
    - http://developer.apple.com/library/mac/#technotes/tn2124/

## Safari/WebKit Documentation ##
  - Safari Developer Library - http://tinyurl.com/6uhge8r
  - Getting Started with iOS Web Apps - http://tinyurl.com/72w6tzo
  - Safari CSS Visual Effects Guide - http://tinyurl.com/7k85stl
  - Safari Web Content Guide - http://tinyurl.com/7ngkusq
  - Dashcode User Guide - http://tinyurl.com/78fuxbf
  - Preparing Your Web Content for iPad - http://tinyurl.com/7ofz2qq
  - Safari Extensions Development Guide - http://tinyurl.com/b6ge4ax

### Objective-C ###
  - Objective-C Feature Availablity Index - http://tinyurl.com/nr5eujz
  - Objective-C types; 
    - Jumping Monkey - http://tinyurl.com/7ddrdmb
    - http://stackoverflow.com/questions/2107544/types-in-objective-c-on-iphone
  - Learn C for Cocoa - http://cocoadevcentral.com/articles/000081.php
  - http://www.cocotron.org/Info
  - http://rosettacode.org/wiki/Command-line_arguments#Objective-C
  - http://www.faqs.org/faqs/computer-lang/Objective-C/faq/
  - http://www.otierney.net/objective-c.html
  - http://rypress.com/tutorials/objective-c/index.html
  - Learning Objective C: A Primer - http://tinyurl.com/3s9uqxy
  - Object Oriented Programming with Objective-C - http://tinyurl.com/7xyauxz
  - Programming with Objective-C - http://tinyurl.com/qa3oc5o
    - Has examples of object literals for NSArray, NSDictionary
  - Cocoaheads object literals: http://tinyurl.com/7v5wtf5
  - Boxed enums in LLVM: http://clang.llvm.org/docs/ObjectiveCLiterals.html
  - `NS_ENUM` in 10.8/iOS 6: http://nshipster.com/ns_enum-ns_options/
  - Concepts in Objective-C Programming - http://tinyurl.com/bhcotgw
  - The Objective C Programming Language - http://tinyurl.com/2ex4ezy
    - Protocols - http://tinyurl.com/7u6m7rp
    - Declared proerties - http://tinyurl.com/7jqfyff - includes property
      declaration attributes (strong, weak, copy, assign, retain, etc.)
    - Defining Classes (@interface/@implementation) -
      http://tinyurl.com/8x8mrrw
    - Blocks Programming Topics - http://tinyurl.com/3syy4vr
    - String Format Specifiers - http://tinyurl.com/n63fuj8
  - Mastering Threads on Mac OS X - http://drdobbs.com/parallel/232602177
  - The _Clockwise/Spiral Rule_ for parsing C declarations
    - http://c-faq.com/decl/spiral.anderson.html

### C Programming ###
  - Unary Expressions (& \* - + ! ~)
    - http://en.wikibooks.org/wiki/C_Programming/Simple_math#Unary_expressions

## Xcode ##
- Keyboard gestures and shortcuts - http://tinyurl.com/7tnxmgd
- Xcode 4 User Guide - http://tinyurl.com/7pkzaqe
- Finding Documentation Quickly - http://tinyurl.com/ce8mlww
- LLDB Debugger - http://lldb.llvm.org/tutorial.html

## Developer Videos ##
- https://developer.apple.com/videos/wwdc/2011/
- https://developer.apple.com/videos/wwdc/2012/

## Unit Testing Docs ##
- Xcode 4 User Guide - http://tinyurl.com/7pkzaqe
  - Building and Running your code; Unit Tests - http://tinyurl.com/7wa8ulc
- iOS App Development Workflow Guide - http://tinyurl.com/7wp84dv
  - Unit Testing Applications - http://tinyurl.com/6nms3zk
- Xcode Unit Testing Guide - http://tinyurl.com/7w5zzme
  - Unit Test Macro Reference - http://tinyurl.com/byapuo8

## Community tips on iOS testing ##
- https://testflightapp.com/about/
- http://furbo.org/2008/11/12/the-final-test/ - using codesign to generate
  self-signed apps

## Using Storyboards ##
- Linking two storyboards - http://tinyurl.com/a49vxy4
- Storyboard best practices - http://tinyurl.com/avcs4dp

## Problems using UISplitView on the last Final Project
http://www.raywenderlich.com/forums/viewtopic.php?t=1546&p=10620
http://timroadley.com/2012/03/24/core-data-universal-ipad-storyboard/
http://stackoverflow.com/questions/10538231/ios-uisplitviewcontroller-with-storyboard-multiple-master-views-and-multiple
http://www.scienceathand.com/idevblogaday/adventures-in-uisplitviewcontroller-2/
http://stackoverflow.com/questions/5635267/ios-how-to-dynamically-change-detailview-in-splitview-template
http://www.perfectline.ee/blog/uisplitviewcontroller-replacing-the-detail-view
https://www.google.com/search?q=splitviewcontroller+replacing+detail+view

# vim: filetype=markdown tabstop=2 
