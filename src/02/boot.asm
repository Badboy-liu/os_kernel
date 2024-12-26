[org 0x7c00]
[SECTION .DATA]
BOOT_MAIN_ADDR EQU 0x500

[SECTION .TEXT]
[BITS 16]
global _start
call clear_screen

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

    mov si,jmp_to_setup
    call print
    
    call read_fd
    
    jmp BOOT_MAIN_ADDR
    

clear_screen:
    mov ax,3
    int 10h


print:
    mov ah,0x0e
    mov bh,0
    mov bl,0x01
.loop:
    mov al,[si]
    cmp al,0
    jz .done
    int 10h
    
    inc si
    jmp .loop
.done:
    ret

read_fd:
    xor ax,ax
    xor dx,dx
    
    mov dx,0x1f2
    mov al,1
    out dx,al
    
    ;0x1f3
    inc dx
    xor ax,ax
    mov al,2
    out dx,al
    
    ;0x1f4
    inc dx
    xor ax,ax
    mov al,0
    out dx,al
    
    ;0x1f5
    inc dx
    xor ax,ax
    mov al,0
    out dx,al
    
    ;0x1f6
    inc dx
    xor ax,ax
    xchg bx,bx
    and al,0b11100000
    out dx,al
    
    ;0x1f7
    inc dx
    mov al,0x20
    out dx,al
.read_check:
    nop
    in al,dx
    and al,0x88
    cmp al,0x08
    jnz .read_check

    mov dx,0x1f0
    xor ecx,ecx
    mov ecx,256
    mov edi,BOOT_MAIN_ADDR
.read_data:
    in ax,dx
    mov [edi],ax
    add edi,2
    loop .read_data
    ret
    


jmp_to_setup:
    db "jump to setup...",10,13,0
    

times 510-($-$$) db 0
dw 0xaa55