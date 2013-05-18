#!/bin/bash
# Based on Chrubuntu 34v87 script
# 17May2013 - Taken from a post on Google Groups, stored in Google docs:
# https://docs.google.com/file/d/0B6ujqV3C76WhaktVbEFuanNQN2s/edit

BASE_IMAGE_FILE="http://cdimage.ubuntu.com/ubuntu-core/daily/current/raring-core-armhf.tar.gz"

# fw_type will always be developer for Mario.
# Alex and ZGB need the developer BIOS installed though.
fw_type="`crossystem mainfw_type`"
if [ ! "$fw_type" = "developer" ]
  then
    echo -e "\nYou're Chromebook is not running a developer BIOS!"
    echo -e "You need to run:"
    echo -e ""
    echo -e "sudo chromeos-firmwareupdate --mode=todev"
    echo -e ""
    echo -e "and then re-run this script."
    return
  else
    echo -e "\nOh good. You're running a developer BIOS...\n"
fi

# hwid lets us know if this is a Mario (Cr-48), Alex (Samsung Series 5), ZGB (Acer), etc
hwid="`crossystem hwid`"

echo -e "Chome OS model is: $hwid\n"

chromebook_arch="`uname -m`"
if [ ! "$chromebook_arch" = "armv7l" ]
then
  echo -e "This version of Ubuntu is for the ARM-based Chromebooks only\n"
else
  echo -e "and you're running on a ARM-based Chromebook, awesome!\n"
fi

read -p "Press [Enter] to continue..."

powerd_status="`initctl status powerd`"
if [ ! "$powerd_status" = "powerd stop/waiting" ]
then
  echo -e "Stopping powerd to keep display from timing out..."
  initctl stop powerd
fi

powerm_status="`initctl status powerm`"
if [ ! "$powerm_status" = "powerm stop/waiting" ]
then
  echo -e "Stopping powerm to keep display from timing out..."
  initctl stop powerm
fi

setterm -blank 0

# Figure out what the target disk is

if [ "$1" != "" ]; then
  target_disk=$1
  echo "Got ${target_disk} as target drive"
  echo ""
  echo "WARNING! All data on this device will be wiped out! Continue at your own risk!"
  echo ""
  if [ "$target_disk" = "/dev/mmcblk0" ]; then
    echo 'Cowardly refusing to install to /dev/mmcblk0 in this mode; run with no args instead'
    echo 'to properly partition your disk!'
    exit 1
  fi

  read -p "Press [Enter] to install Ubuntu on ${target_disk} or CTRL+C to quit"

  ext_size="`blockdev --getsz ${target_disk}`"
  aroot_size=$((ext_size - 65600 - 33))
  parted --script ${target_disk} "mktable gpt"
  cgpt create ${target_disk}
  # always use 6 and 7 for sanity
  cgpt add -i 6 -b 64 -s 32768 -S 1 -P 5 -l KERN-A -t "kernel" ${target_disk}
  cgpt add -i 7 -b 65600 -s $aroot_size -l ROOT-A -t "rootfs" ${target_disk}
  sync
  blockdev --rereadpt ${target_disk}
  partprobe ${target_disk}
  crossystem dev_boot_usb=1
