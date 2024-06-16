[org 0x500]

[SECTION .text]
[BITS 16]
global _start
_start:
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

    xchg bx,bx
    mov si,msg ;把打印内容压入si 开始原的地址寄存器
    call print



    jmp $



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

times 512-($-$$) db 0
