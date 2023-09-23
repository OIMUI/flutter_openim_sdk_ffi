#include "cJSON/cJSON.h"

#ifdef _WIN32 // Windows平台
#include "openim_sdk_ffi_windows.h"
#elif defined(__APPLE__) && defined(__MACH__) // macOS平台
#include "openim_sdk_ffi_macos.h"
#elif TARGET_OS_IOS // iOS平台
#include "openim_sdk_ffi_ios.h"
#elif defined(__ANDROID__) // Android平台
#include "openim_sdk_ffi_android.h"
#else
#error "未知平台"
#endif

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#endif

typedef struct
{
    Dart_Port_DL port;
    char *methodName;
    char *operationID;
    char *callMethodName;
    double *errCode;
    char *message;
} ThreadArgs;

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

FFI_PLUGIN_EXPORT Openim_Listener getIMListener();