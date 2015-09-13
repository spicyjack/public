## PHP Notes and Debugging ##

### Language Syntax ###
- String operators - http://php.net/manual/en/language.operators.string.php
- Naming things - http://us2.php.net/manual/en/userlandnaming.php
- Connection handling -
  http://us2.php.net/manual/en/features.connection-handling.php

### Debugging ###
- `print_r` - Prints human-readable information about a variable
  - http://php.net/manual/en/function.print-r.php
- `error_log` - Send an error message to the defined error handling routines
  - http://php.net/manual/en/function.error-log.php
- `var_dump` - Dumps information about a variable
  - http://us2.php.net/manual/en/function.var-dump.php

### Helpful functions ###
- _getcwd_ - Gets the current working directory
  - http://php.net/manual/en/function.getcwd.php
- _preg_replace_ - Perform a regular expression search and replace
  - http://php.net/manual/en/function.preg-replace.php
  - All of the POSIX Regex functions are deprecated in PHP 5.3.x

### Misc Notes ###
- PHP function names are case-insensitive
  - http://us2.php.net/manual/en/functions.user-defined.php

### Logging Frameworks ###
- https://github.com/jbroadway/analog
- https://github.com/Seldaek/monolog
- https://github.com/katzgrau/KLogger
- http://www.php-fig.org/psr/psr-3/

vim: filetype=markdown shiftwidth=2 tabstop=2
