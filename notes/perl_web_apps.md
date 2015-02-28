# Perl Web App Framework Notes #

## Dancer2 ##
Create the _Dancer2_ web app

    dancer2 --application HelloWorld

Start a _Dancer2_ app

    plackup -p 3000 bin/app.psgi

Fatpacking a _Dancer2_ app

    fatpack pack bin/app.psgi > app.packed.psgi

Starting a fatpacked _Dancer2_ app

    plackup -p 3000 app.packed.psgi

## Mojolicious ##

Create a _Mojolicious::Lite_ app; note that _Mojolicious::Lite_ doesn't use
app names.

    mojo generate lite_app

Create a full _Mojolicious_ app, with an app name (app object name)

    mojo generate app <App name>

Start a _Mojolicious::Lite_ app

    ./myapp.pl daemon

Start a _Mojolicious::Lite_ app using the `morbo` development web server,
which will reload the web app automagically when you make changes to it

    morbo ./myapp.pl

Start a daemonized _Mojolicious_ app

    script/<name of app> daemon

Start a full _Mojolicious_ app under `morbo`

    morbo script/<name of app>

Start a _Mojolicious_ app meant to run under CGI

    script/<name of app> cgi

Start a _Mojolicious_ app meant to run under PCGI

    script/<name of app> pcgi

See a full list of help options for a _Mojolicious_ app

    script/<name of app>

Fatpacking a _Mojolicious_ app

    fatpack pack bin/app.psgi > app.packed.psgi

Starting a fatpacked _Mojolicious_ app

    chmod 744 script.packed
    script.packed daemon

vim: filetype=markdown shiftwidth=2 tabstop=2
