## PostgreSQL 9.2 Notes ##

Some of these notes may be applicable to older versions; they'll definitely be
applicable to newer versions

Docs: http://www.postgresql.org/docs/9.2/interactive/index.html

### Restarting PostgreSQL on Mac OS X ###

    brew services restart postgresql

(Installs the `homebrew/services` package)

### Links ###
- System Information functions
  - http://www.postgresql.org/docs/9.2/static/functions-info.html
- PostgreSQL data types
  - http://www.postgresql.org/docs/9.2/static/datatype.html
- List and disconnect sessions
  - http://www.devopsderek.com/blog/2012/11/13/list-and-disconnect-postgresql-db-sessions/
- Questions/tutorials about roles and/or schemas
  - http://stackoverflow.com/questions/10352695
  - http://stackoverflow.com/questions/760210
  - http://stackoverflow.com/questions/21513996
  - http://stackoverflow.com/questions/24918367
  - http://dba.stackexchange.com/questions/91953
  - http://dba.stackexchange.com/questions/33943
  - https://www.digitalocean.com/community/tutorials/how-to-use-roles-and-manage-grant-permissions-in-postgresql-on-a-vps--2
  - http://stackoverflow.com/questions/11046152

Reloading `postmaster` after changing a configuration file
- `su -c "pg_ctl reload -D/path/to/pg/data/dir" postgres`

Using `psql` to access a database
- If no user is set up by default in `pg_ident.conf`
  - `su -c 'psql' postgres`
- If some users are set up in `pg_ident.conf`
  - `psql -Uroot dbname`
  - `psql -Uusername dbname`
  - `psql -Upostgres postgres`
  - `psql -Upostgres` (default database is `postgres`)

`psql` backslash metacommands
- Get help inside of `psql`: `\? `
- Connect to a (different) database: `\c <database>`
- Status of the current connection: `\conninfo`
- Show the contents/history of the query buffer: `\p `
- Reset/clear the contents/history of the query buffer: `\r `
- Show `psql` history: `\s `
- Edit the query buffer: `\e `
- Show the contents of the query buffer: `\p `
- List query output in a line-by-line format: `\x on`
- Set/show the current character encoding: `\encoding`

Describing things in `psql`
- List all databases: `\l `
- List database collations: `\dO[S+]`
- List all tables/views/sequences (also shows table owner): `\d `
- Describe a table/view/sequence: `\d <name>`
- List table/view/sequence access privileges: `\dp` **or** ` \z `
- List default privileges for a schema: `\ddp`
- List roles (users/groups): `\dg[+]` or `\du[+]`
- List schemas: `\dn`
- List schemas with schema priviledges: `\dn+`
- List schemas with full priviledge info: `\dnS+`
- List indexes: `\di` or `\diS[+]`
- List tables (only): `\dt`
- List views: `\dv` or `\dvS[+]`
- List [aggregate/normal/trigger/window] functions: `\df[antw][S+]`
- List enabled languages: `\dL` or `\dLS+`

Showing/editing functions
- Show a function's definition: `\sf[+] <function name>`
- Edit a function definition: `ef <function name>`

Describing things in the system
- List system tables/views/sequences: `\dS`
- List system tables/views/sequences with extended info: `\dS[+]`

### Setting up users and databases ###
Setting up a new PostgreSQL user from a shell
- `createuser <username>`

Deleting a PostgreSQL user from a shell
- `dropuser <username>`

Creating a database from a shell
- `createdb <dbname>`

Creating a database with a specific owner from a shell
- `createdb --owner <rolename> <dbname>`

Create a database from `psql` for someone besides the logged in user
- `CREATE DATABASE dbname OWNER rolename;`

To change users while logged in to an existing database
- `SET ROLE <rolename>;`

To create a user (a role that can log in) in SQL
- `CREATE USER foouser WITH ENCRYPTED PASSWORD '<foobar>';`

To set/reset a password
- `ALTER USER "user_name" WITH ENCRYPTED PASSWORD '<foobar>';`

### Removing public access from a database ###
In order to lock down a database in PostgreSQL, you need to revoke access to
it from the 'public' schema, then add back the roles that you do want to have
access to all databases using the `public` schema

    REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO
    pdb_access;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to pdb_admin;

In the `REVOKE` statement above, the first "public" is the schema, the second
"public" means "every user". In the first sense it is an identifier, in the
second sense it is a key word, hence the different capitalization; recall the
guidelines from Section 4.1.1. (from:
http://www.postgresql.org/docs/9.2/static/ddl-schemas.html)

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

The `SET|RESET ROLE` commands can  be used to change roles, and to change back
to the role you logged in as

- `psql -Uorig_user some_db`
- `SET ROLE someuser;`
  - Now commands will be run as if logged in as `someuser`
- `RESET ROLE;`
  - Commands will be run as `orig_user` again

- http://dba.stackexchange.com/questions/35316/why-is-a-new-user-allowed-to-create-a-table
- `GRANT ALL` on a database means;
  - `CONNECT`: Connect to the database
  - `CREATE`: Allows a new SCHEMA to be created (not a new TABLE)
  - `TEMP`: Create temporary objects
- `GRANT ALL ON SCHEMA` means;
  - `CREATE`: Allows a new TABLE to be created in the schema (not a new
    SCHEMA)
  - `USAGE`: List objects in the schema and access them if their
    permissions permit

If you use `ALTER DEFAULT PRIVILEGES` to set default privileges in a database,
the user(s) you specify in the `FOR [ROLE|USER]` expression is the user that
needs to be used when creating objects in the database that you want these
default permissions to apply to.

For example, if you want the `db_access` group to have `SELECT` permissions on
any new tables in the database, you need to create the new tables with
whatever user/role that the `ALTER DEFAULT PRIVILEGES` is used with

Log in as a user who has permissions to change privileges on the database.
This is usually the "owner" of the database (as seen with the `\l ` command in
`psql`), or any user with `Superuser` access (usually, only the default
`postgres` user).

    psql -Udb_admin db_name

Alter default privileges in a database

    ALTER DEFAULT PRIVILEGES FOR USER db_admin
    GRANT SELECT ON TABLES TO db_access;

Now when you create a new table, it will have the `SELECT` privilege assigned
to the user `db_access`

    CREATE TABLE foo ( intcolumn integer, textcolumn char(10) );

View ownership/permissions with

    \d - List all tables/views/sequences (also shows table owner)
    \z - List table/view/sequence access privileges

### Querying system metadata ###
Showing specific information about all of the users in PostgreSQL
- `SELECT * FROM pg_user;`

Showing information about connections to a database
- `SELECT * FROM pg_stat_activity;`

### Enabling Procedural Languages ###
- From `psql`: `CREATE EXTENSION plperl`
- From the command line: `createlang plperl`

### Miscellaneous ###
What are the "template0" and "template1" databases for?
- http://www.postgresql.org/docs/9.2/static/manage-ag-templatedbs.html
- New databases are copied from `template1`
- `template0` should be the "always good" copy, that can be used to restore
  `template1` to it's defaults, if desired

Simple sample tables

    SET ROLE db_create_user;
    CREATE TABLE foo (
      intcolumn integer,
      textcolumn char(10)
    );
    INSERT INTO foo VALUES (1, 'foo');

    CREATE TABLE bar (
      columnint integer,
      columntext char(10)
    );
    INSERT INTO bar VALUES (2, 'bar');
    RESET ROLE;


vim: filetype=markdown shiftwidth=2 tabstop=2
