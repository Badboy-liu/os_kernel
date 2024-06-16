
// 打开软件
cmd -> diskpart

// 创建软盘  10M  固定大小
create vdisk file=E:\project\cpp\os_kernel\boot.img maximum=10 type=fixed



MBR+GDT 是分区格式 windows 使用disk 查看硬盘的格式


读取软盘三要素
磁道 0   第几条跑道
柱面 0   第几个跑场
扇区 1   第几个区间


操作硬件的两种方式
1:操作端口读写   硬盘,网卡
2.内存映射      显卡
3.bios中断     软盘  int 0x13中断


os突破512字节
boot->setup->loader
boot可以使用446字节可以用
setup
硬件检测
进入保护
载入内核

    两个程序怎么存储到软盘
    谁载入setup
    setup存放在内存哪里
    boot怎么把权限给setup


读取硬盘:
1.初始化硬盘
控制寄存器
2.读写
给硬盘发读写指令->检测硬盘状态->读写

从10000个扇间开始读,读取100个扇间
10000 = 0b     0000   0001  0000 0000   0000   0000

1.发读写指令
0x1f2 = 100

mov ax,100
mov dx,0x1f2
out dx,ax

0x1f3 = 0000 0000

inc dx
xor ax,ax
mov ax,0
out dx,ax

0x1f4 = 0000 0000

inc dx
xor ax,ax
mov ax,0
out dx,ax

0x1f5 = 0000 0001

inc dx
xor ax,ax
mov ax,0
out dx,ax

0x1f6 = 0b11100000         7和5传1   6 是否lba方式读取   4是否读主盘   最后四个固定0000

inc dx
xor ax,ax
mov ax,11100000
out dx,ax



.loop:
xor ax,ax
mov dx,0x1f7
in ax,dx
cmp ax,0x80
jnz .read ;不等于繁忙就读
jmp .loop

.read:
jmp $

2.检测硬盘状态
第七位 0 不繁忙状态
第六位 1 就绪

3.读1f0
一次只能读2B
in
in al,dx     ;al是值,dx是端口
out dx,al    ;al是值,dx是端口


读多个扇区
0x1f2 = 100

从10000开始读 拆成     0000 0001   0000 0000  0000 0000