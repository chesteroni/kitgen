#!/bin/bash
IF=$1
STATUS=$2

case "$2" in
  up)
    /etc/tcpsd &
    ;;
  *)
    ;;
esac
