lgdt 读取gdt表
sgdt 设置get表


gdt global descriptor table 全局描述符表
ldt local descriptor table 局部描述符表

gdt gdt表大小 8KB 最多512个gdt表 0是空的 1-511
    代码段 s = 1
        可执行权限
        读写权限
        长度,范围
        入口地址 
        权限
        bits
        status 是否有效
    数据段
    系统段 s = 0


问题
1.怎么知道是系统段还是代码段和数据段
s = 0 是系统段
s = 1 是代码段和数据段
type小于8     数据段
type大于等于8 代码段

limit是段大小
0-15 16-19  20位

dpl cpl rpl 
dpl 权限  0>1>2>3
cpl code segment 段寄存器 16位
    0-1     代表权限 0最高
    2       0=>gdt表 1=>ldt表
    3-15位  index  2的13次方-1 = 8192 
avl

d/b位  [bits 16] 0代表16位 1代表32位
limit 20bit 1M
g = 0 代表字节 ffffb 512个字节
g = 1 代表4KB fffffb*4K 4gb
p 0代表有效 1代表无效


00cf9b00 0000ffff
0000 0000 g:1 db:1 0 avl:0 limit:1111 p:1 dpl:00 s:1  type:1011 base:0000 0000 
base:0000 0000 0000 0000 limit:1111 1111 1111 1111



ldt ldt表大小 4KB

一个页4KB 

cpu进入保护模式的三个条件
    1. 打开A20
    2. 打开cr0的PE位
    3. 构建gdt表

描述符
    全部是64位,8字节



数据段



1.构建gdt表
    段描述符 8B 8字节
    最多少个 8kB   
    只用一页 4KB/512  10个左右
    gdtr 存储gdt表的地址和元素个数 6B 6字节
        0-1 gdt表的大小
        2-5 存储元素个数的地址
    sgdt 写gdtr寄存器
    lgdt 读取gdtr寄存器

    1.代码构建选择子
        1.汇编写
            dd dw dd dq
            两字节 与上0xffff取到低16位
            dw limit & 0xffff
            两字节 与上0xffff取到低16位
            dw base  & 0xffff
            db (base>>16)  & 0xff
            db 0b1001_0010
            db 0b1100_0000 | (limit>>16 & 0xf)
            db (base>>24) & 0xff
        2.c语言写
    2.操作gdtr表    
2.开启a20总线
3.开启保护模式
cr0 开启保护模式,开启分页 把第0位PE置为1开启保护模式,把31位PG置为1开启分页
cr1 没用
cr2 保存物理地址,会产生缺页中断
cr3 保存页目基地址