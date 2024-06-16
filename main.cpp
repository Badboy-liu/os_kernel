#include <iostream>
#include <cstdlib> // 引入库以使用system函数
void test(int i);
int main() {
//    std::string clean = "mingw32-make  -f ../Makefile clean";
//    std::string all = "mingw32-make  -f ../Makefile all";
//    const char* command = "echo Hello, World!"; // 要执行的命令
//    system(clean.c_str()); //
//    system(all.c_str()); //

    test(10);
    return 0;
}


 void test(int i){
    printf("%d",i);
}