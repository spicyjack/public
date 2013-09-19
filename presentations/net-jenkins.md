# Net::Jenkins Presentation #

## What to talk about? ##
 What is Jenkins?
- What it does
- How you can use it
  - Software testing
  - Automation
    - Show a demo of automation/building

Popular features
- Views
  - Groups jobs togehter
  - Completely customizable, except for **All** view
- Plugins
  - Change views/Jenkins behaivor
  - What's interesting?
  - Examine plugins multiple times, make lots of notes, easy to miss
    interesting things.
- Security 
  - internal user database
  - LDAP
  - web server authentication
- Notification
  - IRC
  - E-mail
  - IM

Jenkins Perl modules
- `App::Jenkins`
- `Net::Jenkins`
  - Why did I choose `Net::Jenkins`?

## How I build with Jenkins ##
- Build trees, not build pipelines
- Call custom Jenkins scripts from Jenkins jobs
  - `update_git.sh` - Updates various git tools script repos
  - `delete_dir.sh` - Deletes old `artifact` and `output` trees
  - Copy artifacts job step(s) - Copies "artifacts", or tarballs of the
    `output` folders from previous jobs
  - `unpack_artifacts.sh` - Unpacks artifacts into `artifacts` folder
  - `munge_rpath.sh` - Changes the `RPATH` value in library files
  - `download_tarball.sh` - Download source tarball if it doesn't exist in
    `$HOME/source`
  - `unpack_and_config.sh` - Unpacks source and runs `./configure`, with
    options
  - `build_source.sh` - Runs `make`/`cmake`
  - `build_artifact.sh` - Creates the build artifact from the contents of the
    `output` directory

## Changes I've made to Net::Jenkins ##
- Cookbook
- Retrieving Jenkins version from HTTP headers
- Parsing of URLs to allow for non-standard ports/Jenkins URL paths
- Saving of error message after each HTTP request
- Building jobs with parameters
  - Encoding parameters in a JSON HTTP POST message
- Updates/completion of POD documentation
- `next_build_number` method
- Tests for `$jenkins->summary` and `$jenkins->build_version`

## How to manage Jenkins ##
- Backups
  - Create a tarball of the `jenkins` directory
  - Copy `config.xml` files for jobs and for Jenkins itself
    - Lose history and previous builds/artifacts
- Upgrading
  - Upgrade in place, restart
  - Upgrade any plugins that need upgrading

## How to scale with Jenkins ##
- Build with params
- Create custom build jobs without params using CLI/API and hacked up XML
  - Delete jobs for old versions, you should be able to recreate them later if
    you need to

## Demos ##
- Preflighting
- Setting up a job
  - `arm-busybox`
- Setting up a view
- Console access
- Running a Perl script that uses `Net::Jenkins`
- Build pipelines

vim: filetype=markdown shiftwidth=2 tabstop=2
