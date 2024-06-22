[org 0x500]


[SECTION .data]
KERNEL_ADDR equ 0x1200

[SECTION .gdt]
SEG_BASE equ 0
SEG_LIMIT equ 0xfffff

CODE_SELECTOR equ (1 << 3)
DATA_SELECTOR equ (2 << 3)

gdt_base:
    dd 0,0
gdt_code:
    ;db 1B
    ;dw 2B
    ;dd 4B
    ;dq 8B
    dw  SEG_LIMIT & 0xffff
    dw  SEG_BASE & 0xffff
    db  SEG_BASE >> 16 & 0xff
    db  0b100_1_1000
    db  0b1100_0000| (SEG_LIMIT>>16 & 0xf)
    db  SEG_BASE>>24 & 0xff

gdt_data:
    dw SEG_LIMIT & 0xffff
    dw SEG_BASE & 0xffff
    db SEG_BASE>>16 & 0xff
    db 0b1_00_1_0010
    db 0b1100_0000 |(SEG_LIMIT>>16 & 0xf)
    db SEG_BASE>>24 & 0xff

gdt_ptr:
    dw $-gdt_base-1
    dd gdt_base

[SECTION .text]
[BITS 16]
global setup_start
setup_start:
    mov si,one
    call print
    mov si,0

    mov ax,0
    mov ss,ax
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    mov si,ax


enter_protected_mode:
    ;关中断
    cli

    ;加载gdt
    lgdt [gdt_ptr]

    ;开启a20总线;不开启会地址环绕
    in al,92h
    or al,00000010b
    out 92h,al

    mov eax,cr0
    or eax,1
    mov cr0,eax


    xchg bx,bx
    ;mov si,msg ;把打印内容压入si 开始原的地址寄存器
    ;call print

    jmp CODE_SELECTOR:protected_mode





;mov si,字符
;call print
print:
    mov ah,0x0e ;设置视频中断功能号,0x0e表示TTY模式下的字符打印
    mov bh,0    ;设置也好,这里设置为第0页
    mov bl,0x01 ;设置颜色数学,这里设置为亮蓝色背景(01是亮蓝色的背景属性)
.loop:;开始循环
    mov al,[si] ;从读取si第一个字符到al寄存器
    cmp al,0    ;判断al寄存器是否为0
    jz .done    ;如果为0,跳转.done
    int 0x10    ;调用bios中断0x10,这里是视频服务中断,用户屏幕上打印字符

    inc si      ;递增si,准备打印下一个字符
    jmp .loop   ;重新走入循环
.done:
    ret

one:
    db "00000",10,13,0
msg:
    db "hello",10,13,0

;太重点了
[BITS 32]
protected_mode:
    mov ax,DATA_SELECTOR
    mov ds,ax
    mov ss,ax
    mov es,ax
    mov fs,ax
    mov gs,ax

    mov esp,0x9fbff

    mov edi,KERNEL_ADDR
    mov ecx,3
    mov bl,60
    call read_hd

    jmp CODE_SELECTOR:KERNEL_ADDR


    mov byte [0x100000],0xaa
    jmp $


read_hd:
    mov dx,0x1f2
    mov al,bl
    out dx,al

    inc dx
    mov al,cl
    out dx,al

    inc dx
    mov al,0
    out dx,al

    inc dx
    shr ecx,16
    mov al,cl
    out dx,al

    inc dx
    shr ecx,8
    and cl,0b1111
    mov al,0b1110_0000
    or al,cl
    out dx,al

    inc dx
    mov al,0x20
    out dx,al
    ;bl = 60
    mov cl,bl

.start_read:
    push cx
    call .wait_hd_prepare
    call read_hd_data
    pop cx

    loop .start_read

.return:
    ret

.wait_hd_prepare:
    mov dx,0x1f7

.check:
    in al,dx
    and al,0x88
    cmp al,0x08
    jnz .check

    ret


read_hd_data:
    mov dx,0x1f0
    mov cx,256

.read_word:
    in ax,dx
    mov [edi],ax
    add edi,2
    loop .read_word

    ret