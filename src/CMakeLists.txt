cmake_minimum_required(VERSION 3.14)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt5 COMPONENTS Core Multimedia Network REQUIRED)
find_package(Qt5GStreamer REQUIRED)

include_directories(modules/jsonconf/src)
add_subdirectory(modules/jsonconf)

include_directories(${QTGSTREAMER_INCLUDES})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${QTGSTREAMER_FLAGS}")
add_definitions(${QTGSTREAMER_DEFINITIONS})

add_library(libsrc STATIC
  staters.cpp
  staters.h
  camera.cpp
  camera.h
  server.cpp
  server.h
  udpreciever.cpp
  udpreciever.h
)

target_link_libraries(
    libsrc
    jsonconf
    ${QTGSTREAMER_UTILS_LIBRARIES}
    ${QTGSTREAMER_QUICK_LIBRARIES}
    Qt5::Core
    Qt5::Network
    Qt5::Multimedia
    )
