cmake_minimum_required(VERSION 3.26)
project(os_kernel)

set(CMAKE_CXX_STANDARD 11)

add_executable(os_kernel main.cpp
        src/04/init/main.c
)
