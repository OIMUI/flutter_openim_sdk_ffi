#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "./include/dart_api_dl.h"
#include "cJSON/cJSON.h"

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif


#ifdef _WIN32
    #include "openim_sdk_ffi_windows.h"
#elif __linux__
    #ifdef __ANDROID__
        #include "openim_sdk_ffi_android.h"
    #else
        #include "openim_sdk_ffi_linux.h"
    #endif
#elif __APPLE__
    #include "TargetConditionals.h"
    #if TARGET_OS_MAC
        #include "openim_sdk_ffi_macos.h"
    #elif TARGET_OS_IPHONE
        #include "openim_sdk_ffi_ios.h"
    #endif
#endif

typedef void (*PrintCallback)(const char*);

FFI_PLUGIN_EXPORT void setPrintCallback(PrintCallback callback);
FFI_PLUGIN_EXPORT void ffi_Dart_RegisterCallback(void *handle, Dart_Port_DL isolate_send_port);
FFI_PLUGIN_EXPORT intptr_t ffi_Dart_InitializeApiDL(void *data);