# App::FatPackeramework Notes #

## Links ##
- https://metacpan.org/pod/App::FatPacker
- https://metacpan.org/pod/distribution/App-FatPacker/bin/fatpack

## HOWTO ##
Fatpacking a _Dancer2_ app

    fatpack pack bin/app.psgi > app.packed.psgi

Starting a fatpacked _Dancer2_ app

    plackup -p 3000 app.packed.psgi

Fatpacking a Mojolicious app, step-by-step

    $ fatpack trace --use=Mojolicious --use=Try::Tiny script/mojolicious_app
    $ fatpack packlists-for `cat fatpacker.trace` > fatpacker.packlists
    $ fatpack tree `cat fatpacker.packlists`
    $ fatpack file script/mojolicious_app > mojolicious_app.packed

Any external libraries such as _DBI_ or any of the _DBD::*_ modules need to be
installed separately, they can't be fatpacked (they contain binary files)

Run the fatpacked Mojolicous app with

    $ perl mojolicious_app.packed daemon

Or

    $ chmod 755 mojolicious_app.packed
    $ ./mojolicious_app.packed daemon

Fatpacking using the step-by-step method:

    $ fatpack trace myscript.pl
    $ fatpack packlists-for `cat fatpacker.trace` >packlists
    $ fatpack tree `cat packlists`
    $ fatpack file myscript.pl >myscript.packed.pl

vim: filetype=markdown shiftwidth=2 tabstop=2
