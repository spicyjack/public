# plenv #

https://github.com/tokuhirom/plenv

See also `plenv-contrib`, which has the `use` command.
- https://github.com/miyagawa/plenv-contrib

## Installing plenv ##

    # make sure 'plenv' is set up in your ~/.bashrc or ~/.bash_profile
    git clone https://github.com/tokuhirom/plenv.git ~/.plenv
    # install perl-build inside the ~/.plenv directory
    git clone https://github.com/tokuhirom/Perl-Build.git \
      ~/.plenv/plugins/perl-build/


## Installing a Perl ##
List available Perls

    plenv install --list

64-bit systems:

    plenv install <Perl version> -Dusethreads -Uuselargefiles -Dusemorebits
    plenv install --as=Perl-Foo <Perl version> \
      -Dusethreads -Uuselargefiles -Dusemorebits

32-bit systems

    plenv install <Perl version> -Dusethreads -Uuselargefiles -Duse64bitint
    plenv install --as=Perl-Foo <Perl version> \
      -Dusethreads -Uuselargefiles -Duse64bitint

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

    plenv migrate-modules <from version> <to version>

List modules installed in the current Perl

    plenv list-modules

Display the version of `plenv`

    plenv --version

Install `cpanm` in the current Perl

    plenv install-cpanm

Locate a program file in `plenv's` path

    plenv which cpanm

To run a binary/script that Perl or a module will install into the `bin/`
directory:

    plenv exec <binary or script name> <arguments>

vim: filetype=markdown shiftwidth=2 tabstop=2
