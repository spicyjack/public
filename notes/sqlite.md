# SQLite Notes #

## Links ##
- C/C++ function list
  - http://sqlite.org/c3ref/funclist.html
- Querying database schema
  - http://sqlite.org/sqlite.html
- Datatypes
  - http://sqlite.org/datatype3.html

## Querying for database schema ##
SQLite has a `master` table that stores schema information for the database.
You can query the `master` table and get database schema info returned;

    SELECT name FROM sqlite_master 
    WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%'
    UNION ALL 
    SELECT name FROM sqlite_temp_master 
    WHERE type IN ('table','view') 
    ORDER BY 1

Headers are turned off by default; to enable them, run:

    .headers ON



vim: filetype=markdown shiftwidth=2 tabstop=2
