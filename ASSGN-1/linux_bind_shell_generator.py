#!/usr/bin/python
import sys

print "Stub File:"+sys.argv[1]
print "Port Used:"+sys.argv[2]

with open(sys.argv[1]+".c", "rb") as f:
    contents = f.readlines()

port = hex(int(sys.argv[2])).split('x')[1]
fh, sh = port[:2],port[2:]
if len(fh) == 1: fh = "0" + fh
if len(sh) == 1: sh = "0" + sh
_p = "\\x{0}\\x{1}".format(fh,sh)
for j,i in enumerate(contents):
    if "\\x22\\xb8" in i:
        print "Line Number :" + str(j)
	contents[j] = '"' +  _p +'"'

nf = sys.argv[1]+"_new.c"
with open(nf, "wb") as f:
    f.writelines(contents)
import os
os.system("gcc {0} -o {1} -fno-stack-protector -z execstack".format(nf,sys.argv[1]))
os.system("rm {0}".format(nf))
