section .data
	hello:     db 'Hello world!',10    ; 'Hello world!' plus a linefeed character
	helloLen:  equ $-hello             ; Length of the 'Hello world!' string

section .text
	global _start

_start:
	mov rax,4            ; The system call for write (sys_write)
	mov rbx,1            ; File descriptor 1 - standard output
	mov rcx,hello        ; Put the offset of hello in ecx
	mov rdx,helloLen     ; helloLen is a constant, so we don't need to say
	                     ;  mov edx,[helloLen] to get it's actual value
	syscall
	mov rax,1            ; The system call for exit (sys_exit)
	mov rbx,0            ; Exit with return code of 0 (no error)
	syscall
