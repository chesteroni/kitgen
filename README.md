Kitgen
======

Kitgen is a simple generator of linux bootkits.
It is designed to infect the initrd files, especially on Ubuntu Linux systems. It was designed for educational
purposes only and can be used only against those systems, which you are permitted to infect, e.g. during
penetration testing. It is not allowed to use it without permission of the system's owner and doing it may put
you in risk of a lawsuit, prosecution and even in being in prison, depending on the law in your country.

But if you obtained permission, you can use it as long, as you wish. If you want to modify this software, please
be aware that it is released under GPL 2.0 licence which is also included in the LICENCE.txt file.
You are also welcome to make pull requests to this project.

Usage in short words:
---------------------
1. You have to prepare binaries and payloads
2. Just run kit/kitgen.sh - it will generate the target script
3. Boot victim's computer from pendrive containing all the stuff
4. Run generated script

Details:
--------
Initrd is a compressed file which contains basic operating system. That system is being loaded at the boot time
and contains - among other things - binaries and scripts needed to decrypt the encrypted hard drive with the main
system. In Ubuntu, that process is in the cryptroot shell script located at the scripts/local-top directory.

This bootkit modifies that script adding capturing the password and using it to put some malicious code in the
decrypted hard drive. To achieve that, there are needed some binaries, e.g. mkdir, cat etc.

Those binaries need to be prepared prior to bootkit run and you are responsible for copying them in the right
place. There is helping script shell if your environment matches targeted system (if you run kitgen bootkit generator
in the same system version as is the target). If you run in different system, then you need to install somewhere the
same version as the target (e.g. install Ubuntu 14.04 in VirtualBox) and copy the needed files - look into the 
helping shell script to know, which files to copy.

You also need to prepare payloads. Three are supported:
- the keylogger - simple key logger from github. Download it, compile and rename or use a script under binaries/payload
directory
- the meterpreter reverse shell - get some from Metasploit, described in readme.txt under binaries/payload
- the bash reverse shell - modify it to your needs (IP and port), described in readme.txt under binaries/payload
Of course you can add your own.

Having completed binaries' and payloads' preparation, you can now generate the bootkit script.
Just run kitgen/kitgen.sh, choose the system, choose the payloads to be included and you will have ready-to-use
script kitgen/pwn.sh.
Now take the pendrive to the victim's system, boot it from the pendrive and run kitgen/pwn.sh

Warning! 
--------
Initrd files may differ between kernel versions. There is attached sample config containing manually
determined line numbers to modify. If the target runs different kernel version, there will be made an attempt
to automatically determine those lines. But if that attempt will produce invalid result and you will accept
it, you will crash the target system and that would be a real distaster. That's why before modification, the 
target's initrd file is backed up in work_YYYY-MM-DD-HH-MM-SS directory. It may be wise to start target's system
after infection and to check if it asks for a decryption password. If no - boot from the pendrive again and
manually restore the initrd file.



FAQ
---
1. Why binaries are not included?
Because of the GPL - binaries MUST be shipped with their source, license etc.
2. Why payloads are not included?
Payloads are either customisable or licensed. Instead of that there are provided detailed instructions
3. Why only Ubuntu 14.04 x86_64 is supported?
This is merely a Proof-of-concept. It was created to be extensible, but so far It was not tested on other distros.
However, you can prepare your custom system, just watch at the code and copy the code
4. Which system should be installed on pendrive?
Ideally - identical to the victim's one. Because of the ease of gathering binaries. But it really is not important, 
as long as you do have a possibility in that system to mount and use lvm.
5. Why the bash scripting is inconsistent and lame?
I am not the Bash ninja and this is merely a proof of concept. It may be improved and rewritten and maybe it should be. 
