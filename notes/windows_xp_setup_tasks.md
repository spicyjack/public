# Building Windows Images #

Tweaking installs of Windows to create a base Windows image.

Originally posted at:
  http://wiki.portaboom.com/pmwiki.php?n=HowTos.BuildingWindowsImage

For each of the changes below, document the registry key that makes that
change

## Patches/Service Packs to Apply ##
- SP3
- Windows Security Essentials (includes virus checker)
- IE8

## Registry settings to research ##
- Opening new pages in tabs instead of new windows in IE8

## Settings to change ##
Notes on registry hacking
- http://www.howtogeek.com/167579/how-to-make-your-own-windows-registry-hacks/
- http://www.tweakhound.com/xp/xptweaks/regfiles_2.htm
  - A bunch of different registry settings, with comments

Suppressing Windows Tour prompts
- http://support.microsoft.com/kb/311489


    [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Applets\Tour]
    "RunCount"="0"

Control Panel ^ Switch to Classic View

    [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
    "ForceClassicControlPanel"="1"

Control Panel ^ Internet Properties ^ Home Page ^ about:blank
- http://www.howtogeek.com/howto/windows/registry-hack-to-set-internet-explorer-start-page/


    [HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main]
    "Start Page"="about:blank"

Control Panel ^ Regional and Language, switch the system time to show
HH:mm:ss instead of AM/PM
- http://windowsitpro.com/windows-server/jsi-tip-0311-regional-settings-registry


    [HKEY_CURRENT_USER\Control Panel\International]
    "iTime"="1"
    "sTimeFormat"="HH:mm:ss"

Enable Terminal Services
- http://technet.microsoft.com/en-us/library/cc782195(v=ws.10).aspx
- Computer will need to be rebooted


    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server]
    "fDenyTSConnections"="0"

Disable End of Support notification
- https://4sysops.com/archives/prevent-the-windows-xp-end-of-support-notification/

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion]
    "DisableEOSNotification"="1"

## Windows Applications that can be removed ##
- Boot into Safe Mode by pressing *F8* after the BIOS finishes with POST
- `Start -> Settings -> Control Panel -> Add/Remove Programs -> Add/Remove
  Windows Components`
- Uncheck:
  - MSN Explorer
  - Outlook Express
  - Windows Messenger

## Things you can delete from Windows ##
- `C:\Documents and Settings\All Users\Document`, all Shared Music, Shared
  Pictures and Shared Video folders (built in samples)
- `C:\Windows\$hf_mig$` - Uninstall files of SP2 and hotfixes
- `C:\Windows\Help\*` - Windows XP Help - Compress folder
- `C:\Windows\ime` - `chsime,  CHTIME, imejp, imejp98, imjp98_1, imkr6_1` -
Traditional/Simplified Chinese, Japanese, and Korean input methods
- `C:\Windows\kb\*.txt` - Uninstall info about SP2 and hotfixes
- `C:\Windows\SET\*.tmp` - Temporary files
- `C:\Windows\System32\Dllcache` - Backup `.dll` files for recovery
- `C:\Windows\System32\Logon.scr` and other `*.scr` files (screensavers)
- `C:\Windows\Web\Wallpaper` - `Ascent.jpg` and other `.jpg` files (wallpapers)

- For Internet Explorer, right click on it's toolbars, and keep only the Back,
Forward, Stop, Refresh and Home icons, and disable the Links toolbar

## Windows Explorer Shortcuts ##
Target: `%SystemRoot%\explorer.exe /e,/select,C:`

For Windows Explorer, right click it's toolbars, disable the Go button, unlock
the toolbars and move the Address bar into the same row as the buttons, then
right click again and choose Customize, remove any extra icons, as well as
making the icons small and with no text.

## To change the color of the login screen in Windows ##

- open the registry with `regedit.exe`
- hit `<F3>` to search the registry
- paste the following string into the box and click on Find:
`HKEY_USERS\.DEFAULT\Control Panel\Colors`
- in the right hand window pane, choose the key `Background`, and double click
on it
- in the box that pops up, enter zero zero zero like this: `0 0 0`
- exit the registry and log out

## To change the background wallpaper for the login screen ##

- open the registry with `regedit.exe`
- hit `<F3>` to search the registry
- paste the following string into the box and click on Find:
`HKEY_USERS\.DEFAULT\Control Panel\Desktop`
- Find the 'Wallpaper' key
- Double click on the key, then enter the full path to the Windows Bitmap
(`*.bmp`) file you want to use as the login screen background

## Killing windows Login Apps ##

Here's a list of Windows registry entries that you can search in order to find
an application that's started when you log into Windows.  A good example here
would be Microsoft Messenger on Windows XP; here's how you kill it.

- `My Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`
- `My Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`
- `My Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce`

###### vim: filetype=markdown shiftwidth=2 tabstop=2:
