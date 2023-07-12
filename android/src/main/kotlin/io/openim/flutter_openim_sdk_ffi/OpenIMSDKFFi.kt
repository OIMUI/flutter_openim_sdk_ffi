package io.openim.flutter_openim_sdk_ffi

import android.content.Context
import android.util.Log
import androidx.collection.ArrayMap
import io.openim.flutter_openim_sdk_ffi.models.UserInfo
import kotlinx.coroutines.CompletableDeferred

class OpenIMSDKFFi {
    private val deferredUserInfoMap: MutableMap<String, CompletableDeferred<UserInfo>?> = mutableMapOf()

    private val deferredVoidMap: MutableMap<String, CompletableDeferred<Unit>?> = mutableMapOf()

    companion object {
        // 加载共享库
        init {
            System.loadLibrary("flutter_openim_sdk_ffi")
        }
    }

    // 声明本地方法，用于注册Go回调函数
    external fun registerCallback()

    // 初始化SDK
    private external fun InitSDK(operationID: String, config: String): Boolean

    private external fun Login(operationID: String, userID: String, token: String)

    private external fun GetSelfUserInfo(operationID: String)

    fun initSDK(context: Context): Boolean {
        val map: MutableMap<String, Any> = ArrayMap()
        map["platform"] = 2
        map["api_addr"] = "http://47.110.64.122:10002"
        map["ws_addr"] = "ws://47.110.64.122:10001"
        map["data_dir"] = context.filesDir.path
        map["log_level"] = 6
        map["object_storage"] = "oss"
        map["is_need_encryption"] = false
        map["is_compression"] = false
        map["is_external_extensions"] = false
        return InitSDK(System.currentTimeMillis().toString(), JsonUtil.toString(map))
    }

    suspend fun login(operationID: String, uid: String, token: String): UserInfo {
        val deferred = CompletableDeferred<Unit>()
        deferredVoidMap[operationID] = deferred
        Login(operationID, uid, token)
        deferred.await()
        return getSelfUserInfo(System.currentTimeMillis().toString())
    }

    suspend fun getSelfUserInfo(operationID: String): UserInfo {
        val deferred = CompletableDeferred<UserInfo>()
        deferredUserInfoMap[operationID] = deferred
        GetSelfUserInfo(operationID)
        return deferred.await()
    }

    // Go回调函数
    fun onMethodChannel(
        methodName: String,
        operationID: String?,
        callMethodName: String?,
        errCode: Double?,
        message: String?
    ) {
        Log.d("===========", methodName)
        operationID?.let {
            Log.d("===========", operationID)
        }
        callMethodName?.let {
            Log.d("===========", callMethodName)
        }
        Log.d("===========", errCode.toString())
        message?.let {
            Log.d("===========", message)
        }
        when (methodName) {
            "OnSuccess" -> {
                when (callMethodName) {
                    "GetSelfUserInfo" -> {
                        JsonUtil.toObj(message, UserInfo::class.java)
                            ?.let {
                                deferredUserInfoMap[operationID]?.complete(it)
                            };
                        deferredUserInfoMap.remove(operationID)

                    }

                    "Login" -> {
                        deferredVoidMap[operationID]?.complete(Unit)
                        deferredVoidMap.remove(operationID)
                    }
                }
            }
        }

    }
}