else
  target_disk="`rootdev -d -s`"
  # Do partitioning (if we haven't already)
  ckern_size="`cgpt show -i 6 -n -s -q ${target_disk}`"
  croot_size="`cgpt show -i 7 -n -s -q ${target_disk}`"
  state_size="`cgpt show -i 1 -n -s -q ${target_disk}`"

  max_ubuntu_size=$(($state_size/1024/1024/2))
  rec_ubuntu_size=$(($max_ubuntu_size - 1))
  # If KERN-C and ROOT-C are one, we partition, otherwise assume they're what they need to be...
  if [ "$ckern_size" =  "1" -o "$croot_size" = "1" ]
  then
    while :
    do
      read -p "Enter the size in gigabytes you want to reserve for Ubuntu. Acceptable range is 5 to $max_ubuntu_size  but $rec_ubuntu_size is the recommended maximum: " ubuntu_size
      if [ ! $ubuntu_size -ne 0 2>/dev/null ]
      then
        echo -e "\n\nNumbers only please...\n\n"
        continue
      fi
      if [ $ubuntu_size -lt 5 -o $ubuntu_size -gt $max_ubuntu_size ]
      then
        echo -e "\n\nThat number is out of range. Enter a number 5 through $max_ubuntu_size\n\n"
        continue
      fi
      break
    done
    # We've got our size in GB for ROOT-C so do the math...

    #calculate sector size for rootc
    rootc_size=$(($ubuntu_size*1024*1024*2))

    #kernc is always 16mb
    kernc_size=32768

    #new stateful size with rootc and kernc subtracted from original
    stateful_size=$(($state_size - $rootc_size - $kernc_size))

    #start stateful at the same spot it currently starts at
    stateful_start="`cgpt show -i 1 -n -b -q ${target_disk}`"

    #start kernc at stateful start plus stateful size
    kernc_start=$(($stateful_start + $stateful_size))

    #start rootc at kernc start plus kernc size
    rootc_start=$(($kernc_start + $kernc_size))

    #Do the real work
    
    echo -e "\n\nModifying partition table to make room for Ubuntu." 
    echo -e "Your Chromebook will reboot, wipe your data and then"
    echo -e "you should re-run this script..."
    umount /mnt/stateful_partition
    
    # stateful first
    cgpt add -i 1 -b $stateful_start -s $stateful_size -l STATE ${target_disk}

    # now kernc
    cgpt add -i 6 -b $kernc_start -s $kernc_size -l KERN-C ${target_disk}

    # finally rootc
    cgpt add -i 7 -b $rootc_start -s $rootc_size -l ROOT-C ${target_disk}

    reboot
    exit
  fi
fi

if [[ "${target_disk}" =~ "mmcblk" ]]
then
  target_rootfs="${target_disk}p7"
  target_kern="${target_disk}p6"
else
  target_rootfs="${target_disk}7"
  target_kern="${target_disk}6"
fi

echo "Target Kernel Partition: $target_kern  Target Root FS: ${target_rootfs}"

# try mounting a USB / SD Card if it's there...
if [ ! -d /tmp/usb_files ]; then
  mkdir /tmp/usb_files
fi
mount /dev/sda /tmp/usb_files > /dev/null 2>&1
mount /dev/sda1 /tmp/usb_files > /dev/null 2>&1

if [ -z "$IMAGE_FILE" ]; then
  IMAGE_FILE="$BASE_IMAGE_FILE"
fi

if [[ "${IMAGE_FILE}" =~ "http" ]]; then
  base_image_file="`basename \"${IMAGE_FILE}\"`"
  if [ -f "/tmp/usb_files/$base_image_file" ]; then
    echo "Using /tmp/usb_files/$base_image_file instead of downloading"
    untar_file="/tmp/usb_files/$base_image_file"
  else
    echo "Downloading $IMAGE_FILE..."
    untar_file="/mnt/stateful_partition/$base_image_file"
    wget -c -O "/mnt/stateful_partition/$base_image_file" "$IMAGE_FILE"
    if [ $? -ne 0 ] ; then
      echo "Download failed!"
      exit 1
    fi
  fi
else
  if [ -f "/tmp/usb_files/$IMAGE_FILE" ]; then
    untar_file="/tmp/usb_files/$IMAGE_FILE"
    echo "Using ${untar_file}"
  elif [ -f "$IMAGE_FILE" ]; then
    untar_file="$IMAGE_FILE"
    echo "Using ${untar_file}"
  else
    echo "File '${IMAGE_FILE}' not found, either on USB device or as absolute path!"
    exit 1
  fi
fi

# our mount target
if [ ! -d /tmp/ubuntu ]; then
  mkdir /tmp/ubuntu
fi

echo "Creating filesystem on ${target_rootfs}..."
mkfs.ext4 -j ${target_rootfs} && mount ${target_rootfs} /tmp/ubuntu
if [ $? -ne 0 ] ; then
  echo 'Failed to create and/or mount filesystem!'
  exit 1
fi

if [[ "$untar_file" =~ "tgz" || "$untar_file" =~ ".gz" ]] ; then
  tar xvzCf /tmp/ubuntu "$untar_file"
elif [[ "$untar_file" =~ "bz2" ]] ; then
  tar xvjCf /tmp/ubuntu "$untar_file"
elif [[ "$untar_file" =~ "xz" ]] ; then
  tar xvJCf /tmp/ubuntu "$untar_file"
else
  echo "Hmm... not sure how to untar your file"
  exit 1
fi

