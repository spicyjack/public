## PHP Notes and Debugging ##

### Language Syntax ###
- Array functions - http://us2.php.net/manual/en/ref.array.php
- Connection handling -
  http://us2.php.net/manual/en/features.connection-handling.php
- Filesystem functions - http://us2.php.net/manual/en/ref.filesystem.php
- Naming things - http://us2.php.net/manual/en/userlandnaming.php
- Operator Precedence -
  http://us2.php.net/manual/en/language.operators.precedence.php
- PHP Data Objects - http://us2.php.net/manual/en/book.pdo.php
- PHP Tags - http://us2.php.net/manual/en/language.basic-syntax.phptags.php
- Predefined variables in PHP -
  http://us2.php.net/manual/en/reserved.variables.php
- Regular Expressions (Perl-compatible) -
  http://us2.php.net/manual/en/book.pcre.php
- String functions - http://us2.php.net/manual/en/ref.strings.php
- String operators - http://php.net/manual/en/language.operators.string.php
- Variable handling functions
  - Classes and Objects - http://us2.php.net/manual/en/ref.classobj.php
  - Variable handling functions - http://us2.php.net/manual/en/ref.var.php
    - Has all of the `is_*()` functions
- Variable scope - http://us2.php.net/manual/en/language.variables.scope.php

### Debugging ###
- `print_r` - Prints human-readable information about a variable
  - http://php.net/manual/en/function.print-r.php
- `error_log` - Send an error message to the defined error handling routines
  - http://php.net/manual/en/function.error-log.php
- `var_dump` - Dumps information about a variable
  - http://us2.php.net/manual/en/function.var-dump.php

### Helpful functions/classes ###
- _getcwd_ - Gets the current working directory
  - http://php.net/manual/en/function.getcwd.php
- _implode_ - Join array elements with a string
  - http://us2.php.net/manual/en/function.implode.php
- _preg_replace_ - Perform a regular expression search and replace
  - http://php.net/manual/en/function.preg-replace.php
  - All of the POSIX Regex functions are deprecated in PHP 5.3.x
- _strftime_ - Format a local time/date according to locale settings
  - http://us2.php.net/manual/en/function.strftime.php
- _ZipArchive_ - Transparently read or write ZIP compressed archives
  - http://us2.php.net/manual/en/class.ziparchive.php

### Misc Notes ###
- PHP The Right Way
  - http://www.phptherightway.com/
- PHP function names are case-insensitive
  - http://us2.php.net/manual/en/functions.user-defined.php

### Logging Frameworks ###
- https://github.com/jbroadway/analog
- https://github.com/Seldaek/monolog
- https://github.com/katzgrau/KLogger
- http://www.php-fig.org/psr/psr-3/

### More PHP Frameworks ###
- http://mashable.com/2014/04/04/php-frameworks-build-applications

vim: filetype=markdown shiftwidth=2 tabstop=2
