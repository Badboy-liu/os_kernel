; 告诉编译器把程序加载到内存7c00处,当bios检查完毕就会跳到此处执行
[ORG  0x7c00]
[SECTION .data]
BOOT_MAIN_ADDR equ 0x500

[SECTION .text]
[BITS 16]
global _start
_start:
    mov ax,0
    mov ss,ax
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    mov si,ax

    ;清屏
    mov ax,3
    int 10h

    mov si,hello
    call print

    jmp $

hello:
    db "hello,os world",10,13,0

print:
    mov ah,0x0e
    mov bh,0
    mov bl,0x01
.loop:
    mov al,[si]
    cmp al,0
    jz .done
    int 0x10

    inc si
    jmp .loop
.done:
    ret

times 510-($-$$) db 0
dw  0xaa55
