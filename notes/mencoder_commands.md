mencoder  dvd://1 -o underworld.avi -oac copy -ovc divx4
* failed, got the wrong audio track

mencoder  dvd://1 -alang en -chapter 2-3 -o underworld_test_divx.avi -oac copy\
-ovc divx4
* worked, got the en track

mencoder  dvd://1 -alang en -chapter 2-3 -o underworld_test_lavc.avi -oac copy\
-ovc lavc
* worked, using lavc for compression

mencoder  dvd://1 -alang en -oac copy -ovc lavc -o underworld.avi
* worked, got the whole movie, 3/5 quality, 900M file

mencoder  dvd://1 -alang en -oac copy -ovc lavc -lavcopts vcodec=mjpeg \
-vf scale -zoom -xy 640 -o underworld.avi
* worked, movie was just over 3G in size, 5/5 quality

mencoder dvd://1 -alang en -oac copy -ovc lavc -vf scale -zoom -xy 640 -o
underworld-640.avi

# 14Apr2005, this should work with Quicktime on the mac
mencoder dvd://1 -alang en -oac -oac mp3lame -lameopts preset=standard -ovc
lavc -o somefile.avi

03Mar2006 - 
mencoder dvd://3 -oac mp3lame -lameopts preset=standard -ovc lavc -slang en -o
irony_of_fate-part1.avi

commands to try:
mencoder  dvd://2  -vf  scale  -zoom -xy 512 -o title2.avi -oac copy -ovc divx4
mencoder dvd://2 -vf  scale=640:480  -o  title2.avi -oac copy -ovc divx4
mencoder  dvd://2 -o titel2.avi -ovc lavc -lavcopts vcodec=mjpeg:vhq:vbitrate=1800 -oac copy

More options:
-------------
-info name= artist= genre= subject= copyright= srcform= comment=

-lavcopts acodec=mp3 vcodec=mpeg4 vcodec=mpeg2video

-af resample=44100 (playback for the mac)

mencoder -o towed.avi -oac copy -ofps 15 -ovc lavc -xy 400 -vf scale
mvi_1317.avi

For Craqberries:
mencoder Spermula -vf scale -zoom -xy 320 -ovc lavc -oac lavc -lavcopts
acodec=mp3:abitrate=160:vcodec=mpeg4 -o Spermula.320.mp4

Creating Animated Gifs
----------------------
Get a chunk of the movie:

mencoder -ss 1:04:20 -endpos 1:04:27 -vf scale=320:200 -fps 15 -ovc x264
-nosound dvd://1 -o rockin.m4v

Shorten it from the beginning of the clip:
mencoder -ss 76.8 -vf scale=320:200 -fps 15 -ovc lavc -nosound \
    IDIOCRACY_SIDEA.m4v -o shorter_idiocracy.m4v

Trim the unwanted bits at the end:
mencoder -endpos 11.6 -ovc copy shorter_idiocracy.m4v \
    -o shortest_idiocracy.m4v

