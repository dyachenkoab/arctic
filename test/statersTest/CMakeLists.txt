cmake_minimum_required(VERSION 3.14)

project(statersTest LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Test REQUIRED)
include_directories(../../src)

add_executable(statersTest test.cpp)
add_test(NAME statersTest COMMAND statersTest)

target_link_libraries(statersTest
    libsrc
    Qt5::Test
    Qt5::Core
    )

