; A 32 bit OSX Assembly Hello World
; See: http://stackoverflow.com/a/40814828/1240482
;
; 64-bit OS/X pretty much uses the same kernel calling convention as 64-bit
; Linux. The 64-bit Linux System V ABI applies for the System Calls. In
; particular the section A.2 AMD64 Linux Kernel Conventions.
; (https://www.uclibc.org/docs/psABI-x86_64.pdf).  That section has
; these rules:
;
; User-level applications use as integer registers for passing the sequence
; %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface uses
; %rdi, %rsi, %rdx, %r10, %r8 and %r9. A system-call is done via the syscall
; instruction. The kernel destroys registers %rcx and %r11. The number of the
; syscall has to be passed in register %rax. System-calls are limited to six
; arguments, no argument is passed directly on the stack. Returning from the
; syscall, register %rax contains the result of the system-call. A value in
; the range between -4095 and -1 indicates an error, it is -errno. Only values
; of class INTEGER or class MEMORY are passed to the kernel. 64-bit OS/X uses
; the same System Call numbers as 32-bit OS/X, however all the numbers have
; to have 0x02000000 added to them. The code above can be modified to work as
; a 64-bit OS/X program:
global start
section .text

start:
    ; Please note that when writing to a 32-bit register, the CPU
    ; automatically zero extends to the 64-bit register. The code below
    ; uses this feature by writing to registers like EAX, EDI instead of RAX
    ; and RDI. You could have used the 64-bit registers but using the 32-bit
    ; registers saves a byte in the code.
    mov     eax, 0x2000004 ; write system call
    mov     edi, 1         ; stdout = 1
    mov     rsi, msg       ; address of the message to print
    ;lea     rsi, [rel msg]; Alternative way using RIP relative addressing
    mov     edx, msg.len   ; length of message
    syscall                ; Use syscall, NOT int 0x80

    mov     eax, 0x2000001 ; exit system call
    mov     edi, 42        ; return 42 when exiting
    syscall

section .rodata

msg:    db      "Hello, world!", 10
.len:   equ     $ - msg
