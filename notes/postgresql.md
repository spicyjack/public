## PostgreSQL 9.2 Notes ##

Some of these notes may be applicable to older versions; they'll definitely be
applicable to newer versions

Docs: http://www.postgresql.org/docs/9.2/interactive/index.html

Starting `psql`
- If no user is set up by default in `pg_ident.conf`
  - `postgres $ psql`
- If some users are set up in `pg_ident.conf`
  - `root # psql -Uroot dbname`
  - `root # psql -Uusername dbname`
  - `user # psql -Upostgres postgres`

`psql` backslash metacommands
- Get help inside of `psql`: `\? `
- Status of the current connection: `\conninfo`
- Show the contents/history of the query buffer: ` \p `
- Reset/clear the contents/history of the query buffer: ` \r `

Describing things in `psql`
- List default privileges: `\ddp `
- List roles: `\dg `
- List all databases: ` \l `
- List tables/views/sequences: `\d `
- List table/view/sequence access privileges: `\dp ` **or** ` \z `
- List system tables/views/sequences: `\dS `
- List system tables/views/sequences with extended info: `\dS+ `
- Describe a table/view/sequence: `\d <name> `

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

Showing specific information about all of the users in PostgreSQL
- `SELECT * FROM pg_user;`

What are the "template0" and "template1" databases for?
- http://www.postgresql.org/docs/9.2/static/manage-ag-templatedbs.html
- New databases are copied from `template1`
- `template0` should be the "always good" copy, that can be used to restore
  `template1` to it's defaults, if desired

vim: filetype=markdown shiftwidth=2 tabstop=2
