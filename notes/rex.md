# Notes on (R)?ex #

(R)?ex is the Perl-based system configuration tool

## Links ##
- http://www.rexify.org/
  - Guides - http://www.rexify.org/howtos/index.html#guides
  - How to start using (R)?ex - http://www.rexify.org/howtos/start.html
  - Working with packages -
    http://www.rexify.org/howtos/working_with_packages.html
  - Managing user accounts - http://www.rexify.org/howtos/usermgmt.html
  - Using modules and templates -
    http://www.rexify.org/howtos/using_templates.html
  - Using an INI-style groups file -
    http://www.rexify.org/howtos/groups_file.html
- https://metacpan.org/pod/Rex
  - `rex` command - https://metacpan.org/pod/distribution/Rex/bin/rex
  - Basic commands - https://metacpan.org/pod/Rex::Commands
  - User commands - https://metacpan.org/pod/Rex::Commands::User
  - Commands to run things - https://metacpan.org/pod/Rex::Commands::Run
  - Commands for gathering info -
    https://metacpan.org/pod/Rex::Commands::Gather
- Devops with Rex - http://blog.kablamo.org/2013/11/22/rex/

## (R)?ex Setup ##
- Create a `Rexfile`
- If you want to use INI-style files tp specify server groups, create a
  `server.ini` file, with a list of servers and account info for each server,
  since each of my servers has a different `root` password

## (R)?ex Commands ##
- Show what tasks and groups are set up
  - `rex -T`
  - `rex -T -f alternate_rex_file_name`
  - `rex -T -y` - print in YAML format
  - `rex -T -m` - print in "machine parseable" format
- Run a task
  - `rex <taskname>`
  - `rex -f alternate_rex_file_name <taskname>`

## Problems using (R)?ex ##
- Found a bug using the example INI file for `groups_file`
  - The example has the following in the `INI` file:
    - `servername user=root password=foo sudo=false`
  - This throws an error in `Rex.pm` at line 300, the comparison for `sudo`
    at that point is numeric, not textual
- `run_task()` opens a new SSH connection each time it's used
- `do_task()` opens 2 new SSH connections each time it's used
  - Best to group all related commands under a single task, which opens only
    one SSH connection to run all of the commands in that task

vim: filetype=markdown shiftwidth=2 tabstop=2
