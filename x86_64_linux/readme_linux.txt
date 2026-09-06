To turn your Assembly source code (usually saved with a .asm extension) into a running program, you need to go through two main steps: Assembling and Linking.

Since your code uses int 80h, it is designed for 32-bit Linux. Here is the process using NASM (the Netwide Assembler).

1. Install the Tools
If you are on Ubuntu or Debian, you can install the necessary tools with:

Bash

sudo apt update
sudo apt install nasm binutils-multiarch
2. The Conversion Process
Assuming your file is named hello.asm, run these two commands in your terminal:

Step A: Assemble (Create the Object File) This converts your text code into machine code "snippets" called an object file (.o).

Bash

nasm -f elf32 a.asm -o a.o
-f elf32: Tells NASM to format the output for 32-bit Linux.

Step B: Link (Create the Executable) The linker takes the object file and organizes it into a final executable that the OS understands.

Bash

ld -m elf_i386 a.o -o a
-m elf_i386: Ensures the linker treats it as a 32-bit program.

3. Run Your Program
Once linked, you can run the resulting file just like any other Linux command:

Bash

./a

or 
nasm -f elf64 new1.asm -o a.o
ld a.o -o a.out
./a.out
