## Project Naranja Setup ##

### Partition hard drive ###

For drives 2T and less: 
- Use parted to build a MSDOS partitoned drive

For drives greater than 2T:
- Use parted to build a GPT partitioned drive


    parted /dev/disk/by-id/disk_id
    mklabel gpt
    # part-type fs-type fs-name fs-start fs-end
    mkpart primary ext2 "Partition Name" 0 100%

### Create the loop-aes loopback mount ###

### Add the LVM logical volumes ###

### Add the filesystems to the LVM volumes ###

vim: filetype=markdown shiftwidth=2 tabstop=2
