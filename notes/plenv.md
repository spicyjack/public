# plenv #

https://github.com/tokuhirom/plenv

See also `plenv-contrib`, which has the `use` command.
- https://github.com/miyagawa/plenv-contrib

## Installation ##
64-bit systems:

    plenv install <Perl version> -Dusethreads -Uuselargefiles -Dusemorebits

32-bit systems

    plenv install <Perl version> -Dusethreads -Uuselargefiles -Duse64bitint

Change the Perl binary used globally

    plenv global <Perl version>

Change the Perl binary used locally

    plenv local <Perl version>

Execute a command on the current Perl

    plenv exec <command name>

After installing a new Perl, you need to update the `plenv` scripts; do so
with:

    plenv rehash

Migrate modules from one version of Perl to another

    plenv migrate-modules

List modules installed in the current Perl

    plenv list-modules

Display the version of `plenv`

    plenv --version

Locate a program file in `plenv's` path

    plenv which cpanm

To run a binary/script that Perl or a module will install into the `bin/`
directory:

    plenv exec <binary or script name> <arguments>

vim: filetype=markdown shiftwidth=2 tabstop=2
