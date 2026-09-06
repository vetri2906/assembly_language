global _start

section .data
    msg_start   db "Executing x86-64 instruction sequence...", 10
    len_start   equ $ - msg_start
    
    msg_done    db "Execution complete. Exit code 0.", 10
    len_done    equ $ - msg_done

section .text

_start:
    ; 1. Print Start Message (sys_write)
    mov     rax, 1          ; sys_write
    mov     rdi, 1          ; stdout
    mov     rsi, msg_start  ; buffer address
    mov     rdx, len_start  ; length
    syscall

    ; 2. Execute Register Operations
    mov     rax, 0x1234
    mov     rbx, rax
    add     rax, rbx        ; rax = 0x2468

    ; 3. Store and Load Stack Values
    sub     rsp, 16
    mov     qword [rsp], rax
    mov     rcx, qword [rsp]
    add     rsp, 16

    ; 4. Print Completion Message
    mov     rax, 1          ; sys_write
    mov     rdi, 1          ; stdout
    mov     rsi, msg_done
    mov     rdx, len_done
    syscall

    ; 5. Exit Program (sys_exit)
    mov     rax, 60         ; sys_exit
    mov     rdi, 0          ; status 0
    syscall
