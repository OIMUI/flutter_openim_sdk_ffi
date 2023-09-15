package io.openim.flutter_openim_sdk_ffi


import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.systemchannels.NavigationChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.openim.flutter_openim_sdk_ffi.listener.OnAdvanceMsgListener
import io.openim.flutter_openim_sdk_ffi.listener.OnConnListener
import io.openim.flutter_openim_sdk_ffi.listener.OnConversationListener
import io.openim.flutter_openim_sdk_ffi.models.ConversationInfo
import io.openim.flutter_openim_sdk_ffi.models.KeyValue
import io.openim.flutter_openim_sdk_ffi.models.Message
import io.openim.flutter_openim_sdk_ffi.models.ReadReceiptInfo
import io.openim.flutter_openim_sdk_ffi.models.RevokedInfo


class OpenIMSDKFFi : FlutterPlugin, MethodChannel.MethodCallHandler {
    private val listeners: MutableList<Any> = mutableListOf()

    private var channel: MethodChannel? = null

    private  lateinit var navigationChannel: NavigationChannel

    fun addListener(listener: Any) {
        listeners.add(listener)
    }

    fun removeListener(listener: Any) {
        listeners.remove(listener)
    }

    fun initSDK(context: Context, appID: String, secret: String) {
        // 创建Flutter引擎

        // 创建Flutter引擎
        val flutterEngine = FlutterEngine(context)
        flutterEngine.plugins.add(this)
        navigationChannel = flutterEngine.navigationChannel

        flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        val flutterEngineCache = FlutterEngineCache.getInstance()
        flutterEngineCache.put("im", flutterEngine)

        val hashMap = hashMapOf<String, Any>()
        hashMap["appID"] = appID
        hashMap["secret"] = secret
        channel?.invokeMethod("initSDK", hashMap)
    }

    // 获取列表页面
    fun getListPage(context: Context) : Intent {
        navigationChannel.setInitialRoute("/home")
        return FlutterActivity
            .withCachedEngine("im")
            .build(context)
    }

    /// 获取聊天页面
    fun getChatPage(context: Context, userID: String, pageName:String) : Intent {
        navigationChannel.pushRoute("/chat?sourceID=${userID}&sessionType=1&showName=${pageName}&native=1")
        return FlutterActivity
            .withCachedEngine("im")
            .build(context)
    }

    interface OnResult {

        open fun success(result: Any?)

        open fun error(errorCode: String, errorMessage: String?, errorDetails: Any?)
    }

    fun logout() {
        channel?.invokeMethod("logout","")
    }
    // zh_CN
    // en_US
    fun setLocale(language: String) {
        channel?.invokeMethod("setLocale",language)
    }

    fun getAppUserID(userID: String, callback: OnResult) {
        val hashMap = hashMapOf<String, Any>()
        hashMap["userID"] = userID
        channel?.invokeMethod("GetAppUserId", hashMap, object : MethodChannel.Result {

            override fun success(result: Any?) {
                callback.success(result)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                callback.error(errorCode, errorMessage, errorDetails)
            }

            override fun notImplemented() {
            }

        })
    }

    fun login(userID: String, callback: OnResult) {
        val hashMap = hashMapOf<String, Any?>()
        hashMap["userID"] = userID
        channel?.invokeMethod("Login", hashMap, object : MethodChannel.Result {

            override fun success(result: Any?) {
                callback.success(result)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                callback.error(errorCode, errorMessage, errorDetails)
            }

            override fun notImplemented() {
            }

        })
    }

    fun login(userID: String, nickname: String, callback: OnResult) {
        val hashMap = hashMapOf<String, Any?>()
        hashMap["userID"] = userID
        hashMap["nickname"] = nickname
        channel?.invokeMethod("Login", hashMap, object : MethodChannel.Result {

            override fun success(result: Any?) {
                callback.success(result)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                callback.error(errorCode, errorMessage, errorDetails)
            }

            override fun notImplemented() {
            }

        })
    }

