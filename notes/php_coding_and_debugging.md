## PHP Notes and Debugging ##

### Language Syntax ###
- Array functions - http://us2.php.net/manual/en/ref.array.php
- Connection handling -
  http://us2.php.net/manual/en/features.connection-handling.php
- Filesystem functions - http://us2.php.net/manual/en/ref.filesystem.php
- Magic constants - http://php.net/manual/en/language.constants.predefined.php
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
- Variables from external sources -
  http://php.net/manual/en/language.variables.external.php
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
- https://github.com/katzgrau/KLogger
- https://github.com/jbroadway/analog
- https://github.com/Seldaek/monolog
- http://www.php-fig.org/psr/psr-3/

### More PHP Frameworks ###
- http://mashable.com/2014/04/04/php-frameworks-build-applications
- From SIO journal `1003.2015.md`
  - http://webdesignmoo.com/2014/10-useful-php-testing-frameworks-2014/
  - http://www.phptherightway.com/#test_driven_development
  - http://tutorialzine.com/projects/testify/
  - Found a new PHP testing framework, http://codeception.com/
    - You can automate Selenium testing with it, and you don't really have to
      muck with setting up Selenium

### PHP Application Folder Structure ###
- Most people recommend looking at existing projects in order to see how they
  are laid out
  - https://github.com/symfony/symfony
  - http://stackoverflow.com/questions/29850964 (for Docker/Vagrant)
  - https://github.com/yiisoft/yii2
  - https://github.com/bcit-ci/CodeIgniter
- "Official" layout from the Zend team
  - http://framework.zend.com/manual/1.12/en/project-structure.project.html
- `src`
  - Application files and directory structure
- `tests`

### PHP Composer ###
- https://getcomposer.org
  - https://getcomposer.org/doc/01-basic-usage.md
  - https://getcomposer.org/doc/02-libraries.md
  - https://getcomposer.org/doc/03-cli.md
- Install dependencies
  - `composer install`
- Update dependencies
  - `composer update`
- Validate your `composer.json` file (for example, before committing the file
  to Git)
  - `composer validate`
- Show the status of any local changes
  - `composer status -v`
- Show the list of packages available to `composer`
  - `composer show`
- Show the list of packages suggested by the current install of packages
  - `composer suggests`
- Show the list of packages that the current install of packages depends on
  - `composer depends`
- Update `composer`
  - `composer self-update`
- Regenerate the autoloader library script
  - `composer dump-autoload`

vim: filetype=markdown shiftwidth=2 tabstop=2
