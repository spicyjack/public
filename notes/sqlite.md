# SQLite Notes #

## Links ##
- C/C++ function list
  - http://sqlite.org/c3ref/funclist.html
- Querying database schema
  - http://sqlite.org/sqlite.html
- Datatypes
  - http://sqlite.org/datatype3.html
- C/C++ Function List
  - http://sqlite.org/c3ref/funclist.html
- Introduction to the C/C++ Interface
  - http://sqlite.org/cintro.html

## Helpful metacommands ##
Show the current database
- `.database`

Turn on headers
- `.headers ON`

Turn on "line" output, one column per line
- `.mode line`

Turn on "tabs" output, columns are separated by **\t** characters
- `.mode tabs`

Turn on the CPU timer
- `.timer ON`

## Querying for database schema ##
SQLite has a `master` table that stores schema information for the database.
You can query the `master` table and get database schema info returned;

    SELECT name FROM sqlite_master 
    WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%'
    UNION ALL 
    SELECT name FROM sqlite_temp_master 
    WHERE type IN ('table','view') 
    ORDER BY 1

## Demonstrating changes to sqlite_master ##
(Optional) Turn on headers
- `.headers ON`

(Optional) Turn on "line" output, one column per line
- `.mode line`

Turn on the CPU timer
- `.timer ON`

Create a new table;
- `CREATE TABLE example(first TEXT);`

View the table definition in SQLite `sqlite_master`;
- `SELECT * FROM sqlite_master;`

Add a value to the table
- `INSERT INTO example VALUES ('foo');`

View the table with the value inserted
- `SELECT * FROM example;`

Add a second column to the table
- `ALTER TABLE example ADD COLUMN second INTEGER;`

View the table with the new column inserted
- `SELECT * FROM example;`

Add a value for the new column in the same row as existing data
- `UPDATE example SET second = 0 WHERE first = 'foo';`

vim: filetype=markdown shiftwidth=2 tabstop=2
