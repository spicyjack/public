# Perl App Building Notes #

Modules required for building Perl apps:
- ExtUtils::AutoInstall
- Getopt::ArgvFile > 1.07
- Module::ScanDeps > 1.09
- PAR::Packer

Modules required for `idgames_sync.pl`
- libwww-perl
- Mouse
- ExtUtils::AutoInstall
- File::Stat::Ls
- Number::Format
- Log::Log4perl
- Date::Format (TimeDate)


## Running PAR::Packer ##

Build a Perl binary

    pp --output idgames_sync.exe idgames_sync.pl
    pp --verbose --module Tie::Hash::NamedCapture
      -o idgames_sync.exe idgames_sync.pl

Build a PAR file

    pp --verbose --par --output idgames_sync.par idgames_sync.pl
    pp --verbose --par --module Tie::Hash::NamedCapture
      -o idgames_sync.par idgames_sync.pl

Use this when debugging, so that you can run `par packed_file.par` in order to
detect problems with the PAR itself.

Other interesting options

    --cachedeps=filename.deps
    --module Tie::Hash::NamedCapture

## Troubleshooting ##
- Run the `par` command with a packed `*.par` file to try to find missing
  dependencies


    pp --verbose --par --module Tie::Hash::NamedCapture
      -o idgames_sync.par idgames_sync.pl

    par idgames_sync.par

- Use `Process Explorer` to view a complete list of processes running on the
  machine
  - List DLLs used by a process
  - http://technet.microsoft.com/en-us/sysinternals/bb896653
- Use `ListDLLs` to see what DLLs are loaded on the machine
  - CLI tool
  - Shows DLLs loaded by process ID
  - http://technet.microsoft.com/en-us/sysinternals/bb896656
  - `listDLLs.exe > current.processes.dll.list.txt`


vim: filetype=markdown shiftwidth=2 tabstop=2
