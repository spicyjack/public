#!/bin/bash


# slick way to assign the output of a "here" document to a shell variable
# https://stackoverflow.com/questions/1167746
TOMCAT_USERS="/opt/tomcat/conf/tomcat-users.xml"
XPATH=$(cat <<EOXPATH
setns z=http://tomcat.apache.org/xml
cat /z:tomcat-users/z:user[contains(@roles, 'manager-script')]/@password
EOXPATH
)

echo "$XPATH" \
  | sudo xmllint --shell $TOMCAT_USERS \
  | grep "password" \
  | sed 's/.*password="\(.*\)"/\1/'
