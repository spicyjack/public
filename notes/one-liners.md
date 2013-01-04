# One-liners #
One-liners, or mini-programs that can be used to do things.

## Create thumbnails of JPEG images ##
Given a directory of `*.jpg` images;

    for FILE in $(ls -1 *.jpg | grep -v thumb); do THUMB=$(echo $FILE | sed 's/\(.*\)\.img\(.*\)/\1.thumb.img\2/'); echo "$FILE -> $THUMB"; convert -resize 150x150 $FILE $THUMB; done



# vim: filetype=markdown shiftwidth=2 tabstop=2
