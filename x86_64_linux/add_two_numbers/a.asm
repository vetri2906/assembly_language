section .data
    num1 dd 20          ; Your first number
    num2 dd 30          ; Your second number

section .bss
    buffer resb 10      ; Space to hold the characters we want to print

section .text
    global _start

_start:
    ; --- 1. THE MATH ---
    mov eax, [num1]     ; Load 20
    add eax, [num2]     ; Add 30 (EAX = 50)

    ; --- 2. CONVERT NUMBER TO ASCII ---
    ; We need to turn the integer 50 into the characters '5' and '0'
    mov ecx, buffer     ; Point ECX to our buffer
    add ecx, 9          ; Move to the end of the buffer (we fill it backwards)
    mov byte [ecx], 10  ; Add a newline character (\n) at the very end
    
    mov ebx, 10         ; We will divide by 10 repeatedly

convert_loop:
    dec ecx             ; Move the pointer back one byte
    xor edx, edx        ; Clear EDX (required for 32-bit division)
    div ebx             ; Divide EAX by 10. Quotient goes to EAX, Remainder to EDX
    add dl, 48          ; Convert the remainder (0-9) to ASCII ('0'-'9')
    mov [ecx], dl       ; Store the character in the buffer
    test eax, eax       ; Is there anything left in EAX?
    jnz convert_loop    ; If yes, go back and get the next digit

    ; --- 3. PRINT THE RESULT ---
    ; At this point, ECX is pointing to the start of our number string
    mov eax, 4          ; sys_write
    mov ebx, 1          ; STDOUT
    ; ECX is already pointing to our string!
    mov edx, buffer     
    add edx, 10         ; Calculate the length of what we wrote
    sub edx, ecx        ; Length = (Buffer End) - (Current Pointer)
    int 80h

    ; --- 4. EXIT ---
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; Return 0
    int 80h
