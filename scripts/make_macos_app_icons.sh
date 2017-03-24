#!/bin/bash

# script to create a set of icons for a macOS app
# - Taken from http://stackoverflow.com/questions/646671
if [ $# -eq 0 ]; then
   echo "ERROR: missing original icon filename"
   echo "Usage 'make_macos_icon_pack.sh file.png'"
   exit 1
fi

ORIGINAL_ICON="$1"

if [ ! -r $ORIGINAL_ICON ]; then
   echo "ERROR: file ${ORIGINAL_ICON} not readable"
   echo "Usage 'make_macos_icon_pack.sh file.png'"
   exit 1
fi

# Normal screen icons
for SIZE in 16 32 64 128 256 512; do
   echo "Calling 'sips -z $SIZE $SIZE $ORIGINAL_ICON'"
   sips -z $SIZE $SIZE $ORIGINAL_ICON --out icon_${SIZE}x${SIZE}.png
done

# 2x Retina display icons
for SIZE in 32 64 256 512; do
   echo "Calling 'sips -z $SIZE $SIZE $ORIGINAL_ICON'"
   sips -z $SIZE $SIZE $ORIGINAL_ICON \
      --out icon_$(expr $SIZE / 2)x$(expr $SIZE / 2)x2.png
done
