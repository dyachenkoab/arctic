cmake_minimum_required(VERSION 3.0)

project(jsonconf LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

find_package(Qt5 COMPONENTS Core REQUIRED)

if (NOT Qt5_FOUND)
  message(FATAL_ERROR "Qt5 not found")
endif()

add_subdirectory(src)

add_library(${PROJECT_NAME} STATIC ${src_SOURCES})
target_link_libraries(${PROJECT_NAME} Qt5::Core)
