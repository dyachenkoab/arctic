cmake_minimum_required(VERSION 3.14)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include_directories(statersTest)
add_subdirectory(statersTest)

include_directories(serverTest)
add_subdirectory(serverTest)
