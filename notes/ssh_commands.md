# SSH Commands #

SSH has the concept of "commands" that can be embedded in the
`authorized_keys` file for restricting an account so that it can only run
those commands.  This is documented in the `AUTHORIZED_KEYS FILE FORMAT`
section of the `sshd(8)` manpage.

## Setting up SSH commands ##
1. Generate an SSH keypair using `ssh-keygen -b 4096 -t rsa`
1. Take the public key and append it to the authorized_keys file of the user
you want to run the command as
1. Add the `command=""` string to the `authorized_keys` file that you want to
be able to run when this key is used in an SSH session
1. Test with a non-destructive version of the command if possible, and if not,
test with a simple command like 'date' first

## Example: Setting up restricted rsync ##
- On the host that will be backed up, find the `rrsync` script that comes with
  the `rsync` package and place it in the `$PATH` of the user that will be
  used to run backups.  Debian example shown below:


    zcat /usr/share/doc/rsync/scripts/rrsync.gz | sudo tee /usr/bin/rrsync
    sudo chmod 755 /usr/bin/rrsync

- Generate an SSH keypair 


    ssh-keygen -b 4096 -t rsa -C "Restricted Backup key" -f id_backup_hostname

- Take the public key and append it to the authorized_keys file of the user
you want to run the command as


    cat id_backup_hostname.pub >> ~username/.ssh/authorized_keys

- Add the command string to the beginning of the line that contains the public
  key you just appended in the previous step;


    no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty,command="/usr/bin/rrsync -ro /var/www"

- Create a backup script that sends data to or reads data from the host to be
  backed up.  Note that in the `rsync` command, the remote host does not need a
  directory, this is taken care of by the `rrsync` script that was created on
  the backup host (above).


    /usr/bin/rsync -av --delete \
      -e "ssh -i /root/.ssh/id_backup_hostname" \
    hostname: /home/hostname/backup_dir | tee -a /root/sync.backup_host.log

# vim: filetype=markdown tabstop=2
