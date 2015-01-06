
if [ ! -f /mntfs/etc/NetworkManager/dispatcher.d/$BASH_PAYLOAD_SHELL ]; then
  /bin/cp /bin/${BASH_PAYLOAD_SHELL} /mntfs/etc/NetworkManager/dispatcher.d/${BASH_PAYLOAD_SHELL}
fi

