# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(open_im_sdk_library VERSION 0.0.1 LANGUAGES C)

add_library(open_im_sdk SHARED
  "open_im_sdk.c"
)

set_target_properties(open_im_sdk PROPERTIES
  PUBLIC_HEADER open_im_sdk.h
  OUTPUT_NAME "open_im_sdk"
)

target_compile_definitions(open_im_sdk PUBLIC DART_SHARED_LIB)