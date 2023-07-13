package io.openim.flutter_openim_sdk_ffi

import android.content.Context
import android.util.Log
import androidx.collection.ArrayMap
import io.openim.flutter_openim_sdk_ffi.listener.OnAdvanceMsgListener
import io.openim.flutter_openim_sdk_ffi.listener.OnConnListener
import io.openim.flutter_openim_sdk_ffi.listener.OnConversationListener
import io.openim.flutter_openim_sdk_ffi.models.ConversationInfo
import io.openim.flutter_openim_sdk_ffi.models.KeyValue
import io.openim.flutter_openim_sdk_ffi.models.Message
import io.openim.flutter_openim_sdk_ffi.models.ReadReceiptInfo
import io.openim.flutter_openim_sdk_ffi.models.RevokedInfo
import io.openim.flutter_openim_sdk_ffi.models.UserInfo
import kotlinx.coroutines.CompletableDeferred
import java.io.File

class OpenIMSDKFFi {

    private val deferredInfoMap: MutableMap<String, CompletableDeferred<Any>?> = mutableMapOf()

    companion object {
        // 加载共享库
        init {
            System.loadLibrary("flutter_openim_sdk_ffi")
        }

        private val listeners: MutableList<Any> = mutableListOf()

        fun addListener(listener: Any) {
            listeners.add(listener)
        }

        fun removeListener(listener: Any) {
            listeners.remove(listener)
        }
    }
    external fun init()
    // 声明本地方法，用于注册Go回调函数
    external fun registerCallback()

    // 初始化SDK
    private external fun InitSDK(operationID: String, config: String): Boolean

    private external fun Login(operationID: String, userID: String, token: String)

    private external fun GetSelfUserInfo(operationID: String)

    private external fun GetTotalUnreadMsgCount(operationID: String)

    fun initSDK(context: Context): Boolean {
        val map: MutableMap<String, Any> = ArrayMap()
        map["platform"] = 2
        map["api_addr"] = "http://121.40.210.13:10002"
        map["ws_addr"] = "ws://121.40.210.13:10001"
        map["data_dir"] = context.filesDir.path
        map["log_level"] = 6
        map["object_storage"] = "oss"
        map["is_need_encryption"] = false
        map["is_compression"] = false
        map["encryption_key"] = ""
        map["is_external_extensions"] = false
        return InitSDK(System.currentTimeMillis().toString(), JsonUtil.toString(map))
    }

    suspend fun login(operationID: String, uid: String, token: String): UserInfo {
        val deferred = CompletableDeferred<Any>()
        deferredInfoMap[operationID] = deferred
        Login(operationID, uid, token)
        deferred.await()
        return getSelfUserInfo(System.currentTimeMillis().toString())
    }

    suspend fun getTotalUnreadMsgCount(operationID: String): Int {
        val deferred = CompletableDeferred<Any>()
        deferredInfoMap[operationID] = deferred
        GetTotalUnreadMsgCount(operationID)
        return deferred.await() as Int
    }

    suspend fun getSelfUserInfo(operationID: String): UserInfo {
        val deferred = CompletableDeferred<Any>()
        deferredInfoMap[operationID] = deferred
        GetSelfUserInfo(operationID)
        return deferred.await() as UserInfo
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
                        deferredInfoMap[operationID]?.complete(JsonUtil.toObj(message!!, UserInfo::class.java))
                        deferredInfoMap.remove(operationID)

                    }
                    "GetTotalUnreadMsgCount" -> {
                        deferredInfoMap[operationID]?.complete(message!!.toInt())
                        deferredInfoMap.remove(operationID)
                    }

                    "Login" -> {
                        deferredInfoMap[operationID]?.complete(Unit)
                        deferredInfoMap.remove(operationID)
                    }
                }
            }

            "OnError" -> {
                deferredInfoMap[operationID]?.completeExceptionally(CustomException(errCode!!.toInt(), message!!))
                deferredInfoMap.remove(operationID)
            }

            "OnKickedOffline" -> {
                for (listener in listeners) {
                    (listener as OnConnListener).onKickedOffline()
                }
            }

            "OnConnecting" -> {
                for (listener in listeners) {
                    (listener as OnConnListener).onConnecting()
                }
            }

            "OnUserTokenExpired" -> {
                for (listener in listeners) {
                    (listener as OnConnListener).onUserTokenExpired()
                }
            }

            "OnConnectSuccess" -> {
                for (listener in listeners) {
                    (listener as OnConnListener).onConnectSuccess()
                }
            }

            "OnConnectFailed" -> {
                for (listener in listeners) {
                    (listener as OnConnListener).onConnectFailed(errCode!!.toLong(), message!!)
                }
            }

            "OnConversationChanged" -> {
                for (listener in listeners) {
                    (listener as OnConversationListener).onConversationChanged(JsonUtil.toArray(message!!, ConversationInfo::class.java))
                }
            }

            "OnNewConversation" -> {
                for (listener in listeners) {
                    (listener as OnConversationListener).onNewConversation(JsonUtil.toArray(message!!, ConversationInfo::class.java))
                }
            }
            "OnSyncServerFailed" -> {
                for (listener in listeners) {
                    (listener as OnConversationListener).onSyncServerFailed()
                }
            }
            "OnSyncServerStart" -> {
                for (listener in listeners) {
                    (listener as OnConversationListener).onSyncServerStart()
                }
            }
            "OnSyncServerFinish" -> {
                for (listener in listeners) {
                    (listener as OnConversationListener).onSyncServerFinish()
                }
            }
            "OnTotalUnreadMessageCountChanged" -> {
                for (listener in listeners) {
                    (listener as OnConversationListener).onTotalUnreadMessageCountChanged(errCode!!.toInt())
                }
            }

            "OnRecvNewMessage" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvNewMessage(JsonUtil.toObj(message!!, Message::class.java ))
                }
            }

            "OnRecvC2CReadReceipt" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvC2CReadReceipt(JsonUtil.toArray(message!!,
                        ReadReceiptInfo::class.java ))
                }
            }

            "OnRecvGroupMessageReadReceipt" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvGroupMessageReadReceipt(JsonUtil.toArray(message!!,
                        ReadReceiptInfo::class.java ))
                }
            }
            "OnRecvMessageRevoked" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvMessageRevoked(message!!)
                }
            }
            "OnRecvMessageRevokedV2" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvMessageRevokedV2(JsonUtil.toObj(message!!,RevokedInfo::class.java))
                }
            }

            "OnRecvMessageExtensionsChanged" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvMessageExtensionsChanged(operationID!!, JsonUtil.toArray(message!!,KeyValue::class.java))
                }
            }

            "OnRecvMessageExtensionsDeleted" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvMessageExtensionsDeleted(operationID!!, JsonUtil.toArray(message!!,String::class.java))
                }
            }

            "OnRecvMessageExtensionsAdded" -> {
                for (listener in listeners) {
                    (listener as OnAdvanceMsgListener).onRecvMessageExtensionsAdded(operationID!!, JsonUtil.toArray(message!!,
                        KeyValue::class.java ))
                }
            }

        }

    }
}

