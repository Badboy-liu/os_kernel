准备环境
Bochs 

clion  
插件 hex editor
可以看见编译出来的bin结尾是在512字节处 55aa   
510字节 + 55 + aa = 512字节
55 是10进制的85
aa 是10进制的170
bios会去读取第一块磁盘空间第一个磁道


编写 disp.asm 

create vdisk file=E:/project/cpp/os_kernel/src/dingst.vhd maximum=10 type=fixed

cmd -> diskpart

编译
dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc



mingw32-make clean
mingw32-make bochs



cpu 架构
    cisc 复杂指令集  x86 intel amd     pc,m1之前
    risc 极简指令集  arm  苹果,高通,海思 移动,m1之后

硬编码只和cpu有关系   硬编码===机器码
cpu只能执行机器码


汇编语言是什么
影响因素
    1.cpu的位数  16bit 32bit 64bit 决定了cpu的寻址模式
        寄存器的位数 寄存器的个数
    2.cpu架构
        x86 cisc
        arm risc
    3.os的影响
    masm windows默认
    nasm masm升级版
    att  linux的

    unox mac m1之前,ubuntu centos

寄存器    代码
cpu缓存  redis
内存     mysql


    

通用寄存器
    16位cpu 8个
    32位cpu 8个
    64位cpu 16个   8+r8-r15
段寄存器
    个数,位数都一样
    16位
    cs
    ss
    ds
    es
    fs
    gs


控制寄存器
    cr0   保护模式
    cr1   分页
    cr2   缺页异常 


rex  64位寄存器
eax  32为寄存器
ah   高8位
al   低8位


16位cpu
    不能计算超过2的16次方的数


ax
eax
rax
用于装返回参数和计算


ecx 
1.循环用的
2.this指针


rsi source index  源地址
rdi destination index 目标地址


rep 指令  重复指令

rbp  栈低指针
rsp  栈顶指针

通用寄存器可以用mov

eip    程序计数器 只能跳转指令去操作
eflags 状态寄存器   32bit (64/32位都是32位的eflags)
eflags 和gcc指令结合使用


sti 开中断
cli 关中断
在状态寄存器第九位 if 是否执行中断  1执行


test 做与运算
cmp 做减法

zf 是0标志 在状态寄存器第6位
相同 zf = 0  
不同 zf = 1



gcc 指令
    jne 不等于0就跳
    je 等于0就跳
    jz 等于0就跳
    jze 不等于0就跳


题目1
    int a = 1;
    if(a>10){
        a=10
    }
    a = 100;

    xor eax,eax
    mov eax,1
    cmp eax,10
    jg 0x000,
    mov eax,100

    mov eax,10

[//]: # (题目二    )
    int a = 1;
    int b = 2;
    if(a>b){
        a = 100;
    }
    a = 10
    
    xor eax,eax
    mov eax,1
    cmp eax,2
    jg 0x1111
    mov eax,10

    mov eax,100

[//]: # (题目三)
    int a = 10;
    while(a>0){
        a--;
    }

    mov eax,[ebp-4]
    mov ebx,[ebp-4]

begin:
    cmp eax,5
    jg end
    add ebx,eax
    inc eax
    jmp begin

end:
    mov [ebp-4],eax
    mov [ebp-8],ebx


认知的四个级别:
    (发表言论,或者交流,表达了自己认知以外的东西)     不知道自己知识外的                    (知识范围有限)
    (探查自己认知不足以表达事物全貌)               知道了自己认知外还有东西               (自我察觉,有认知范围之外的东西)
    (试图描述自己知道的范围)                     知道了自己知道哪些                    (圈定自己知道的知识范围)
    (认知是零散的)                             不知道自己已经熟悉了事物边缘            (连接多个记忆为一个事物)

方法执行流程:
    -1.push变量进入栈帧
    0.jmp 函数地址 跳转到起始地址
    1.开辟栈空间
    2.分配栈内存(windows会分配内存,linux不会分配内存),(初始化栈帧debug会让栈帧全是0xcccccccch,release不会)
    3.保护现场(保护寄存器内的值,压到栈里面) push进去,让这些寄存处重新让出来可以计算
    4.我们的代码
    5.恢复现场
    6.恢复栈帧

恢复栈帧:
    push 变量
    call 函数
    mov ebp,esp
    开辟栈空间
    分配内存
    保存环境
    执行我们的代码
    恢复环境(pop edi esi ebx)
    mov esp,ebp
    pop ebp
    ret (pop esp,jmp esp)
    



ebp 找传的变量
esp 找局部变量

bp 16位
ebp 32位
rbp 64位
执行函数或者执行流
    必须保证 esp和ebp是不变的 

clion 看函数堆栈 disas

在开辟栈时候 
    windows 开辟栈后,分配内存  默认值是 int 3(也就是汇编,也就是调试断点) 0xcccccccch   也就是烫烫烫
    linux   开辟栈后,分配内存  默认值是0x00000000h   








