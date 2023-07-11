package io.openim.flutter_openim_sdk_ffi.listener;

public class OnFfiListener {
    // Go回调函数
    public void onMethodChannel(String methodName, String operationID, String callMethodName, double errCode, String message) {
        // 在此处实现回调函数的逻辑
        System.out.println("Received callback: methodName=" + methodName + ", operationID=" + operationID +
                ", callMethodName=" + callMethodName + ", errCode=" + errCode + ", message=" + message);
    }
}
