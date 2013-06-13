# Jenkins Notes #

### Jenkins Job Step Conventions ###
- All steps in a job should output the name of the step to STDOUT via `echo`
- All artifacts from jobs should be named as `<library>.artifact.tar.xz`
  - Use `xz` for compression
  - `touch` a text file with the name and version number of the library in the
    top level of the output directory, prior to zipping it up
- All steps will use `say/info/warn` for writing output to STDERR/STDOUT
  - allows --quiet to be tested for in fewer places

### Debugging Jobs ###
- PatchELF, resets the RPATH in a library file
  - http://nixos.org/patchelf.html
- `readelf` can show you the header info in a library file
  - How the Linux loader finds libraries - http://tinyurl.com/bru596n
- Mac OS X comes with a utility named `install_name_tool` that can make similar
  modifications to the rpath encoded in a binary. However, it can't change the
  rpath to one that's longer than the original unless the binary was built
  with the linker flag -headerpad_max_install_names.
- For `pango`, set `--disable-silent-rules` in the `configure` step
  - This tells `libtool` not to use the `--silent` option
- You may also be able to use `make --debug j` to show command invocation
  - Other possibly helpful `make` switches:
    - `--print-directory`

### Jenkins Job Step Notes ###
- Update `jenkins-cfg.git` repo
  - Leave a stamp file after running `git pull`, so you can test to see how
    long since the last update
  - Only update once a day
- Unpack and configure
  - Remove the existing source directory
    - *FIXME* would be fun to see if `make distclean` works everywhere to
      bring the source directory to a "known clean" state; it would at least
      save a bit of time
  - Pass in the configure arguments to `./configure`
- Build and test
  - Cairo wants a `TARGETS` argument to `make test`

## Installation ##
- Download the jenkins.war file
- Create a user for running Jenkins
  - OS X: System Preferences, create a Sharing Only user, then go into
    Advanced options and assign that user a home directory of /Users/jenkins
    - Fix homedir permissions: `sudo chown jenkins:staff /Users/jenkins`
  - Debian:
    - groupadd -g 450 jenkins
    - adduser --gid 450 --uid 450 --disabled-password jenkins
- Install package dependencies
  - Graphviz, for graphing job dependencies

## Jenkins on Windows ##
If you are using Jenkins on Windows, and you have multiple copies of either
`sh.exe` or `bash.exe` in your `%PATH%`, you might want to set a default shell
in Jenkins, along with any options for that shell.

- Manage Jenkins
- Configure System
- Shell
  - Shell executable: Whatever shell and arguments you need to run jobs
    - Example: `C:\MinGW\msys\1.0\bin\bash.exe -xe --rcfile /p/.bashrc`

### Related Links ###
http://serverfault.com/questions/309848/how-can-i-check-the-build-status-of-a-jenkins-build-from-the-command-line

## Jenkins Plugins and their purposes ##
- AnsiColor (currently disabled)
- ant (builtin)
- Avatar: shows avatar pictures
- Build Pipeline Plugin : Allows for visualization of the build pipeline
- Compact Columns
- Copy Artifact: a build step for copying artifacts of other jobs
- Custom Job Icon: set up a custom icon for jobs
- Dependency Graph Viewer: view a graph of job dependencies
- External Monitor Job Type: monitor processes external to Jenkins
- GitHub API Plugin
- GitHub Plugin
- Green Balls: replace the blue job status balls with green ones
- Hudson Xvnc plugin: for testing apps that need X11 to test/run
- Jenkins CVS plugin
- Jenkins Dependency Analyzer Plugin
- Jenkins GIT Plugin
- Jenkins Google Code Plugin
- Jenkins Gravatar Plugin
- Jenkins instant-messaging plugin: support for build notification via
  instant messenger
- Jenkins IRC Plugin
- Jenkins Jabber notifier
- Jenkins jQuery Plugin
- Jenkins jQueryUI Plugin
- Jenkins Mailer plugin
- Jenkins SSH plugin
- Jenkins SSH Slaves plugin
- Jenkins Translation Assistance plugin
- Jenkins Xvfb plugin
- Job Log Logger plugin
- LDAP Plugin
- Log Command plugin: adds commands to the CLI for viewing job logs
- Maven Integration plugin
- pam-auth
- Token Macro plugin
- View Job filters
- Xcode integration: invokes Xcode tools for building Xcode projects
  (agvtool)

### Starting Jenkins from the command line ###

    sudo su - jenkins
    java -jar jenkins.war --httpPort=8888 --httpListenAddress=127.0.0.1 \
      >> jenkins.log 2>&1 &

    # doesn't work, looks for files in the wrong user directory
    sudo -u jenkins java -jar jenkins.war 2>&1 \
      | sudo -u jenkins tee -a jenkins.log > /dev/null &

### Creating Java equivs packages ###

    cd /dev/shm
    cp /usr/share/doc/java-common/dummy-packages/*.control .
    for FILE in *.control; do echo "Building $FILE"; equivs-build $FILE; done
    sudo dpkg -i *.deb

vim: filetype=markdown shiftwidth=2 tabstop=2:
