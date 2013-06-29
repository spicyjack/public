## Notes about using 'hdparm' ##

Get/set Advanced Power Management feature

    sudo hdparm -B /dev/sdd

Check the current IDE mode status
    sudo hdparm -C /dev/sdd

Put  the  drive  into  idle  (low-power)  mode, and also set the
standby (spindown) timeout for the drive.

    sudo hdparm -S 252 /dev/sdd

Disable spindown mode for the drive.

    sudo hdparm -S 0 /dev/sdd

vim: filetype=markdown shiftwidth=2 tabstop=2
