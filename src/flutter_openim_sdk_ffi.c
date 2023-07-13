#include <stdio.h>
#include "flutter_openim_sdk_ffi.h"
#include "include/dart_api_dl.c"
#include "cJSON/cJSON.c"

#if _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#include <pthread.h>
#endif

// 定义回调函数
PrintCallback printCallback;

static CGO_OpenIM_Listener g_listener;

static void* dlfHandle;

#ifdef __ANDROID__
#include "flutter_openim_sdk_ffi_android.c"
#endif

// 定义参数结构体
typedef struct {
    Dart_Port_DL port;
    char* methodName;
    char* operationID;
    char* callMethodName;
    double* errCode;
    char* message;
} ThreadArgs;

// 设置回调函数
void setPrintCallback(PrintCallback callback)
{
    printCallback = callback;
}

// 打印函数
void printMessage(const char *message)
{
    // 调用回调函数，将打印的内容传递给Dart层
    if (printCallback)
    {
        printCallback(message);
    }
}

#if defined(_WIN32) || defined(_WIN64)

    DWORD WINAPI entry_point(LPVOID arg)
{
    ThreadArgs* args = (ThreadArgs*)arg;

    Dart_Port_DL port = args->port;
    char* methodName = args->methodName;
    char* operationID = args->operationID;
    double* errCode = args->errCode;
    char* message = args->message;
    char* callMethodName = args->callMethodName;

    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kString;
    cJSON *json = cJSON_CreateObject();

    cJSON_AddStringToObject(json, "method", methodName);
    if (operationID != NULL) {
        cJSON_AddStringToObject(json, "operationID", operationID);
    }
    if (callMethodName != NULL) {
        cJSON_AddStringToObject(json, "callMethodName", callMethodName);
    }
    if (errCode != NULL) {
        cJSON_AddNumberToObject(json, "errCode", *errCode);
    } 
    if (message != NULL) {
        cJSON_AddStringToObject(json, "data", message);
    }

    char *json_string = cJSON_PrintUnformatted(json);
    dart_object.value.as_string = json_string;

    const bool result = Dart_PostCObject_DL(port, &dart_object);
    if (!result)
    {
        printf("C   :  Posting message to port failed.\n");
    }

    cJSON_Delete(json);
    free(json_string);
    free(args);
    return 0;
}

void onMethodChannelFunc(Dart_Port_DL port, char* methodName, char* operationID, char* callMethodName, double* errCode, char* message)
{
    ThreadArgs* args = (ThreadArgs*)malloc(sizeof(ThreadArgs));

    args->port = port;
    args->methodName = methodName;
    args->errCode = errCode;
    args->message = message;
    args->operationID = operationID;
    args->callMethodName = callMethodName;

    HANDLE thread = CreateThread(NULL, 0, entry_point, (LPVOID)args, 0, NULL);
    if (thread == NULL)
    {
        printf("C   :  Failed to create thread.\n");
        free(args);
        return;
    }

    CloseHandle(thread);
}
#else
void *entry_point(void* arg)
{

    // 将void指针转换回ThreadArgs结构体指针
    ThreadArgs* args = (ThreadArgs*)arg;

    // 从结构体中获取参数
    Dart_Port_DL port = args->port;
    char* methodName = args->methodName;
    char* operationID = args->operationID;
    double* errCode = args->errCode;
    char* message = args->message;
    char* callMethodName = args->callMethodName;

    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kString;
    cJSON *json = cJSON_CreateObject();

    cJSON_AddStringToObject(json, "method", methodName);
    if (operationID != NULL) {
        cJSON_AddStringToObject(json, "operationID", operationID);
    }
    if (callMethodName != NULL) {
        cJSON_AddStringToObject(json, "callMethodName", callMethodName);
    } 
    if (errCode != NULL) {
        cJSON_AddNumberToObject(json, "errCode", *errCode);
    } 
    if (message != NULL) {
        cJSON_AddStringToObject(json, "data", message);
    }

    char *json_string = cJSON_PrintUnformatted(json);
    dart_object.value.as_string = json_string;

    const bool result = Dart_PostCObject_DL(port, &dart_object);
    if (!result)
    {
        printf("C   :  Posting message to port failed.\n");
    }

    cJSON_Delete(json);
    free(json_string);
    free(args);
    pthread_exit(NULL);
}

void onMethodChannelFunc(Dart_Port_DL port, char* methodName, char* operationID, char* callMethodName, double* errCode, char* message)
{   
    // 创建参数结构体并分配内存
    ThreadArgs* args = (ThreadArgs*)malloc(sizeof(ThreadArgs));

    // 设置参数值
    args->port = port;
    args->methodName = methodName;
    args->errCode = errCode;
    args->message = message;
    args->operationID = operationID;
    args->callMethodName = callMethodName;

    pthread_t thread;
    pthread_create(&thread, NULL, entry_point, (void *)args);
    pthread_detach(thread);
}
#endif


FFI_PLUGIN_EXPORT intptr_t ffi_Dart_InitializeApiDL(void *data)
{
    return Dart_InitializeApiDL(data);
}

// 在Dart中注册回调函数
FFI_PLUGIN_EXPORT void ffi_Dart_RegisterCallback(void *handle, Dart_Port_DL isolate_send_port) {
    dlfHandle = handle;
    g_listener.onMethodChannel = onMethodChannelFunc;
    #if defined(_WIN32) || defined(_WIN64)
        void (*RegisterCallback)(CGO_OpenIM_Listener*, Dart_Port_DL) = GetProcAddress(dlfHandle, "RegisterCallback");
    #else
        void (*RegisterCallback)(CGO_OpenIM_Listener*, Dart_Port_DL) = dlsym(dlfHandle, "RegisterCallback");
    #endif
    RegisterCallback(&g_listener, isolate_send_port);

    printMessage("注册dart回调成功");
}
// void Native_RegisterCallback() {
//     g_listener.onNativeMethodChannel = onNativeMethodChannelFunc;
//     void* handle = dlopen("libopenim_sdk_ffi.dylib", RTLD_LAZY);
//     void (*NativeRegisterCallback)(CGO_OpenIM_Listener*) = dlsym(handle, "NativeRegisterCallback");
//     NativeRegisterCallback(&g_listener);
//     printf("注册Native回调成功");
// }

