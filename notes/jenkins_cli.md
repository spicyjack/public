## Jenkins CLI Usage Notes ##
View all commands at:
- https://yourjenkinsserver.example.com/jenkins/cli

View the help output for a command with
- `jenkcli <command> <bogus param>`
- `jenkcli build libsdl foo`

List all jobs on this Jenkins server
- `jenkcli list-jobs`

Run a job:
- `jenkcli build <job name>`

Get the log for a job:
- `jenkcli show-log <job name> -n 100000`

Get the log for a given job number:
- `jenkcli show-log <job name> -b <job number> -n 100000`

Note that there's no way to determine if a job is running, and no job number
exposed from the CLI

### Related Links ###
http://serverfault.com/questions/309848/how-can-i-check-the-build-status-of-a-jenkins-build-from-the-command-line

vim: filetype=markdown shiftwidth=2 tabstop=2:
