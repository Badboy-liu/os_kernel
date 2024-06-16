; 告诉编译器把程序加载到内存7c00处,当bios检查完毕就会跳到此处执行
org 07c00h
[SECTION .text]
[BITS 16]
    mov ax,3
    int 0x10
    ; 把cs移动到ax   cs是代码段  code Segment  ax是cup当前要读取的地址  ds是寄存器存放要访问数据的段地址
    mov ax,0
    mov ax,cs
    mov ds,ax
    mov es,ax


  ;清屏
    mov ax,3
    int 10h

    xchg bx,bx

    call add
; $ 当前指令的位置
    jmp $
add:
	push bp
	mov bp,sp
	mov ax,1
	add ax,2
	mov sp,bp
	pop bp
	ret
; times 执行次数
; global 导出
;510 -(当前位置-这个选择子段的起始位置)
times 510-($-$$) db 0
dw  0xaa55                   ; 结束标志
