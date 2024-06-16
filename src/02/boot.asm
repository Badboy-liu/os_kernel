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




    ;读硬盘
    call read_hd
    ;xchg bx,ax
    ;跳过去
    ;mov si,edi
    ;call print
        ;跳过去
    mov si,jmp_to_setup
    call print
    xchg bx,bx
    jmp BOOT_MAIN_ADDR

read_floppy_error:
    mov si,read_floppy_error_msg
    call print
    jmp $


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




read_hd:

    xor ax,ax
    xor dx,dx

    mov dx,0x1f2
    mov al,1
    out dx,al
    ;0000 0000 0000 0000  0000 0002
    ;0x1f3 low 8 bit
    inc dx
    xor ax,ax
    mov al,2
    out dx,al

    ;0x1f4 mod 8 bit
    inc dx
    xor ax,ax
    mov al,0
    out dx,al

    ;0x1f5 hig 8 bit
    inc dx
    xor ax,ax
    mov al,0
    out dx,al

    ;0x1f6
    inc dx,
    xor ax,ax
    and al,0b1110_0000
    out dx,al

    inc dx
    mov al,0x20
    out dx,al

.read_check:
    nop
    mov dx, 0x1f7
    in al, dx
    and al, 0x88  ; 取硬盘状态的第3、7位
    cmp al, 0x08  ; 硬盘数据准备好了且不忙了
    jnz .read_check
    xchg bx,bx
    mov dx,0x1f0
    mov ecx,256
    mov edi, BOOT_MAIN_ADDR

.read_data:


    in ax,dx
    mov [edi],ax
    add edi,2


    loop .read_data
    ret

;.loop:
;    xor ax,ax
;    xor dx,dx
;    mov dx,0x1f7
;    in ax,dx
;    and ax,0x88
;    cmp ax,0x08
;
;    xchg bx,bx
;    jz .read
;    jmp .loop
;
;.read:
;    xchg bx,bx
;    xchg bx,bx
;    mov si,one
;    call print
;    jmp $

read_floppy_error_msg:
    db "read floppy error!",10,13,0

jmp_to_setup:
    db "jump to setup...",10,13,0
one:
    db "one",10,13,0

times 510-($-$$) db 0
;神奇两个一个效果
;dw  0xaa55
db 0x55,0xaa
