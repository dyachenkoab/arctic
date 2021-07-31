cmake_minimum_required(VERSION 3.0)

project(testJsonConf)


set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

find_package(Qt5 COMPONENTS Core REQUIRED)

if (NOT Qt5_FOUND)
  message(FATAL_ERROR "Qt5 not found")
endif()

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} 
	Qt5::Core
	${CMAKE_CURRENT_SOURCE_DIR}/libjsonconf.a)
