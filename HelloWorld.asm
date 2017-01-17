; A 32 bit OSX Assembly Hello World
; See: http://stackoverflow.com/a/40814828/1240482
; The OS/X system calls are documented by Apple on their website.
; https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
global start

section .text
start:
    ; sys_write syscall
    ; See: https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
    ; 4 AUE_NULL ALL { user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); }
    push    dword msg.len  ; Last argument is length
    push    dword msg      ; 2nd last is pointer to string
    push    dword 1        ; 1st argument is File descriptor (1=STDOUT)
    mov     eax, 4         ; eax = 4 is write system call
    sub     esp, 4         ; On OS/X 32-bit code always need to allocate 4 bytes on stack
    int     0x80

    ; sys_exit
    ; 1 AUE_EXIT ALL { void exit(int rval); }
    push    dword 42       ; Return value
    mov     eax, 1         ; eax=1 is exit system call
    sub     esp, 4         ; allocate 4 bytes on stack
    int     0x80

section .rodata

msg:    db      "Hello, world!", 10
.len:   equ     $ - msg
