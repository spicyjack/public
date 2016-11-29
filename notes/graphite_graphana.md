# Graphite/Grafana #

Links
- https://matt.aimonetti.net/posts/2013/06/26/practical-guide-to-graphite-monitoring/
- https://graphite.readthedocs.io/en/latest/tools.html
- http://graphite.readthedocs.io/en/latest/install.html#post-install-tasks
- http://docs.grafana.org/installation/rpm/
- http://docs.grafana.org/installation/configuration/
- http://docs.grafana.org/guides/getting_started/

## Installing Graphite ##

    sudo yum install epel-release
    sudo yum install gcc stow stow-doc fontconfig mod_wsgi python-pip
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
    # Just change the storage database so it's writeable by Apache
    sudo chown -R apache.apache /opt/graphite/storage/graphite.db
    sudo chown -R apache.apache /opt/graphite/storage/log/webapp

    cd /opt/graphite/examples
    sudo cp example-graphite-vhost.conf /etc/httpd/conf.d/graphite.conf
    # Make the /opt/graphite/static directory available to requests by using
    # an Apache <Directory> block in the `graphite.conf` file
    sudo mkdir /var/run/wsgi
    sudo chown apache.apache /var/run/wsgi
    cd /opt/graphite/conf
    sudo cp graphite.wsgi.example graphite.wsgi
    # Copy all of the rest of the sample config files in /opt/graphite/conf so
    # that they don't have the '.example' extension

    # start Carbon, the collector
    /opt/graphite/bin/carbon-cache.py start

## Install Grafana ##

    sudo vim /etc/yum.repos.d/grafana.repo
    # add stuff...
    sudo yum install grafana
    sudo systemctl daemon-reload
    sudo systemctl start grafana-server
    sudo systemctl status grafana-server
    # Add stuff from Graphite via the Graphana UI

vim: filetype=markdown shiftwidth=2 tabstop=2
