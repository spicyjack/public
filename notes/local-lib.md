## Notes on using 'local::lib' ##



Install `local::lib` with:

    perl -MCPAN -e look local::lib
    perl Makefile.PL --bootstrap
    make test && make install

`local::lib` must be in your shell's environment before you can use it.  You
can enable it by adding a line similar to this to your shell's startup
scripts;

    eval $(/path/to/your/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

Install `local::lib` to a custom directory with:

    perl -MCPAN -e look local::lib
    perl Makefile.PL --bootstrap=~/foo
    make test && make install

The corresponding `eval` would need to be:

    eval $(/path/to/your/perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/foo)

You can deactivate a custom install directory with:

    eval $(perl -Mlocal::lib=--deactivate,~/foo)

Supposedly show what `local::lib` sets in the environment with:

    perl -Mlocal::lib

vim: filetype=markdown shiftwidth=2 tabstop=2
