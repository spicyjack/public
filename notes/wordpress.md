# Wordpress #

## Installation ##
- Create a separate directory for plugins and themes
  - `wp/plugins`
  - `wp/themes`
- Symlink the plugins and themes to the correct place in the wordpress
  directory
- Change ownership of WordPress and themes to `httpd.httpd`
  - This allows "automatic" updating at a later date (updating via the web
    server user)

## Syntax Highlight Plugins ##
- WP-Syntax - http://wordpress.org/extend/plugins/wp-syntax/ (sirhc)
- Crayon - http://wordpress.org/extend/plugins/crayon-syntax-highlighter/
- WP-GeSHi-Highlight - http://wordpress.org/extend/plugins/wp-geshi-highlight/
- http://alexgorbatchev.com/SyntaxHighlighter/manual/brushes/
- Vivid Chalk (from markw) - https://github.com/tpope/vim-vividchalk
- https://github.com/google/code-prettify

# vim: filetype=markdown tabstop=2
