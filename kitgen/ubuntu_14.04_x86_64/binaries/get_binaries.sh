#!/bin/bash
files=( 
"/bin/cp" 
"/bin/cat" 
"/bin/chmod"
"/usr/bin/cut"
"/bin/grep"
"/usr/bin/head"
"/bin/mkdir"
"/bin/mktemp"
"/usr/bin/tail"
"/usr/bin/tee"
"/bin/touch"
"/bin/umount"
"/sbin/vgchange"
"/sbin/vgscan"
"/lib/x86_64-linux-gnu/libmount.so.1.1.0"
)

for i in "${files[@]}" 
do
  cp "$i" ./
done

