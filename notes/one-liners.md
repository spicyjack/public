# One-liners #
One-liners, or mini-programs that can be used to do things.

2019-07-12
- Download a bunch of files with month numbers in the filename


    for MONTH in $(printf '%02i\n' $(seq 7 12)); do \
      echo "Downloading month '${MONTH}'"; \
      wget https://example.com/${MONTH}filename.zip; done

2018-07-16
- Change the URLs of Git repos in a common directory


    for CFG_FILE in $(find . -name config | grep .git/config); do \
      if [ $(grep -c 'ssh://user@git.example.com' $CFG_FILE) -gt 0 ]; then \
        echo "Updating ${CFG_FILE}"; \
        gsed -i 's!ssh://user@git\.example\.com!gnome:!' $CFG_FILE; fi; done

2016-03-08
- One-liner to concat a bunch of text files into one output file


    for FILE in rex.*.txt; do echo "Filename: ${FILE}" >> tasklist.txt;
    cat $FILE >> tasklist.txt; echo -e "\n" >> tasklist.txt; done`

2015-09-03
- Grep a list of files output from the `find` command
  - `grep 'grep_text' $(find . -type f -name foo)`

2013-01-03
- Create thumbnails of JPEG images.
  - Given a directory of `*.jpg` images;


    for FILE in $(ls -1 *.jpg | grep -v thumb); 
    do THUMB=$(echo $FILE | sed 's/\(.*\)\.img\(.*\)/\1.thumb.img\2/'); 
    echo "$FILE -> $THUMB"; convert -resize 150x150 $FILE $THUMB; done

# vim: filetype=markdown shiftwidth=2 tabstop=2
