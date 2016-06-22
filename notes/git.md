## Git Links ##
- http://git-scm.com/documentation
  - http://git-scm.com/docs
  - http://progit.org/
    - http://progit.org/book/
- http://schacon.github.com/git/git.html
- http://gitimmersion.com/index.html
- Git for the confused:
  http://www.gelato.unsw.edu.au/archives/git/0512/13748.html
- Git Magic; http://www-cs-students.stanford.edu/~blynn/gitmagic/ch08.html
- How to make references (to people, or issues) in commits/markdown on GitHub
  - https://help.github.com/articles/writing-on-github/

### Git Workflow Links ###
- http://search.cpan.org/perldoc?Dancer::Development
- http://nvie.com/posts/a-successful-git-branching-model/
- How to use github effectively for your project - http://tinyurl.com/4g9wmwy
- http://blog.plover.com/prog/git-habits.html
- http://perlbrew.pl/Perlbrew-development-and-the-git-flow.html

### Git Apps ###
- http://gitolite.com/gitolite/gitolite.html
  - Written in Perl
  - Only handles access/auth
- Gitprep - http://www.gitprep.org
  - GitHub "clone"
  - Written in Perl
  - No issue tracking, repo viewing only
- http://gitblit.com/
  - Java
- http://getgitorious.com/install-gitorious
  - Only handles access/auth
- http://www.gitlab.com
  - Access/auth, issue tracking, repo browsing
  - Written in Ruby
  - Needs 450M of system RAM to run
- http://phabricator.org/
  - Written in PHP
  - Access/auth, issue tracking, repo browsing
  - Wants extra setup (SUDO access) to use either HTTPS or SSH
    - SSH wants to use port 22 by default (phabricator runs it's own SSH
      daemon), unless you want to use a non-standard port
      - You can't use an existing system account like Gitolite or GitBlit uses

### Specifying revisions ###
http://schacon.github.com/git/gitrevisions.html

You can specify revisions in the following ways:

1. Commit SHA ID; you can also use parts of a SHA ID, you would use the
minimum amount of characters needed in order to specify a unique commit ID
1. `<branch name>@{number}`, where `{number}` is a specific amount of
commits to work backwards from the current HEAD
1. `HEAD~<number>`, which means the Nth numbered parent of HEAD

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
1. Track a remote branch after pulling it to the local system: `git branch
--set-upstream <branch name> origin/<branch name>`

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
  - pushing an empty source branch deletes the named branch on the remote server
    - `git push origin --delete branch_name`
    - `git push origin :branch_name`
  - pushing a local branch that does not exist on the server will create the
    new branch on the server
  - see the git-push documentation page for more examples

### Summary of changes between two commits
Use `git diff`

    git diff --stat

There are other `--stat` options that can be used with `git diff`

### Creating/Merging Branches ###
Quick summary:

    git branch fix_name
    <make changes>
    git add <files>
    git commit
    git checkout master
    git merge fix_name
    git checkout dev
    git merge fix_name

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

Pull a single commit out of that branch with `git cherry-pick`

    git checkout <branch name>
    git cherry-pick <one or more commit IDs to cherry-pick>

You can also use one of the shortcuts listed in `gitrevisions` to specify what
commit to cherry-pick back on to the current branch.  See `git help
cherry-pick` for more info.

### Orphan Branches ###
Create a new orphan branch in Git, an empty branch without files

    git checkout --orphan <branch name>
    git rm -rf .

### Git Stash ###

    git stash
    git fetch
    git rebase
    git stash pop
    git stash list
    git stash save stashing prior to pulling, possible duplicate code
    git pull
    git diff
    git log
    git diff cfac54ac33eceadb4a6872e09d9e466cdc9b2de9
    git stash list
    git stash apply stash@{0}
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

To delete a tag, deleted it from the local repo:

    git tag -d <tag name>

Then push the name of the deleted tag to the remote repo

    git push origin :refs/tags/<tag name>

### Showing Things ###

#### Listing the contents of tags ####
This includes any tags signed with a PGP/GPG encrypted signature

    git show <tagname>

#### Showing what changed in a commit ####

    git show <commit ID>

#### Renaming lightweight tags ####
Move the file in the `.git/refs/tags` directories.

*TODO* test this with --annotated and --signed tags to see if it will also
work.

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


### Git Submodules ###
Submodules are a way of organizing multiple different repos into one tree.
- http://git-scm.com/book/en/v2/Git-Tools-Submodules

Cloning a project with submodules:

    git clone https://example.com/MainProject
    git submodule init

Or...

    git clone --recursive https://example.com/MainProject

Adding more submodules to an existing Git repo

    git submodule add https://example.com/NewProject

Updating a project with submodules

    git submodule update --remote

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

### Exporting a specific directory ###
http://gitready.com/intermediate/2009/01/29/exporting-your-repository.html

### Exporting from Mercurial into Git ###
1. Clone the `fast-export` tool: 

    git clone git://repo.or.cz/fast-export.git

1. Install the `mercurial.py` module
  1. Install via `pip`
  1. `sudo apt-get install pip`
  1. `sudo pip install mercurial==2.2`
1. Make sure the `mercurial.py` module is in your `PYTHONPATH`
  1. `export PYTHONPATH=/path/to/lib/python/site-packages`
1. Create a new directory for the git repo: `mkdir new-project`
1. Run `git init` to initialize: `cd new-project; git init`
1. Run the `fast-export` shell script: `hg-fast-export.sh -r ../repo.hg`
1. Run `git checkout` to make the source code appear in the git repo

### Reverting a single file in a repo to an older version ###

    git checkout revision -- filename

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

vim: filetype=markdown shiftwidth=2 tabstop=2
