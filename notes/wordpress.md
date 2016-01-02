# Wordpress #

Multisite WordPress versus non-multisite WordPress
- Pros
  - Easier to manage/update
- Cons
  - Only one set of logs for all sites

## Installation ##
- Create a database and user in the database for the new _WordPress_ site
  - `CREATE DATABASE wp_<sitename>;`
  - `GRANT ALL PRIVILEGES ON wp_<sitename>.* TO "wp_user"@"<hostname>"
    IDENTIFIED BY "password";`
  - `GRANT ALL PRIVILEGES ON wp_<sitename>.* TO "wp_user"@"localhost"
    IDENTIFIED BY "password";`
  - `GRANT ALL PRIVILEGES ON wp_<sitename>.* TO "wp_user"@"127.0.0.1"
    IDENTIFIED BY "password";`
  - `GRANT ALL PRIVILEGES ON wp_<sitename>.* TO "wp_user"@"::1"
    IDENTIFIED BY "password";`
- Unpack the _WordPress_ zip file into the target directory
- Change ownership of the files inside the target directory, and the target
  directory itself to `httpd.httpd`
- Create a new copy of the `wp-config-sample.php` file called `wp-config.php`
  - Change the information for the database, username and password
  - Fill out the information for the secret keys used in the _WordPress_ app;
    there's a secret key generator located at
    https://api.wordpress.org/secret-key/1.1/salt/ that will generate all of
    the necessary secret keys for you, if you want
- Add the domain that will be used for the _WordPress_ instance to DNS
- Create a virtual host for the new _WordPress_ instance, and make the
  `ServerName` in _Apache_ match the hostname created in DNS

## Syntax Highlight Plugins ##
- WP-Syntax - http://wordpress.org/extend/plugins/wp-syntax/ (sirhc)
- Crayon - http://wordpress.org/extend/plugins/crayon-syntax-highlighter/
- WP-GeSHi-Highlight - http://wordpress.org/extend/plugins/wp-geshi-highlight/
- http://alexgorbatchev.com/SyntaxHighlighter/manual/brushes/
- Vivid Chalk (from markw) - https://github.com/tpope/vim-vividchalk
- https://github.com/google/code-prettify

# vim: filetype=markdown tabstop=2
