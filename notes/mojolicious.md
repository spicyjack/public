# Mojolicious Web Framework Notes #

The flow of a _Mojolicious_ application is outlined in the
_Mojolicious::Guides::Growing_ POD document, in the section "A birds-eye view"

## Mojolicious Configuration ##
You can create configuration files that _Mojolicious_ will read when it starts
up, via the _Mojolicious::Plugin::Config_ class.  Use the `plugin()` method to
load the Config object

    plugin q(Config);

## Module notes ##

### Mojo ###
Base class for a lot of objects in Mojolicious.

### Mojo::Log ###
Simple logging class for Mojolicious.
- The _Mojo_ class creates a _Mojo::Log_ object at startup, and sets the log
  level to **debug** if the `Mojolicious->mode` attribute is set to
  `development`.
- The default log level can be set by grabbing a copy of the _Mojo::Log_
  class inside the running copy of the _Mojolicious_ object, and using the
  `->level()` method to set a new log level
  - `my $log = $app->log;`
  - `$app->log->level('<new level>');`
  - The default log level can also be overridded by the `MOJO_LOG_LEVEL`
    environment variable
  - The _Mojo::Log_ class is created by the _Mojo_ class at startup; the
    _Mojolicious_ object inherits the _Mojo_ class

### Mojolicious ###
Inherits from _Mojo_. See that class for additional methods/attributes.

Attributes
- `mode` will set the operating mode for the application
  - Also settable via the environment variables `MOJO_MODE` or `PLACK_ENV`
  - The logfile is named after the name of the `mode` that was set
  - The default log level for _Mojolicious_ apps is **info**
  - If the `mode()` is set to the string `development`, then the log level is
    automatically set to **debug**
  - _Mojolicious::Guides::Tutorial_ also discusses setting `mode()`
- If you don't change the `secrets` attribute, then _Mojolicious_ will use the
  `moniker` attribute as the secret for the app, which is insecure
  - Secret passphrases that are used for signed cookies
  - _Mojolicious_ will also generate a debug log message saying your secret
    needs to be changed

Methods
- `->defaults()` will set up default values that will be used
  `Mojolicious::Controller->stash()` for every new request
- `->plugin()` registers a plugin, which is generally a subclass of
  _Mojolicious::Plugins_

## Mojolicious::Commands ##
- `mojo version` will show the versions of Perl, _Mojolicious_, and the
  optional dependencies that _Mojolicious_ can use

## Mojolicious::Controller ##
Methods (from _Mojolicious::Guides::Tutorial_)
- `->stash()` is used for non-persistant storage for the current request
  - For example, it can be used to pass data to templates before rendering
    those templates
- There's a reserved list of stash values that can't be used in `->stash()` in
  `Mojolicious::Controller->stash()`
- Setting/clearing values from the stash:


    # Remove value
    my $foo = delete $c->stash->{foo};

    # Assign multiple values at once
    $c->stash(foo => 'test', bar => 23);

- Special stash values; the shortcut `controller#action` can be used to define
  shortcuts to a given controller and action in a route


    # /bye -> {controller => 'foo', action => 'bye', mymessage => 'Bye'}
    $r->get('/bye')->to('foo#bye', mymessage => 'Bye');

- Render JSON directly in _Mojolicious_ using a Perl data structure:
    `$c->render(json => {foo => [1, 'test', 3]});`

Parameters (from _Mojolicious::Guides::Tutorial_)
- The controller object that's passed in as part of an action contains a
  `params()` method, which can be used to retrieve HTTP GET/POST parameters
  sent from the client


    get q(/foo) => sub {
      my $c = shift;
      $c->render(text => q(Hello World!);
    };

HTTP Request/Response objects
- The HTTP request/response objects are available via the controller object
  that's passed in as part of an action


    get q(/foo) => sub {
      my $c = shift;
      my $host = $c->req->url->to_abs->host;
      my $ua = $c->req->headers->user_agent;
      $c->render(text => qq(Request by $ua reached $host.);
    };

Placeholders
- Placeholders are available via the controller object's `stash()` or
  `param()` methods


    get q(/foo/:bar) => sub {
      my $c = shift;
      # same thing
      my $stash = $c->stash(q(bar));
      my $param = $c->param(q(bar));
    };

## Mojolicious::Routes::Route ##
Methods
- `->to()` sets default parameters for a given route
  - `$r->to('MyApp', foo => 'bar');`

Controller (From _Mojolicious::Guides::Tutorial_)
- The first argument passed to all actions (aka a valid route) in a
  _Mojolicious_ controller object is a _Mojolicious::Controller_ object (`$c`)
  containing both the HTTP request and response


    get q(/foo) => sub {
      my $c = shift;
      $c->render(text => q(Hello World!);
    };

## Helpers ##
Helpers are modules written to make common tasks easier
- _Mojo::JSON::j_ - renders Perl data structures into JSON, or JSON into Perl
  data structures
- _Mojolicious::Plugin::TagHelpers_ has a bunch of helpers that are used in
  templates for shortcuts to HTML tags
- _Mojolicious::Plugin::DefaultHelpers_ is a collection of helpers, some of
  which can be used in templates, others which can be used in routes/actions
  - This module has code for running in `development` mode, so that all error
    pages are returned with the pretty error page

## Perldoc Documentation ##
By default, _Mojolicious_ apps will serve documentation when the
`/perldoc/ModuleName` URL is requested from the _Mojolicious_ server.  HTML
output of POD is provided by the _Mojolicious::Plugin::PODRenderer_ class.

## Testing Mojolicious ##
The class that should be used for testing _Mojolicious_ apps is called
_Test::Mojo_.  It works with _Test::More_ to test the entire stack, and has
testing functions that are specific to _Mojolicious_.

Testing the entire _Mojolicious_ application

    ./script/<app name> test

Running a single test via the `test` command

    ./script/<app name> test -v t/basic.t

Running a single test via `prove`

    prove -l -v t/basic.t

## Basic Operations ##
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

Get a list of routes in a _Mojolicious::Lite_ app

    ./myapp.pl routes

Start a daemonized _Mojolicious_ app

    script/<name of app> daemon

Start a full _Mojolicious_ app under `morbo`

    morbo script/<name of app>

Start a _Mojolicious_ app meant to run under CGI

    script/<name of app> cgi

Start a _Mojolicious_ app meant to run under PCGI

    script/<name of app> pcgi

See a list of routes for a _Mojolicious_ app

    script/<name of app> routes

See a full list of help options for a _Mojolicious_ app

    script/<name of app>

Fatpacking a _Mojolicious_ app

    fatpack pack bin/app.psgi > app.packed.psgi

Starting a fatpacked _Mojolicious_ app

    chmod 744 script.packed
    script.packed daemon

vim: filetype=markdown shiftwidth=2 tabstop=2
