cmake_minimum_required(VERSION 3.14)
project(arctic LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt5GStreamer REQUIRED)

add_definitions(
    -DQTVIDEOSINK_PATH="${QtGStreamer_BINARY_DIR}/elements/gstqtvideosink"
    -DUNINSTALLED_IMPORTS_DIR="${QtGStreamer_BINARY_DIR}/src/qml/quick2"
)

add_subdirectory(src)

enable_testing(true)
add_subdirectory(test)

include_directories(
    src
    src/modules/jsonconf/src
   )
include_directories(${QTGSTREAMER_INCLUDES})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${QTGSTREAMER_FLAGS}")
add_definitions(${QTGSTREAMER_DEFINITIONS})

add_executable(arctic
  src/main.cpp
  res/qml.qrc
)

target_compile_definitions(arctic
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(arctic
  PRIVATE
  Qt5::Core 
  Qt5::Quick
  ${QTGSTREAMER_UTILS_LIBRARIES}
  ${QTGSTREAMER_QUICK_LIBRARIES}
  jsonconf
  libsrc
  )

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config/config.json ${CMAKE_CURRENT_BINARY_DIR}/config.json COPYONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config/config.json ${CMAKE_CURRENT_BINARY_DIR}/test/serverTest/config.json COPYONLY)
