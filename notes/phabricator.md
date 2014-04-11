## Phabricator Notes ##

- RCS/Trouble ticket system testing
  - Criteria for a ticketing system
    - Uses Markdown for comments/wiki pages
    - Allows control of tickets via commits
    - Looks decent
    - Easy to modify web interface
    - API access

- http://phabricator.org/
- https://secure.phabricator.com/book/phabdev/article/conduit/

- Install docs:
  - https://secure.phabricator.com/book/phabricator/article/installation_guide/
- Installer wants `root` database privileges
  - `bin/storage upgrade --user root --password 'foo'`
- Check the status of an install with...
  - `bin/storage status --user root --password 'foo'`
- If you use a different database user besides `root` for running Phabricator,
  you can reset database permissions with:
  - `GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW ON
    'phabricator\_%'.* TO 'phabricator_user'@'localhost';`
  - From: https://coderwall.com/p/ne1thg
- Most of the maintenance commands are located in the `phabricator.git/bin`
  directory
- Phabricator config settings
  - `bin/config set mysql.pass "f00"`
  - `bin/config set mysql.user phabricator_user`
  - `bin/config set phabricator.base-uri 'http://dev.example.com/'`
- Phabricator daemons
  - Create a system user to run the daemons as
    - `sudo adduser --system phabricator`
  - `sudo -u phabricator bin/phd start`
- Sending confirmation e-mails in order to confirm accounts requires an e-mail
  daemon installed on the server
  - Installed postfix, set it to be an internet SMTP server
  - Tried setting up a new e-mail address, Phabricator never sends out a
    confirmation e-mail (watching postfix logs)
  - Deleted e-mail address, re-added it, and the confirmation e-mail was
    sent out correctly


vim: filetype=markdown shiftwidth=2 tabstop=2
