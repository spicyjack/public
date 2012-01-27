## Git Links ##
- http://schacon.github.com/git/user-manual.html
- http://schacon.github.com/git/git.html
- http://progit.org/
  - http://progit.org/book/

### Questions to be answered? ###
- How to integrate code from one branch into another?  git pull against the
  branch on the local disk? (CHERRY PICK!)
- Notes from git presentation(s)?  Where are they hiding?

### Remotes ###
Remote repositories are versions of your project that are hosted on the
Internet or network somewhere.

- showing remotes
  git remote -v
- showing what's on a remote
  git remote show origin
- tracking a remote branch on the local system
  git branch local_name origin/remote_name
  git pull

### Creating a local repo, pushing it to remote ###
- create the git repo in your local directory
    git init .
- add the remote
    git remote add bitbucket git@example.com:/path/to/repo.git
- test pushing code to the new remote
    git push --dry-run origin master
- do the actual push
    git push origin master

### Git Pull ###
- Pull from a remote repo, updating an older cloned version of the same repo:
  git pull git://github.com/wakaleo/game-of-life.git master
- Pull from a remote repo, updating an older cloned version of the same repo;
  set this repo to be the default repo for futher pulls/pushes:
  git pull --set-upstream git://github.com/wakaleo/game-of-life.git master
  git pull -u git://github.com/wakaleo/game-of-life.git master
- Pull a remote branch
  git checkout <branchname>; git pull origin

### Git Push ###
- Push to a different branch;
  - pushing an empty branch deletes the branch on the remote server
  - pushing a local branch will create the new branch on the server
  - see the git-push documentation page for more examples

### Copying commits from one repo to another ###
To copy all of the commits (complete commit including author and date
timestamp), use 'git format-patch' followed by 'git am';
  - git format-patch -o /path/to/patches/dir --root HEAD
  - cat /path/to/patches/dir/<patchfile names> | git am

### Tags ###
By default, the git push command doesn’t transfer tags to remote servers. You
will have to explicitly push tags to a shared server after you have created
them. This process is just like sharing remote branches — you can run git push
origin (tagname)

### Rebasing changes ###
If you have not shared changes on your machine with anyone else, and you want
to combine a set of small changes into one large change, you can use `git
rebase -i` to rewrite the changelog to make the small changes into one large
change.  Example command;

    git rebase -i HEAD~<number of parents to use for the rebase>

So, this command:

    git rebase -i HEAD~3

will cause git to display the last 3 changes, with the oldest change being at
the top and working down to the newest change at the bottom.  To the left of
each change ID will be an option to perform on that change.  The list of
options that you can perform on each change is in the comments at the bottom
of the change message screen.

### Create a repo on a server, push existing content, pull content to check ###
(Round-tripping)

On the server:
    cd /var/www/git
    mkdir example.git
    cd example.git/
    git init --bare --shared=true

On a client with no code to push:
    git clone ssh://example.com/var/www/git/example.git example.git

On a client with existing code to push:
    git push ssh://example.com/var/www/git/example.git master

Round-trip check:
    git clone ssh://example.com/var/www/git/example.git example.git

Git config looks like:
[remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*
    # FQDN
    #url = git@git.example.com:/path/to/example.git
    # short form, if you have a config block with this name in your
    # ~/.ssh/config file
    url = server-name:/path/to/example.git
[branch "master"]
    remote = origin
    merge = refs/heads/master

### Git Configs ###
Multiple remote branches:

        [remote "origin"]
            fetch = +refs/heads/*:refs/remotes/origin/*
            url = git@github.com:spicyjack/yadex.git
        [branch "master"]
            remote = origin
            merge = refs/heads/master
        [branch "wesleyjohnson"]
            remote = origin
            merge = refs/heads/master

# vim: filetype=markdown tabstop=2
