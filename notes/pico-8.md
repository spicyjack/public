# PICO-8 Notes #

## Keyboard Shortcuts ##
- Toggle Fullscreen: `Alt+Enter`
- Quit: `Alt+F4` or `⌘ - Q`
- Reload/Run/Restart cart: `Ctrl+R`
- Quick-Save: `Ctrl+S`
- Mute/Unmute: `Ctrl+M`
- Player 1 defaults: Cursors + ZX / NM / CV
- Player 2 defaults: SDFE + tab,Q / shift A
- `Enter` for pause menu (while running)


## PICO-8 Specifications ##
- Display: 128x128, fixed 16 colour palette
- Input: 6 buttons
- Cartridge size: 32k
- Sound: 4 channel, 64 definable chip blerps
- Code: Lua (max 8192 tokens of code) 
- Sprites: Single bank of 128 8x8 sprites (+128 shared)
- Map: 128x32 8-bit cels (+128x32 shared)

## Filesystem Commands ##
- `DIR`: list the current directory
- `CD BLAH`: change directory
- `CD ..`: go up a directory
- `CD /`: change back to top directory (on pico-8's virtual drive)
- `MKDIR`: make a directory
- `FOLDER`: open the current directory in the host operating system's file
  browser
- `LOAD BLAH`: load a cart from the current directory
- `SAVE BLAH`: save a cart to the current directory

## Configuration ##
You can find some settings in config.txt. Edit the file when PICO-8 is not
running.

- Windows: `C:/Users/Yourname/AppData/Roaming/pico-8/config.txt`
- OSX: `/Users/Yourname/Library/Application Support/pico-8/config.txt`
- Linux: `~/.lexaloffle/pico-8/config.txt`

Use the `-home` switch (below) to use a different path to store config.txt and
other data.

## Commandline Parameters ##

    pico-8 [switches] [filename.p8]

    -run                  boot filename.p8 on startup
    -width n              set the window width 
    -height n             set the window height 
    -windowed n           set windowed mode off (0) or on (1)
    -sound n              sound volume 0..256
    -music n              sound volume 0..256
    -joystick n           joystick controls starts at player n (0..7)
    -pixel_perfect n      1 for unfiltered screen stretching at integer scales
                          (on by default)
    -draw_rect x,y,w,h    absolute window coordinates and size to draw pico-8's
                          screen 
    -run filename         automatically load and run a cartridge
    -splore               boot in splore mode
    -home path            set the path to store config.txt and other user data
                          files
    -desktop path         set a location for screenshots and gifs to be saved
    -screenshot_scale n   scale of screenshots.  default: 3 (368x368 pixels)
    -gif_scale n          scale of gif captures. default: 2 (256x256 pixels)
    -gif_len n            set the maximum gif length in seconds (1..120)
    -gui_theme n          use 1 for a higher contrast editor colour scheme
    -timeout n            how many seconds to wait before downloads timeout
                          (default: 30)

vim: filetype=markdown shiftwidth=2 tabstop=2
