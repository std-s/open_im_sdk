# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(open_im_sdk_library VERSION 0.0.1 LANGUAGES C)

add_library(open_im_sdk SHARED
  "open_im_sdk.c"
  "open_im_sdk.h"
)

set_target_properties(open_im_sdk PROPERTIES
  PUBLIC_HEADER open_im_sdk.h
  OUTPUT_NAME "open_im_sdk"
)

target_compile_definitions(open_im_sdk PUBLIC DART_SHARED_LIB)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_link_libraries(open_im_sdk PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../linux/libopenimsdk.so)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")
  file(GLOB ANDROID_SO_FILES ${CMAKE_CURRENT_SOURCE_DIR}/../android/libs/${CMAKE_ANDROID_ARCH_ABI}/*.so)
  target_link_libraries(open_im_sdk PUBLIC ${ANDROID_SO_FILES})
#elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
#  target_link_libraries(open_im_sdk PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/windows/libopenimsdk.dll)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin") # macOS
  message(STATUS "Library path: ${CMAKE_CURRENT_SOURCE_DIR}/../macos/")
  target_link_libraries(open_im_sdk PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../macos/libopenimsdk.dylib)
elseif(CMAKE_SYSTEM_NAME STREQUAL "iOS")
  target_link_libraries(open_im_sdk PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../ios/openimsdk.framework)
endif()

# target_link_libraries(open_im_sdk PUBLIC)