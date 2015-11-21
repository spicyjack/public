# MinGW Notes #

Note that the original MinGW project was forked in 2007, and now there's
multiple MinGW projects (MinGW, Mingw-w64) out there.
## MinGW Links ##
- Homepage - http://www.mingw.org/
  - Original GNU toolchain for Windows
  - http://www.mingw.org/wiki/Getting_Started
  - http://www.mingw.org/wiki
  - http://www.mingw.org/wiki/MSYS
  - https://gitorious.org/mgwport/mgwport/blobs/master/README
- Downloads
  - http://sourceforge.net/projects/mingw/files/Installer/mingw-get-inst/

### mingw-get usage ###
- Get help
  - `mingw-get --help`
- Update available packages
  - `mingw-get update`
- List packages
  - `mingw-get list`
- List just package names (requires `msys-less` to be installed)
  - `mingw-get list | grep Package | less`
- Install basically everything:
  - `mingw-get install mingw-developer-toolkit --start-menu`

## MinGW-w64 Links ##
- Homepage - http://mingw-w64.sourceforge.net/
- Allows building MinGW apps for Windows on Windows, Linux and OS X (Darwin)
- There's also an installer called `MinGW-builds` which will install
  everything for you
- Documentation
  - http://sourceforge.net/p/mingw-w64/wiki2/FAQ/ (Installation)
  - http://sourceforge.net/p/mingw-w64/wiki2/GeneralUsageInstructions/
  - http://sourceforge.net/apps/trac/mingw-w64/wiki/download%20filename%20structure
- Downloads
  - http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/
  - http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/
  - http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/

MinGW-builds install
- Doesn't work with the installer as of 2015-11-20
  - http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/

7-zip install
- http://www.7-zip.org/
  - Use the full path to the `*.exe` file to unpack the MinGW archive

GnuWin32 Install
- You need to download GnuWin32 in order to get a copy of `bunzip2.exe`
  - GetGnuWin32 will download the entire GnuWin32 package tree and install it
    for you
  - Run the installer from the GetGnuWin32 folder
    - `install C:\Apps\gnuwin32`
  - The installer creates a directory called `C:\Apps\GetGnuWin32`
  - Open that folder in `cmd.exe`, and run `download.bat`
  - All of the GnuWin32 files will be downloaded and installed into a
    directory
  - Run the batch file `GNUWIN32\update-links.bat` to reset all of the links
    in that directory, as well as create Start Menu items
  - Rename some files in the `\bin` directory
    - date.exe -> xdate.exe
    - sort.ext -> xsort.exe
- Or you can download and install files by hand
  - Required packages
    - bzip2-1.0.5-bin
    - libiconv-1.9.2-1-bin
    - libiconv-1.9.2-1-dep
    - libintl-0.11.5-2-bin
    - libintl-0.11.5-2-lib
    - tar-1.13-1-bin
  - Optional packages
    - libintl-0.14.4-bin
    - libintl-0.14.4-lib

MinGW-w64 install
- Download the MinGW-w64 7z file
  - http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/
- Unpack the file to someplace convenient, like `C:\mingw-w64`
  - `C:\Temp>"C:\Program Files\7-Zip\7z.exe" x
    i686-5.2.0-release-posix-dwarf-rt_v4-rev0.7z`

MSYS install
- Documentation
  - http://sourceforge.net/p/mingw-w64/wiki2/MSYS/
- Download a MSYS file
  - http://sourceforge.net/projects/mingwbuilds/files/external-binary-packages/
  - http://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/

## MinGW Environment Setup ##
Any utilities provided by MinGW must be the only utilities of that type in the
environment.  Other \*NIX utilities, provided by things like Git on Windows or
UnxUtils, must me excluded from the user's $PATH environment variable, or
there will be program crashes/hangs.

### Emergency/customized Bash startup in Windows ###
`MSYS` startup icon info:
- Target: `C:\MinGW\msys\1.0\bin\bash.exe --rcfile /p/.bashrc.winnt`
- Start in: `C:\MinGW\msys\1.0\bin`

Contents of `/p/.bashrc.winnt`
- `PATH=/mingw/bin:/usr/bin:/usr/sbin; export PATH`
- Add other customization to suit

# vim: filetype=markdown shiftwidth=2 tabstop=2