    fun login(userID: String, nickname: String, faceURL: String, callback: OnResult) {
        val hashMap = hashMapOf<String, Any?>()
        hashMap["userID"] = userID
        hashMap["nickname"] = nickname
        hashMap["faceURL"] = faceURL
        channel?.invokeMethod("Login", hashMap, object : MethodChannel.Result {

            override fun success(result: Any?) {
                callback.success(result)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                callback.error(errorCode, errorMessage, errorDetails)
            }

            override fun notImplemented() {
            }

        })
    }

    fun login(userID: String, nickname: String, faceURL: String, phoneNumber: String, callback: OnResult) {
        val hashMap = hashMapOf<String, Any?>()
        hashMap["userID"] = userID
        hashMap["nickname"] = nickname
        hashMap["faceURL"] = faceURL
        hashMap["phoneNumber"] = phoneNumber
        channel?.invokeMethod("Login", hashMap, object : MethodChannel.Result {

            override fun success(result: Any?) {
                callback.success(result)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                callback.error(errorCode, errorMessage, errorDetails)
            }

            override fun notImplemented() {
            }

        })
    }


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "plugins.muka.site/flutter_openim_sdk_ffi")
        channel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "onEventCall" -> {
                var message = (call.argument("data") as String?)
                var methodName = (call.argument("method") as String?)!!
                var errCode = (call.argument("errCode") as Int?)
                var operationID = (call.argument("operationID") as String?) ?: ""
                when (methodName) {
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
                            (listener as OnConnListener).onConnectFailed(errCode!!, message!!)
                        }
                    }

                    "OnConversationChanged" -> {
                        for (listener in listeners) {
                            (listener as OnConversationListener).onConversationChanged(
                                JsonUtil.toArray(
                                    message!!,
                                    ConversationInfo::class.java
                                )
                            )
                        }
                    }

                    "OnNewConversation" -> {
                        for (listener in listeners) {
                            (listener as OnConversationListener).onNewConversation(
                                JsonUtil.toArray(
                                    message!!,
                                    ConversationInfo::class.java
                                )
                            )
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
                            (listener as OnConversationListener).onTotalUnreadMessageCountChanged(
                                errCode!!
                            )
                        }
                    }

                    "OnRecvNewMessage" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvNewMessage(
                                JsonUtil.toObj(
                                    message!!,
                                    Message::class.java
                                )
                            )
                        }
                    }

                    "OnRecvC2CReadReceipt" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvC2CReadReceipt(
                                JsonUtil.toArray(
                                    message!!,
                                    ReadReceiptInfo::class.java
                                )
                            )
                        }
                    }

                    "OnRecvGroupMessageReadReceipt" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvGroupMessageReadReceipt(
                                JsonUtil.toArray(
                                    message!!,
                                    ReadReceiptInfo::class.java
                                )
                            )
                        }
                    }

                    "OnRecvMessageRevoked" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvMessageRevoked(message!!)
                        }
                    }

                    "OnRecvMessageRevokedV2" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvMessageRevokedV2(
                                JsonUtil.toObj(message!!, RevokedInfo::class.java)
                            )
                        }
                    }

                    "OnRecvMessageExtensionsChanged" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvMessageExtensionsChanged(
                                operationID,
                                JsonUtil.toArray(message!!, KeyValue::class.java)
                            )
                        }
                    }

                    "OnRecvMessageExtensionsDeleted" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvMessageExtensionsDeleted(
                                operationID,
                                JsonUtil.toArray(message!!, String::class.java)
                            )
                        }
                    }

                    "OnRecvMessageExtensionsAdded" -> {
                        for (listener in listeners) {
                            (listener as OnAdvanceMsgListener).onRecvMessageExtensionsAdded(
                                operationID, JsonUtil.toArray(
                                    message!!,
                                    KeyValue::class.java
                                )
                            )
                        }
                    }
                }
            }
        }
    }


}