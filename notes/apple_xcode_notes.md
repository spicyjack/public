# Apple Xcode Notes #

## Xcode Concepts ##
- http://tinyurl.com/o3prlfu 

Xcode Project
- http://tinyurl.com/p43wjzc
- An Xcode project is a repository for all the files, resources, and
  information required to build one or more software products.
- A project contains all the elements used to build your products and
  maintains the relationships between those elements.
- It contains one or more targets, which specify how to build products.
- A project defines default build settings for all the targets in the project
  (each target can also specify its own build settings, which override the
  project build settings).

Targets
- http://tinyurl.com/q2zqfk6
- A target specifies a product to build and contains the instructions for
  building the product from a set of files in a project or workspace.
- A target defines a single product; it organizes the inputs into the build
  system - the source files and instructions for processing those source
  files - required to build that product.
- Projects can contain one or more targets, each of which produces one product.


Build Settings
- http://tinyurl.com/nhd7tcc
- A build setting is a variable that contains information about how a
  particular aspect of a product’s build process should be performed.
- For example, the information in a build setting can specify which options
  Xcode passes to the compiler.
- You can specify build settings at the project or target level.
- Each project-level build setting applies to all targets in the project
  unless explicitly overridden by the build settings for a specific target.
- Each target organizes the source files needed to build one product.
- A build configuration specifies a set of build settings used to build a
  target's product in a particular way.
- For example, it is common to have separate build configurations for debug
  and release builds of a product.

Xcode Workspace
- http://tinyurl.com/pndg7ja
- A workspace is an Xcode document that groups projects and other documents so
  you can work on them together.
- A workspace can contain any number of Xcode projects, plus any other files
  you want to include.
- In addition to organizing all the files in each Xcode project, a workspace
  provides implicit and explicit relationships among the included projects and
  their targets.

Xcode Scheme
- http://tinyurl.com/p9tl4g9
- An Xcode scheme defines a collection of targets to build, a configuration to
  use when building, and a collection of tests to execute.
- You can have as many schemes as you want, but only one can be active at a
  time.
- When you select an active scheme, you also select a run destination (that
  is, the architecture of the hardware for which the products are built).

vim: filetype=markdown shiftwidth=2 tabstop=2
