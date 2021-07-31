cmake_minimum_required(VERSION 3.14)

project(serverTest LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Test REQUIRED)
include_directories(../../src)
include_directories(../../src/modules/jsonconf/src)

add_executable(serverTest test.cpp)
add_test(NAME serverTest COMMAND serverTest)

target_link_libraries(serverTest
    libsrc
    Qt5::Test
    Qt5::Core
    )

