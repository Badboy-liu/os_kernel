#include <iostream>
void test(int i);

class Foo {
public :
    Foo() {
        x = 100;
    }

    ~Foo() {
        std::cout << "~Foo() called" << std::endl;
    }

private:
    int x;
};

class Bar {

public:
    Bar() {
    }

    ~Bar() {
        std::cout << "~Bar() called" << std::endl;
    }
};


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
     printf("i==%d",i);
     {
         Foo foo;
     }

     Bar *b = new Bar();
     delete b;
}



