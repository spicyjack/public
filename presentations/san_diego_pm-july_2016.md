# San Diego Perl Mongers Meeting - July 2016 #

## What to talk about? ##
- Converting from traditional CGI scripts to mod_perl, FastCGI, and other ways
  to enhance web performance
  - Most "modern" web applications are using the "Ruby on Rails" model, where
    the application starts and runs on a local port, and a webserver of some
    kind (Apache, Nginx, perlbal, load balancer) proxies HTTP requests for it.
    This is similar to how FastCGI works
    - _Dancer2_
    - _Mojolicious_
    - _Catalyst_
- Packaging programs for easy deployment
  - Please define: "What is easy deployment?"
  - `cpanminus` (aka `cpanm`, aka _App::cpanminus_)
  - _Carton_
  - _PAR_
  - _App::FatPacker_
- Perl interview questions

vim: filetype=markdown shiftwidth=2 tabstop=2
