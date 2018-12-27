#!/bin/bash

# script to create a set of icons for an iOS app
# - Original script for macOS icons taken from
# http://stackoverflow.com/questions/646671

SCRIPTNAME=$(basename $0)

for IMG_BIN in sips convert;
do
   CHECK_BIN=$(which $IMG_BIN)
   if [ $? -eq 0 ]; then
      FOUND_BIN=$IMG_BIN
      break
   fi
done

if [ "x${FOUND_BIN}" = "x" ]; then
   echo "ERROR: no suitable image conversion program found"
   exit 1
fi

if [ $# -eq 0 ]; then
   echo "ERROR: missing original icon filename"
   echo "Usage '${SCRIPTNAME} file.png'"
   exit 1
fi

ORIGINAL_ICON="$1"

if [ ! -r $ORIGINAL_ICON ]; then
   echo "ERROR: file ${ORIGINAL_ICON} not readable"
   echo "Usage '${SCRIPTNAME} file.png'"
   exit 1
fi

# format: <pixel_size>:<format_name>
ICON_SPECS="
   180:App.iPhone.3x
   120:App.iPhone.2x
   167:App.iPadPro.2x
   152:App.iPad.2x
   60:App.iPhone.1x
   76:App.iPad.1x
   1024:App.AppStore.1x
   60:Notification.iPhone.3x
   40:Notification.iPhone.2x
   40:Notification.iPad.2x
   20:Notification.iPad.1x
   120:Spotlight.iPhone.3x
   80:Spotlight.iPhone.2x
   80:Spotlight.iPad.2x
   40:Spotlight.iPhone_iPad.1x
   87:Settings.iPhone.3x
   58:Settings.iPhone.2x
   58:Settings.iPad.2x
   29:Settings.iPhone_iPad.1x
" # ICON_SPECS

echo "Original file: ${ORIGINAL_ICON}"
# generate new icons
for ICON_SPEC in $(echo $ICON_SPECS); do
   ICON_SIZE=$(echo $ICON_SPEC | awk -F':' '{print $1}')
   ICON_TYPE=$(echo $ICON_SPEC | awk -F':' '{print $2}')
   ICON_NAME=$(echo $ORIGINAL_ICON | sed 's/\.png$//')
   echo "-> ${ICON_NAME}.${ICON_SIZE}.${ICON_TYPE}.png"
   if [ $FOUND_BIN = "sips" ]; then
      sips -z $ICON_SIZE $ICON_SIZE $ORIGINAL_ICON \
         --out ${ICON_NAME}.${ICON_TYPE}.${ICON_SIZE}.png
   elif [ $FOUND_BIN = "convert" ]; then
      convert -resize $ICON_SIZE $ORIGINAL_ICON \
         ${ICON_NAME}.${ICON_TYPE}.${ICON_SIZE}.png
   else
      echo "ERROR: unknown image converter '${FOUND_BIN}'"
   fi
done

# vi: set filetype=sh shiftwidth=3 tabstop=3
