# Notes for Dist::Zilla, the Perl distribution builder #

## Links ##
- https://metacpan.org/pod/Dist::Zilla
  - https://metacpan.org/release/Dist-Zilla
- http://dzil.org/
  - http://dzil.org/tutorial/start.html
- https://metacpan.org/pod/Dist::Zilla::Tutorial

## Plugin Links ##
Search link: https://metacpan.org/search?q=Dist%3A%3AZilla%3A%3APlugin
- https://metacpan.org/pod/Dist::Zilla::Plugin::Git
- https://metacpan.org/pod/Dist::Zilla::Plugin::License
- https://metacpan.org/pod/Dist::Zilla::Plugin::MetaYAML
- https://metacpan.org/pod/Dist::Zilla::Plugin::MetaResources
- https://metacpan.org/pod/Dist::Zilla::Plugin::OurPkgVersion
- https://metacpan.org/pod/Dist::Zilla::Plugin::Pod2Html
- https://metacpan.org/pod/Dist::Zilla::Plugin::Run

See also the _Lingua::ManagementSpeak_ repo for more _Dist::Zilla_ plugin
ideas (https://github.com/gryphonshafer/Lingua-ManagementSpeak)

## Build (a tarball of) your distribution ##
`dzil build`

## Run the test suite for your distribution ##
`dzil test`

## Release your distribution ##
Including making release commits and uploading the resulting tarball to CPAN
- **Edit dist.ini and change version number**
- `dzil release`

## Create a config file with info that Dist::Zilla needs to build new distros ##
`dzil setup`

## Create a new distribution ##
`dzil new Your::Library`

vim: filetype=markdown shiftwidth=2 tabstop=2
