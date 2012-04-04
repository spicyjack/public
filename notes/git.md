## Git Links ##
- http://schacon.github.com/git/user-manual.html
- http://schacon.github.com/git/git.html
- http://progit.org/
  - http://progit.org/book/

### Git Workflow Links ###
  - http://search.cpan.org/perldoc?Dancer::Development
  - http://nvie.com/posts/a-successful-git-branching-model/
  - How to use github effectively for your project - http://tinyurl.com/4g9wmwy
  - http://blog.plover.com/prog/git-habits.html

### Questions to be answered? ###
- Notes from git presentation(s)?  Where are they hiding?

### Remotes ###
Remote repositories are versions of your project that are hosted on the
Internet or network somewhere.

1. Showing remotes: `git remote -v`
1. Showing what's on a remote `git remote show origin`
1. Adding a remote branch to the local system: `git branch local_name
origin/remote_name; git pull`
1. If you cloned a repo that has multiple branches, use `git branch -r` to
list all of the branches, and `git checkout <branch name>` to start working on
that branch

### Creating a local repo, pushing it to remote ###
Create the git repo in your local directory;

    git init .

Add the remote;

    git remote add origin git@example.com:/path/to/repo.git

Test pushing code to the new remote;

    git push --dry-run origin master

Do the actual push;

    git push origin master

### Git Pull ###
Pull from a remote repo, updating an older cloned version of the same repo:

    git pull git://github.com/wakaleo/game-of-life.git master

Pull from a remote repo, updating an older cloned version of the same repo;
set this repo to be the default repo for futher pulls/pushes:

    git pull --set-upstream git://github.com/wakaleo/game-of-life.git master
    git pull -u git://github.com/wakaleo/game-of-life.git master

Pull a remote branch

    git checkout <branchname>; git pull origin

### Git Push ###
- Push to a different branch;
  - pushing an empty branch deletes the branch on the remote server
  - pushing a local branch will create the new branch on the server
  - see the git-push documentation page for more examples

### Creating/Merging Branches ###
Create a branch

    git branch <branchname>

Check out that branch

    git checkout <branchname>

Do some work in the branch, then commit the work

    git commit

Switch back to the `master` branch

    git checkout master

Then merge your work branch back into `master`

    git merge <branchname>

You can delete your work branch after you're done if you want

    git branch -d <branchname>

### Git Stash ###

    git stash list
    git stash save stashing prior to pulling, possible duplicate code
    git pull
    git diff
    git log
    git diff cfac54ac33eceadb4a6872e09d9e466cdc9b2de9
    git stash list
    git stash drop stash@{0}
    git stash list

### Listing what files/directories are tracked ###

    git ls-tree -r HEAD

### Untracking files/directories ###

Untrack a file:

    git rm --cached file

Untrack a directory full of files

    git rm --cached -r directory 

### Tags ###
By default, the git push command doesn’t transfer tags to remote servers. You
will have to explicitly push tags to a shared server after you have created
them. This process is just like sharing remote branches — you can run git push
origin (tagname)

    git push --tags

### Listing the contents of tags ###

    git show <tagname>

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

### Copying commits from one repo to another ###
To copy all of the commits (complete commit including author and date
timestamp), use `git format-patch` followed by `git am`;

    git format-patch -o /path/to/patches/dir --root HEAD
    cat /path/to/patches/dir/<patchfile names> | git am

### Creating an archive file for distribution (sans the .git bits) ###

    git archive -o /path/to/archive/file.zip HEAD

`git archive` also understands `tar` format:

    git archive -o /path/to/archive/file.tar HEAD

If you use the `-o` switch to specify an output file, you don't need to use
the `--format` switch to specify the format of the output file.  The default
output file is STDOUT.

### Exporting from CVS into Git ###
To export a CVS repo into git, start with an empty directory (no `git init`),
then run something like:

    git cvsimport -v -A ~/authors -d user@example.com:/path/to/cvsroot module-name

The `-A` switch will let you specify a list of author names to convert when
importing from CVS.  CVS uses the username of the user who is interacting with
the CVS repo.  You can convert those short user names to full names and e-mail
addresses that Git likes by creating a file that maps short names to longer
names.  The format of the file is explained in the `git-cvsimport` help page
(http://schacon.github.com/git/git-cvsimport.html).

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

vim: filetype=markdown tabstop=2