# Let's get some firmware in place
cp /lib/firmware/mrvl/sd8797_uapsta.bin /tmp/ubuntu/lib/firmware/mrvl
cp /lib/firmware/mfc_fw.bin /tmp/ubuntu/lib/firmware

# Create the setup script in /tmp/setup-script on the ubuntu partition
cat > /tmp/ubuntu/tmp/setup-script <<EOF
# fix up /etc/shadow so root can log in
passwd -d root

echo "nameserver 8.8.8.8" > /etc/resolv.conf

# update-initramfs will need this
mount -t devpts devpts /dev/pts
mount -t proc proc /proc

echo "deb http://ports.ubuntu.com/ubuntu-ports/ raring universe" >> /etc/apt/sources.list
echo "deb http://ppa.launchpad.net/chromebook-arm/ppa/ubuntu raring main" > /etc/apt/sources.list.d/chromebook-arm.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABBBBD6B
apt-get update
apt-get -y install ubuntu-minimal
apt-get -y install language-pack-en-base wpasupplicant
apt-get -y install cgpt chromebook-s3-default-settings vboot-utils
apt-get -y install linux-tools-3.4.0-5
# we need this because update-initrd will still run, even though
# it doesn't need to and the image package doesn't have an initrd
touch /boot/initrd.img-3.4.0-5-chromebook
# --no-install-recommends is there because the image incorrectly
# recommends flash-kernel, which we don't want
apt-get -y install --no-install-recommends linux-image-chromebook
apt-get -y install xserver-xorg-video-armsoc 
#chromium-mali-opengles

# clean up
umount /dev/pts
umount /proc

if [ ! -d /etc/X11/xorg.conf.d ] ; then mkdir /etc/X11/xorg.conf.d ; fi
if [ ! -f /etc/X11/xorg.conf.d/exynos5.conf ] ; then

cat > /etc/X11/xorg.conf.d/exynos5.conf <<EOZ
Section "Device"
        Identifier      "Mali FBDEV"
        Driver          "armsoc"
        Option          "fbdev"                 "/dev/fb0"
        Option          "Fimg2DExa"             "false"
        Option          "DRI2"                  "true"
        Option          "DRI2_PAGE_FLIP"        "false"
        Option          "DRI2_WAIT_VSYNC"       "true"
#       Option          "Fimg2DExaSolid"        "false"
#       Option          "Fimg2DExaCopy"         "false"
#       Option          "Fimg2DExaComposite"    "false"
        Option          "SWcursorLCD"           "false"
EndSection

Section "Screen"
        Identifier      "DefaultScreen"
        Device          "Mali FBDEV"
        DefaultDepth    24
EndSection

EOZ
fi
EOF

# run the setup script
chroot /tmp/ubuntu bash /tmp/setup-script

echo -e "#!/bin/bash\n" > /tmp/ubuntu/root/quickwpa.sh
echo 'wpa_passphrase $1 $2 | wpa_supplicant -c /dev/stdin -i mlan0 -D nl80211 -B' >> /tmp/ubuntu/root/quickwpa.sh
echo "dhclient mlan0" >> /tmp/ubuntu/root/quickwpa.sh

# now set up the kernel
echo "console=tty1 printk.time=1 nosplash rootwait root=${target_rootfs} rw rootfstype=ext4" > /tmp/ubuntu/boot/cmdline
vbutil_kernel --pack /tmp/ubuntu/boot/chronos-kernel-image --keyblock /usr/share/vboot/devkeys/kernel.keyblock --signprivate /usr/share/vboot/devkeys/kernel_data_key.vbprivk --config /tmp/ubuntu/boot/cmdline --vmlinuz /tmp/ubuntu/boot/vmlinuz-3.4.0-5-chromebook --version 1 --arch arm
dd if=/tmp/ubuntu/boot/chronos-kernel-image of=${target_kern} bs=512

# Unmount ubuntu
umount /tmp/ubuntu

# finally make it bootable, but just once (-S 0: flagged as not successful, -T 1: one try)
cgpt add -S 1 -T 1 -P 12 -i 6 ${target_disk}

echo -e "\n*****************\n"
echo "Done -- reboot to enter Ubuntu."
echo "In Ubuntu, the root password is blank -- please change it and create a user"
echo ""
echo "To connect to a wireless network, type:"
echo "sh quickwpa.sh myssid mypasskey"
#echo "To set Ubuntu to boot again, use 'cgpt add -S 0 -T 1 -P 12 -i 6 ${target_disk}'"

