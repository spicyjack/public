# Graphite/Grafana #

Links
- https://matt.aimonetti.net/posts/2013/06/26/practical-guide-to-graphite-monitoring/
- https://graphite.readthedocs.io/en/latest/tools.html
- http://graphite.readthedocs.io/en/latest/install.html#post-install-tasks
- http://docs.grafana.org/installation/rpm/
- http://docs.grafana.org/installation/configuration/
- http://docs.grafana.org/guides/getting_started/

## Installing Graphite ##

    # Create a 'graphite' user for running things like collectors and
    # databases and whatnot
    useradd --comment "Graphite/Graphana User" --system graphite

    # Install required packages
    sudo yum install epel-release screen
    sudo yum install gcc stow stow-doc fontconfig mod_wsgi python-pip \
      python-devel libffi-devel cairo tree
    sudo pip install cairocffi django-tagging pytz
    export PYTHONPATH="/opt/graphite/lib/:/opt/graphite/webapp/"
    sudo pip install \
      https://github.com/graphite-project/whisper/tarball/master
    sudo pip install \
      https://github.com/graphite-project/carbon/tarball/master
    sudo pip install \
      https://github.com/graphite-project/graphite-web/tarball/master
    sudo pip install https://github.com/graphite-project/ceres/tarball/master

    export GRAPHITE_ROOT=/opt/graphite
    PYTHONPATH=$GRAPHITE_ROOT/webapp django-admin.py migrate \
      --settings=graphite.settings --run-syncdb
    PYTHONPATH=$GRAPHITE_ROOT/webapp django-admin.py collectstatic \
      --noinput --settings=graphite.settings

    # Old instructions
    # sudo chown -R graphite.graphite /opt/graphite/storage

    # Newer instructions
    # Apache needs to own the 'storage' directory, so lockfiles can be created
    # for the DB
    sudo chown -R apache.apache /opt/graphite/storage
    # Change the storage database so it's writeable by Apache
    sudo chown -R apache.apache /opt/graphite/storage/graphite.db
    # Apache needs to own Graphite's log directory
    sudo chown -R apache.apache /opt/graphite/storage/log/webapp
    # Edit '/etc/group', add 'graphite' to the 'apache' group, then...
    chmod g+ws /opt/graphite/storage

    cd /opt/graphite/examples
    sudo cp example-graphite-vhost.conf /etc/httpd/conf.d/graphite.conf
    sudo mkdir /var/run/wsgi
    sudo chown apache.apache /var/run/wsgi
    cd /etc/httpd/conf.d
    # Edit /etc/httpd/conf.d/graphite.conf
    # - Add the VIM tag at the bottom of the file, then reopen the file
    #   - # vim: expandtab shiftwidth=4 tabstop=4
    # - Add an Apache <Directory> block for "/opt/graphite/static" in order to
    # make the static file directory available to requests
    # - Disable the "mod_wsgi.so" module, it's being loaded somewhere else

    # Go to the Graphite webapp directory and create a local config file
    cd /opt/graphite/webapp/graphite
    sudo cp local_settings.py.example local_settings.py
    sudo vim local_settings.py
    # Make sure that at least the 'SECRET_KEY' is changed

    # When you're done with all of the editing, run 'apachectl' to test the
    # Apache config.  Note: the command may take a while on a VM, since DNS
    # isn't working apparently
    /usr/sbin/apachectl configtest

    # Start/restart Apache
    sudo systemctl restart httpd

    cd /opt/graphite/conf
    # Copy all of the sample config files in /opt/graphite/conf so that they
    # don't have the '.example' extension
    sudo mkdir examples
    sudo cp *.example examples/
    for CFG in *.example; do NEWCFG=$(echo $CFG | sed 's/\.example//');
      echo "Moving file $CFG to $NEWCFG"; sudo mv $CFG $NEWCFG; done

    # Create the directory for "carbon-cache", and set it's ownership to
    # "graphite"
    mkdir /opt/graphite/storage/log/carbon-cache
    sudo chown graphite.graphite /opt/graphite/storage/log/carbon-cache

    # start Carbon, the collector
    /opt/graphite/bin/carbon-cache.py start

    # Enable Apache in systemctl and start it
    sudo systemctl enable --now httpd

    # View Graphite website at:
    # http://<IP address>/

    # Set up your monitoring heirarchy (host.service.metric maybe), and then
    # start feeding data into Graphite.  You can send raw Graphite data to
    # port 2003 of the Graphite host, using the following command: 
    #
    # echo "test.bash.stats 42 `date +%s`" | nc graphite.example.com 2003
    #
    # http://graphite.readthedocs.io/en/latest/feeding-carbon.html

    # Once the data is in Graphite, you can use the basic Graphite web
    # interface to view it

## Install Grafana ##

    sudo vim /etc/yum.repos.d/grafana.repo
    # add stuff...
    # See http://docs.grafana.org/installation/rpm/ for examples of the
    # contents of the '.repo' file
    sudo yum install grafana
    sudo systemctl daemon-reload

    # Enable Apache in systemctl and start it
    sudo systemctl enable --now grafana-server
    sudo systemctl status grafana-server

    # Add stuff from Graphite via the Graphana UI

vim: filetype=markdown shiftwidth=2 tabstop=2
