


// 修改函数声明和定义
void nativeRegisterCallback(void (*onNativeMethodChannelFunc)(char*, char*, char*, double*, char*)) {
    registerNativeCallback = true;
    g_listener.onNativeMethodChannel = onNativeMethodChannelFunc;
}