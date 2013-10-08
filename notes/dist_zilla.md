# Notes for Dist::Zilla, the Perl distribution builder #

## Links ##
- https://metacpan.org/module/Dist::Zilla
  - https://metacpan.org/release/Dist-Zilla
- http://dzil.org/
  - http://dzil.org/tutorial/start.html
- https://metacpan.org/module/Dist::Zilla::Tutorial

## Plugin Links ##
- https://metacpan.org/search?q=Dist%3A%3AZilla%3A%3APlugin
  - https://metacpan.org/module/Dist::Zilla::Plugin::Git
  - https://metacpan.org/module/Dist::Zilla::Plugin::Run
  - https://metacpan.org/module/Dist::Zilla::Plugin::Pod2Html
  - https://metacpan.org/module/Dist::Zilla::Plugin::License
  - https://metacpan.org/module/Dist::Zilla::Plugin::MetaYAML
  - https://metacpan.org/module/Dist::Zilla::Plugin::MetaResources

## Commands ##
Build (a tarball of) your distribution
- `dzil build`

Run the test suite for your distribution
- `dzil test`

Release your distribution, including making release commits and uploading the
resulting tarball to CPAN
- **Edit dist.ini and change version number**
- `dzil release`

vim: filetype=markdown shiftwidth=2 tabstop=2
