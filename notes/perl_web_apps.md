# Perl Web App Framework Notes #

## Dancer2 ##
Create the web app

    dancer2 --application HelloWorld

## Mojolicious ##

Create a _Mojolicious::Lite_ app

    mojo generate lite_app

Create a full _Mojolicious_ app

    mojo generate app <HelloWorld>

Start a Dancer2 app

    plackup -p 3000 bin/app.psgi

Start a _Mojolicious::Lite_ app

    ./myapp.pl daemon

Start a _Mojolicious::Lite_ app using the `morbo` development web server,
which will reload the web app automagically when you make changes to it

    morbo ./myapp.pl

Start a full _Mojolicious_ app

    script/<name of app>

Start a full _Mojolicious_ app under `morbo`

    morbo script/<name of app>

Start a daemonized _Mojolicious_ app

    script/<name of app> daemon

Start a _Mojolicious_ app meant to run under CGI

    script/<name of app> cgi

Start a _Mojolicious_ app meant to run under PCGI

    script/<name of app> pcgi

See a full list of options available to run _Mojolicious_ apps

    script/<name of app>

vim: filetype=markdown shiftwidth=2 tabstop=2
