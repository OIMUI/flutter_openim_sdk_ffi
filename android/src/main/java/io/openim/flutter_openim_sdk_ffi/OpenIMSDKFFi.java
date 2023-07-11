package io.openim.flutter_openim_sdk_ffi;

import static androidx.core.content.ContextCompat.getExternalFilesDirs;

import static io.flutter.util.PathUtils.getFilesDir;

import androidx.collection.ArrayMap;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

import java.io.File;

import java.util.Map;


public class OpenIMSDKFFi {
    // 加载共享库
    static {
        System.loadLibrary("flutter_openim_sdk_ffi");
    }
    // 声明本地方法，用于注册Go回调函数
    public native void registerCallback();

    // 初始化SDK
    private native boolean InitSDK(String operationID, String config);

    public native void login(String operationID, String userID, String token);

    public boolean initSDK(Context context) {
        Log.d("========", context.getFilesDir().getPath());
        Map<String, Object> map = new ArrayMap<>();
        map.put("platform", 2);
        map.put("api_addr", "http://47.110.64.122:10002");
        map.put("ws_addr", "ws://47.110.64.122:10001");
        map.put("data_dir",  context.getFilesDir().getPath());
        map.put("log_level", 6);
        map.put("object_storage", "oss");
        map.put("encryption_key", null);
        map.put("is_need_encryption", false);
        map.put("is_compression", false);
        map.put("is_external_extensions", false);
        Log.d("========", String.valueOf(System.currentTimeMillis()));
        return InitSDK(String.valueOf(System.currentTimeMillis()),JsonUtil.toString(map));
    }

    // Go回调函数
    public void onMethodChannel(String methodName, String operationID, String callMethodName, double errCode, String message) {
       Log.d("===========",methodName);
        Log.d("===========",operationID);
        Log.d("===========",callMethodName);
        Log.d("===========", String.valueOf(errCode));
        Log.d("===========", message);
    }

}
