
// 修改函数声明和定义
void nativeRegisterCallback(void (*onNativeMethodChannelFunc)(char*, char*, char*, double*, char*)) {
    registerNativeCallback = true;
    g_listener.onNativeMethodChannel = onNativeMethodChannelFunc;
}

// void login(char* operationID, char* userID, char* token) {
//     bool (*Login)(const char*, const char*, const char*) = dlsym(dlfHandle, "Login");
//     printf("operationID: %s\n", operationID);
//     printf("userID: %s\n", userID);
//     printf("token: %s\n", token);
//     Login(operationID, userID, token);
// }

void getSelfUserInfo(char* operationID) {
    bool (*GetSelfUserInfo)(const char*) = dlsym(dlfHandle, "GetSelfUserInfo");
    GetSelfUserInfo(operationID);
}
