# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(flutter_openim_sdk_ffi_library VERSION 0.0.1 LANGUAGES C)

add_library(flutter_openim_sdk_ffi SHARED
  "flutter_openim_sdk_ffi.c"
  "openim_sdk_ffi_android.h"
)

set_target_properties(flutter_openim_sdk_ffi PROPERTIES
  PUBLIC_HEADER flutter_openim_sdk_ffi.h
  OUTPUT_NAME "flutter_openim_sdk_ffi"
)

target_compile_definitions(flutter_openim_sdk_ffi PUBLIC DART_SHARED_LIB)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_link_libraries(flutter_openim_sdk_ffi PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../linux/libopenim_sdk_ffi.so)

elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")
  file(GLOB ANDROID_SO_FILES ${CMAKE_CURRENT_SOURCE_DIR}/../android/libs/${CMAKE_ANDROID_ARCH_ABI}/*.so)
    
  # 将所有.so文件链接到库
  target_link_libraries(flutter_openim_sdk_ffi PUBLIC ${ANDROID_SO_FILES})
#elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
#  target_link_libraries(flutter_openim_sdk_ffi PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../windows/openim_sdk_ffi.dll)
endif()

# target_link_libraries(flutter_openim_sdk_ffi log)