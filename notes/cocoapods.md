# CocoaPods Usage and Notes #

## Links ##
- CocoaPods - http://cocoapods.org/
  - Getting started - http://guides.cocoapods.org/using/getting-started.html
  - Using CocoaPods - http://guides.cocoapods.org/using/using-cocoapods.html
  - The Podfile - http://guides.cocoapods.org/using/the-podfile.html

## Installing CocoaPods ##
If you are using [Homebrew](http://brew.sh/), then you can use the `Ruby` that
comes with Homebrew to install/manage CocoaPods.  With the `Ruby` provided by
Homebrew, you don't need to use `SUDO` to manage CocoaPods.

If you want to use the system copy of `Ruby`, you must use `SUDO` to
install/manage CocoaPods.

To install under Homebrew:
- Install Ruby
  - `brew install ruby`
- Install the CocoaPods gem
  - `gem install cocoapods`
- Unlink then re-link `Ruby`
  - `brew unlink ruby; brew link ruby`
  - This will cause symlinks to the CocoaPods tools (`pod`, `xcodeproj`) to be
    created in `/usr/local/bin`, which is already in your `$PATH`, so that
    your shell will then find the new executables that are installed with
    CocoaPods

To update CocoaPods under Homebrew:
- `gem install cocoapods`

To install using the system copy of `Ruby`:
- Taken from: http://guides.cocoapods.org/using/getting-started.html
- Install CocoaPods
  - `sudo gem install cocoapods`

To update CocoaPods, just follow the install steps above.

## Working with CocoaPods ##
Parts borrowed from:
http://raptureinvenice.com/my-concise-introduction-to-cocoapods/

- Create a `Podfile` with:
  - `pod init`
- Edit the resulting `Podfile`, adding any dependencies that you want to use
- Install dependency/dependencies with:
  - `pod install`

To search CocoaPods:
- `pod search <search string>`
  - There's no `info` command for a given pod, the only way to get info about
    a pod is to `search` for it
  - When you run `pod search <project>`, it will display URLs, versions, and
    descriptions of all of the matches it finds

To update pods available on CocoaPods:
- Update the list of pods by running `pod repo update`

More `repo` commands
- Show the list of repos with `pod repo list`
- Show more repo help with `pod --help repo`

vim: filetype=markdown shiftwidth=2 tabstop=2
