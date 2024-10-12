cmake_minimum_required(VERSION 3.30 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD "0e5b6991-d74f-4b3d-a41c-cf096e0b2508")
set(CMAKE_CXX_MODULE_STD ON)

message(STATUS "C++ standard library ${CMAKE_CXX_STANDARD_LIBRARY}")

project(
    NEWPROJNAME
    VERSION 0.0.1
    LANGUAGES CXX)

if (NOT CMAKE_GENERATOR MATCHES "Ninja*")
    message(FATAL_ERROR "Only Ninja supports modules")
endif ()

if (NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_VERSION
                                                  VERSION_LESS "18.1.3")
    message(FATAL_ERROR "Only clang (v18.1.3+) supports C++23 modules")
endif ()

add_executable(NEWPROJNAME NEWPROJNAME.cpp)

target_sources(NEWPROJNAME PRIVATE FILE_SET CXX_MODULES FILES mod.cxx)

target_compile_options(NEWPROJNAME PRIVATE -Wall -Wextra -Werror -Wpedantic)

#[[
    To config run:
    cmake \
        -G Ninja \
        -S . \
        -B build \
        -DCMAKE_CXX_COMPILER=clang++-18 \
        -DCMAKE_CXX_FLAGS=-stdlib=libc++ \
        -Wno-dev
]]
