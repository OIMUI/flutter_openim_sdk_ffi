package io.openim.flutter_openim_sdk_ffi


import android.content.Context
import android.util.Log
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
import kotlinx.coroutines.*


class OpenIMSDKFFi {
    private val deferredInfoMap: MutableMap<String, CompletableDeferred<Any>?> = mutableMapOf()
    private val listeners: MutableList<Any> = mutableListOf()

    companion object {
        init {
            System.loadLibrary("flutter_openim_sdk_ffi")
        }
    }

    fun addListener(listener: Any) {
        listeners.add(listener)
    }

    fun removeListener(listener: Any) {
        listeners.remove(listener)
    }


    // Go回调函数
    private fun onMethodChannel(
        methodName: String,
        operationID: String?,
        callMethodName: String?,
        errCode: Double?,
        message: String?
    ) {
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

            "OnInitSDK" -> {
                for (listener in listeners) {
                    (listener as OnConnListener).onInitSDK()
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

    private external fun Login(operationID: String, userID: String, token: String)

    private external fun GetSelfUserInfo(operationID: String)


    external fun registerCallback()

    private external fun GetTotalUnreadMsgCount(operationID: String)

    private external fun InitSDK(operationID: String, params: String)

    fun initSDK(context: Context,appID: String, secret: String) {
        val operationID = System.currentTimeMillis().toString()
        val dataDir = context.filesDir.absolutePath
        val hashMap = hashMapOf<String,Any>()
        hashMap["platform"] = 2
        hashMap["api_addr"] = "http://121.40.210.13:10002"
        hashMap["ws_addr"] = "ws://121.40.210.13:10001"
        hashMap["data_dir"] = dataDir
        hashMap["log_level"] = 6
        hashMap["object_storage"] = "oss"
        hashMap["encryption_key"] = ""
        hashMap["is_need_encryption"] = false
        hashMap["is_compression"] = false
        hashMap["is_external_extensions"] = false
        hashMap["app_id"] = appID
        hashMap["secret"] = secret
        // hashMap转字符串
        val params = JsonUtil.toString(hashMap)
        InitSDK(operationID, params)
    }

    suspend fun login(userID: String, token: String): UserInfo {
        val operationID = System.currentTimeMillis().toString()
        val deferred = CompletableDeferred<Any>()
        deferredInfoMap[operationID] = deferred
        delay(1000)
        Login(operationID, userID, token)
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
}