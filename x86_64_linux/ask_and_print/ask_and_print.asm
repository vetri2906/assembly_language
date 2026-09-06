section .data
    prompt db 'Enter your name: '
    promptLen equ $-prompt
    entered_name db 'your name is: '
    entered_nameLen equ $-prompt

section .bss
    name resb 32          ; Reserve 32 bytes for the input

section .text
    global _start

_start:
    ; 1. PRINT THE PROMPT
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    ; 2. READ THE INPUT
    mov eax, 3            ; sys_read
    mov ebx, 0            ; stdin (keyboard)
    mov ecx, name         ; address to store input
    mov edx, 32           ; max bytes to read
    int 80h               ; program pauses here for user input

    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, entered_name ;
    mov edx, entered_nameLen ;
    int 80h
    mov ecx, name ;
    mov edx, 5 ;
    int 80h
    
    ; 3. EXIT
    mov eax, 1            ; sys_exit
    mov ebx, 0
    int 80h
