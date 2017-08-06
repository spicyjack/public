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

    sudo losetup -G . -K disk_key.key -e AES256 /dev/loop2 /dev/sde1

### Add the LVM logical volumes ###

    sudo pvcreate /dev/loop2
    sudo vgcreate <volume group> /dev/loop2
    sudo lvcreate -l476931 -nhomevol <volume group>

### Add the filesystems to the LVM volumes ###

    sudo mkfs.ext4 /dev/<volume group>/homevol

vim: filetype=markdown shiftwidth=2 tabstop=2
