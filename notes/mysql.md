## MySQL Notes ##

Changing a password

    ALTER USER 'user'@'host' IDENTIFIED BY '<foobar>';

Getting the row count for all tables in a database (among other info)

    SHOW TABLE STATUS\G

Copying a database to a new name on the same server using `mysqldump`

    CREATE DATABASE foo;
    mysqldump --user=user --password=pass bar \
      mysql --user=user --password=pass foo


vim: filetype=markdown shiftwidth=2 tabstop=2
