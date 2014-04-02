## Set up remotes ##

    git remote add gitorious git@gitorious.org:spicyjack_hello_world/spicyjack_hello_world.git
    git remote add gitlab git@gitlab.com:spicyjack/hello_world.git

## Check remotes ##

    git remote -v

    gitlab	git@gitlab.com:spicyjack/hello_world.git (fetch)
    gitlab	git@gitlab.com:spicyjack/hello_world.git (push)
    gitorious	git@gitorious.org:spicyjack_hello_world/spicyjack_hello_world.git (fetch)
    gitorious	git@gitorious.org:spicyjack_hello_world/spicyjack_hello_world.git (push)
    origin	https://github.com/spicyjack/hello_world.git (fetch)
    origin	https://github.com/spicyjack/hello_world.git (push)

## Test pushing to gitorious ##

    git push --dry-run gitorious master
    The authenticity of host 'gitorious.org (2a02:c0:1014::1)' can't be established.
    RSA key fingerprint is 7e:af:8d:ec:f0:39:5e:ba:52:16:ce:19:fa:d4:b8:7d.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added 'gitorious.org' (RSA) to the list of known hosts.
    To git@gitorious.org:spicyjack_hello_world/spicyjack_hello_world.git
     * [new branch]      master -> master

    git push --dry-run gitlab master
    The authenticity of host 'gitlab.com (54.243.197.170)' can't be established.
    ECDSA key fingerprint is f1:d0:fb:46:73:7a:70:92:5a:ab:5d:ef:43:e2:1c:35.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added 'gitlab.com' (ECDSA) to the list of known hosts.
    To git@gitlab.com:spicyjack/hello_world.git
     * [new branch]      master -> master

vim: filetype=markdown tabstop=2
