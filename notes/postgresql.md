## PostgreSQL 9.2 Notes ##

Some of these notes may be applicable to older versions; they'll definitely be
applicable to newer versions

Docs: http://www.postgresql.org/docs/9.2/interactive/index.html

### Links ###
- System Information functions
  - http://www.postgresql.org/docs/9.2/static/functions-info.html
- PostgreSQL data types
  - http://www.postgresql.org/docs/9.2/static/datatype.html
- List and disconnect sessions
  - http://www.devopsderek.com/blog/2012/11/13/list-and-disconnect-postgresql-db-sessions/
- Questions/tutorials about roles and/or schemas
  - http://stackoverflow.com/questions/24918367
  - http://dba.stackexchange.com/questions/91953
  - http://dba.stackexchange.com/questions/33943
  - https://www.digitalocean.com/community/tutorials/how-to-use-roles-and-manage-grant-permissions-in-postgresql-on-a-vps--2
  - http://stackoverflow.com/questions/11046152

Starting `psql`
- If no user is set up by default in `pg_ident.conf`
  - `postgres $ psql`
- If some users are set up in `pg_ident.conf`
  - `root # psql -Uroot dbname`
  - `root # psql -Uusername dbname`
  - `user # psql -Upostgres postgres`

`psql` backslash metacommands
- Get help inside of `psql`: `\? `
- Connect to a (different) database: `\c <database>`
- Status of the current connection: `\conninfo`
- Show the contents/history of the query buffer: `\p `
- Reset/clear the contents/history of the query buffer: `\r `
- Show `psql` history: `\s `
- List query output in a line-by-line format: `\x on`

Describing things in `psql`
- List all databases: `\l `
- List tables/views/sequences: `\d `
- Describe a table/view/sequence: `\d <name> `
- List table/view/sequence access privileges: `\dp ` **or** ` \z `
- List default privileges: `\ddp `
- List roles: `\dg ` or `\du `
- List schemas: `\dn `

Describing things in the system
- List system tables/views/sequences: `\dS `
- List system tables/views/sequences with extended info: `\dS+ `

### Setting up users and databases ###
Setting up a new PostgreSQL user from a shell
- `createuser <username>`

Deleting a PostgreSQL user from a shell
- `dropuser <username>`

Creating a database from a shell
- `createdb <dbname>`

Creating a database with a specific owner from a shell
- `createdb -O <rolename> <dbname>`

Create a database from `psql` for someone besides the logged in user
- `CREATE DATABASE dbname OWNER rolename;`

To change users while logged in to an existing database
- `SET ROLE <rolename>;`

### Removing public access from a database ###
In order to lock down a database in PostgreSQL, you need to revoke access to
it from the 'public' schema, then add back the roles that you do want to have
access to all databases using the `public` schema

    REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO
    pdb_access;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to pdb_admin;

### Schemas ###
Schemas are a way to create different namespaces in the same database.  Two
different schemas can have the same table names in the same database and not
in conflict with each other... however, the users of the database need to use
the correct schema name in order to access the correct table.  Using schemas
in queries runs something along the lines of `<schema name>.<table name>`.

### Restricting database access to a set of users ###
Permissions for CRUD operations in PostgreSQL work at a table level, not at a
database level; if you want to limit database access to users, you need to
either limit access to tables per-user, or create a role, limit access to that
role, and then add users to that role.

Create a role to act as the "allowed group of users that can access this
database
- `CREATE ROLE somegroup WITH NOLOGIN;`

Remove access to all users (except superusers) in the `public` schema
(basically, everyone)
- `REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;`

Grant access to operations on the `public` schema to the "group" role created
above
- `GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO
  somegroup`

Use `GRANT` to add users to `somegroup`
- `GRANT somerole TO someuser, otheruser;`

### Querying system metadata ###
Showing specific information about all of the users in PostgreSQL
- `SELECT * FROM pg_user;`

Showing information about connections to a database
- `SELECT * FROM pg_stat_activity;`

What are the "template0" and "template1" databases for?
- http://www.postgresql.org/docs/9.2/static/manage-ag-templatedbs.html
- New databases are copied from `template1`
- `template0` should be the "always good" copy, that can be used to restore
  `template1` to it's defaults, if desired

Simple sample tables

    CREATE TABLE foo (
      intcolumn integer,
      textcolumn char(10)
    );

    CREATE TABLE bar (
      columnint integer,
      columntext char(10)
    );

vim: filetype=markdown shiftwidth=2 tabstop=2
