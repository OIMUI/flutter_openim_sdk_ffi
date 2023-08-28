#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "./include/dart_api_dl.h"
#include "cJSON/cJSON.h"

#ifdef _WIN32
    #include "openim_sdk_ffi_windows.h"
#elif __linux__
    #include "openim_sdk_ffi_android.h"
#elif __APPLE__
    #include "openim_sdk_ffi_apple.h"
#endif

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



typedef void (*PrintCallback)(const char*);

FFI_PLUGIN_EXPORT void setPrintCallback(PrintCallback callback);
FFI_PLUGIN_EXPORT void ffi_Dart_RegisterCallback(void *handle, Dart_Port_DL isolate_send_port);
FFI_PLUGIN_EXPORT intptr_t ffi_Dart_InitializeApiDL(void *data);