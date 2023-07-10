package io.openim.flutter_openim_sdk_ffi;

public class OpenIMSDKFFi {
    // 加载共享库
    static {
        System.loadLibrary("flutter_openim_sdk_ffi");
    }

    // 声明本地方法，用于注册Go回调函数
    public native void registerCallback();

    // 初始化SDK
    static native void InitSDK();

    // Go回调函数
    public void onMethodChannel(int port, String methodName, String operationID, String callMethodName, double errCode, String message) {
        // 在此处实现回调函数的逻辑
        System.out.println("Received callback: methodName=" + methodName + ", operationID=" + operationID +
                ", callMethodName=" + callMethodName + ", errCode=" + errCode + ", message=" + message);
    }

}
