cmake_minimum_required(VERSION 3.30 FATAL_ERROR)

set(CMAKE_CXX_STANDARD NEWPROJCPPSTD)

project(
    NEWPROJNAME
    VERSION 0.0.1
    LANGUAGES CXX)

add_executable(NEWPROJNAME src/NEWPROJNAME.cpp)

target_compile_options(NEWPROJNAME PRIVATE -Wall -Wextra -Werror -Wpedantic)
