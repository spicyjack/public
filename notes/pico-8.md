# PICO-8 Notes #

## PICO-8 Specifications ##
- Display: 128x128, fixed 16 colour palette
- Input: 6 buttons
- Cartridge size: 32k
- Sound: 4 channel, 64 definable chip blerps
- Code: Lua (max 8192 tokens of code) 
- Sprites: Single bank of 128 8x8 sprites (+128 shared)
- Map: 128x32 8-bit cels (+128x32 shared)

## PICO-8 Quirks ##
Common gotchas to watch out for:
- The bottom half of the spritesheet and bottom half of the map occupy the
  same memory.
  - Best use only one or the other if you're unsure how this works.
  - The second half of the sprite sheet (banks 2 and 3), and the bottom half
    of the map share the same cartridge space. It's up to you how you use the
    data, but be aware that drawing on the second half of the sprite sheet
    could clobber data on the map and vice versa.
- PICO-8 numbers only go up to 32767.99.
  - If you add 1 to a counter each frame, it will overflow after around 18
    minutes!
- Lua arrays are 1-based by default, not 0-based.
  - FOREACH starts at T[1], not T[0].
- `cos()` and `sin()` take `0..1` instead of `0..PI*2`, and `sin()` is
  inverted.
- sgn(0) returns 1.
- Toggle fullscreen: use alt-enter on OSX (command-F is used for searching
  text).
- When you want to export a `.png` cartridge, use `SAVE`, not `EXPORT`.
  `EXPORT` will save only the spritesheet!

# Keyboard Shortcuts #

## In-game Keyboard Shortcuts ##
- `F6`: Save a screenshot to desktop
- `F7`: Capture a cartridge label image
- `F8`: Start recording a video
- `F9`: Save a give video to the desktop folder (max 8 seconds by default)
- Mute/Unmute: `Ctrl+M`
- Player 1 defaults
  - Movement (left/right/up/down): Cursors
  - Button 'O': `Z`
  - Button 'X': `X`
- Player 2 defaults
  - Movement (left/right/up/down): `S`/`F`/`E`/`D`
  - Button 'O': `Tab`
  - Button 'X': `Q`
- Pause: `P`
- Quick-Save: `Ctrl+S`
- Quit: `Alt+F4` or `⌘ - Q`- `Enter` for pause menu (while running)
- Reload/Run/Restart cart: `Ctrl+R`
- Toggle Fullscreen: `Alt+Enter`

## SPLORE Keyboard Shortcuts ##
- Favorite a cart: `F` (while it is selected in cartridge view)

## Code Editor Shortcuts ##
Hold shift to select (or click and drag with mouse)
- `CTRL-X`, `CTRL-C`, `CTRL-V` to cut copy or paste selected
-	`CTRL-Z`, `CTRL-Y` to undo, redo
- `CTRL-F` to search for text
- `CTRL-G` to repeat the last search again
- `CTRL-UP`, `CTRL-DOWN` to jump to start or end of the program
- `ALT-UP`, `ALT-DOWN` to navigate to the previous, next function

At the bottom right of the code editor you can see how many tokens have been
used. One program can have a maximum of 8192 tokens. Each token is a word (e.g.
variable name) or operator. Pairs of brackets, and strings count as 1 token.
commas, periods, LOCALs, semi-colons, ENDs, and comments are not counted.

To enter special characters that represent buttons, use `SHIFT-L,R,U,D,O,X`.

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


## Monitor Commands ##
- `CLS`: Clears the screen
- `KEYCONFIG`: Change the keyboard key mappings for games
- `SPLORE`: Start the built-in utility for browsing and organising both local
  and bbs (online) cartridges.

## Filesystem Commands ##
- `CD BLAH`: change directory
- `CD ..`: go up a directory
- `CD /`: change back to top directory (on pico-8's virtual drive)
- `DIR`: list the current directory
- `EXPORT BLAH.HTML`: export the cartridge in an HTML5 format (HTML file and
  JavaScript engine file)
- `EXPORT BLAH.PNG`: export the the sprite sheet and color-fits to the PICO-8
  palette
- `EXPORT BLAH.WAV`: export music from the current pattern (when editor mode
  is MUSIC)
- `EXPORT BLAH.WAV`: export the current SFX (when editor mode is SFX)
- `EXPORT BLAH%D.WAV`: exports all of the SFXs as `blah0.wav`,
  `blah1.wav` ..  `blah63.wav`
- `FOLDER`: open the current directory in the host operating system's file
  browser
- `IMPORT BLAH.PNG`: expects 128x128 png and colour-fits to the pico-8 palette
- `INSTALL_GAMES`: adds a small selection of pre-installed BBS carts to your
  favourites list.
- `LOAD BLAH`: load a cart from the current directory
- `MKDIR`: make a directory
- `SAVE BLAH`: save a cart to the current directory


## Configuration ##
You can find some settings in config.txt. Edit the file when PICO-8 is not
running.

- Windows: `C:/Users/Yourname/AppData/Roaming/pico-8/config.txt`
- OSX: `/Users/Yourname/Library/Application Support/pico-8/config.txt`
- Linux: `~/.lexaloffle/pico-8/config.txt`

Use the `-home` switch (below) to use a different path to store config.txt and
other data.

## Lua filesystem functions ##
To import or export the spritesheet as a .png:

    import("blah.png")    --  expects 128x128 png and colour-fits
                          --  to the pico-8 palette
    export("blah.png")    --  use folder() to locate the exported png

To export sound effects or music:

    export("blah.wav")    --  export music from the current
                          --  pattern (when editor mode is MUSIC)
    export("blah.wav")    --  export the current SFX
                          --  (when editor mode is SFX)
    export("blah%d.wav")  --  exports all of the SFXs
                          --  as blah0.wav, blah1.wav .. blah63.wav

vim: filetype=markdown shiftwidth=2 tabstop=2
