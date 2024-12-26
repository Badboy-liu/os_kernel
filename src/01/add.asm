[ORG  0x7c00]
[SECTION .data]

[SECTION .text]
[BITS 16]
global _start
    xchg bx,bx
    call add

add:
    xchg bx,bx
    push bp
    mov bp,sp


    mov ax,1
    add ax,2

    test ax,3
    mov ax,0
    cmp ax,0

    mov sp,bp
    pop bp
    ret

times 510-($-$$) db 0
dw 0xaa55
