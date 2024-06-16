ebp 0
esp ffd6


fun传参从右到左
第一个参数是 ebp+4
第二个参数是 ebp+8


ret 的本质是什么
    pop eax
    jmp eax

ret 8
    pop eax
    add esp,8
    jmp eax

调用约定:(与语言无关,与操作系统有关)
    1.cdecal windows默认的
        1.传参方式 从右到左
        2.平栈方式:
            1.内平栈 调用函数的内部填平堆栈 ret8
            2.外平栈 esp+8 在方法执行完后加上穿进去的入参的大小平栈
            3.ebp固定的值所以可以来找传入的参数
                ebp
                return address
                参数1 
                参数2
                怎么取参数1 [ebp+8]
                怎么取参数2 [ebp+c]
            4.为什么要平栈,因为要执行后面的正常的代码,入参和子函数改变了ebp和esp,
                在ret时要使ebp和esp回到调用函数的地方继续执行,所有需要平栈,这是一直栈修复技术
    2.stdcall windows dll 动态链接库默认的 
    3.fastcall linux默认的
        32和64不一样
        浮点寄存器xmm
        32 ecx和edx,通过寄存器传参,如果参数超过两个就借助栈传参,前两个参数永远用寄存器传参 eax,edx,第三个通过push放进栈
        64 6个寄存器,通过寄存器传参,如果参数超过六个就借助栈传参,前六个参数永远用寄存器传参 eax,edx,第三个通过push放进栈
    4.
        windows是内平栈  ret 8
        linux是外平栈    add esp,8



汇编到底是为了什么
    执行流
        结构  bp sp
            1.了解
            2.构建
            3.破坏 rop
        调用约定  入参和call 平栈
            cdecal
            stdcall
            fastcall
        指令
        add/move
        寄存器
        eflags+jcc指令


bios 主板上的系统
cmos 记录bios新的的一个存储器




        