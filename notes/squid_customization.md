## Customizing Error Messages in Squid ##
http://www.squid-cache.org
- http://www.squid-cache.org/Doc/config/
  - http://www.squid-cache.org/Doc/config/cache_dir/
  - http://www.squid-cache.org/Doc/config/cache_mem/
  - http://www.squid-cache.org/Doc/config/err_page_stylesheet/
  - http://www.squid-cache.org/Doc/config/err_html_text/
- http://wiki.squid-cache.org/Features
  - http://wiki.squid-cache.org/Features/CustomErrors
  - http://wiki.squid-cache.org/SquidFaq/AddACacheDir
- URL for testing error pages: http://www.foo.bar/

- Copy the contents of `/usr/share/squid/errors/en` (Debian) to a new
  directory so that you can customize the pages
- Change the directive `error_directory` to point to this new directory
- Use the regex `:%s/> </>\r</g` to add newlines to the error page to make it
  human readable and therefore easier to edit

- CSS error page directive, instructs squid to use a custom CSS file
- Available CSS ѕelectors that you can use
  - list of CSS selectors
- Error page template codes
  - http://wiki.squid-cache.org/Features/CustomErrors
- http://www.squid-cache.org/Doc/config/error_default_language/
- http://www.squid-cache.org/Doc/config/err_page_stylesheet/

# vim: filetype=markdown tabstop=2
