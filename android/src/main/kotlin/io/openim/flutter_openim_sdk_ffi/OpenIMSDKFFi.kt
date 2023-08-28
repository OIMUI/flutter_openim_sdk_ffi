package io.openim.flutter_openim_sdk_ffi


import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
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


class OpenIMSDKFFi : FlutterPlugin{
    private val listeners: MutableList<Any> = mutableListOf()

    private var channel: MethodChannel? = null

    fun addListener(listener: Any) {
        listeners.add(listener)
    }

    fun removeListener(listener: Any) {
        listeners.remove(listener)
    }

    fun initSDK(appID: String, secret: String) {
        val hashMap = hashMapOf<String,Any>()
        hashMap["appID"] = appID
        hashMap["secret"] = secret
        channel?.invokeMethod("initSDK",  hashMap)
    }
    fun login(userID: String) {
        val hashMap = hashMapOf<String,Any?>()
        hashMap["userID"] = userID
        channel?.invokeMethod("Login",  hashMap)
    }
    fun login(userID: String,nickname: String) {
        val hashMap = hashMapOf<String,Any?>()
        hashMap["userID"] = userID
        hashMap["nickname"] = nickname
        channel?.invokeMethod("Login",  hashMap)
    }
    fun login(userID: String,nickname: String, faceURL:String) {
        val hashMap = hashMapOf<String,Any?>()
        hashMap["userID"] = userID
        hashMap["nickname"] = nickname
        hashMap["faceURL"] = faceURL
        channel?.invokeMethod("Login",  hashMap)
    }
    fun login(userID: String, nickname: String, faceURL:String, phoneNumber: String) {
        val hashMap = hashMapOf<String,Any?>()
        hashMap["userID"] = userID
        hashMap["nickname"] = nickname
        hashMap["faceURL"] = faceURL
        hashMap["phoneNumber"] = phoneNumber
        channel?.invokeMethod("Login",  hashMap)
    }

//    suspend fun getTotalUnreadMsgCount(operationID: String): Int {
//        val deferred = CompletableDeferred<Any>()
//        deferredInfoMap[operationID] = deferred
//        GetTotalUnreadMsgCount(operationID)
//        return deferred.await() as Int
//    }
//
//    suspend fun getSelfUserInfo(operationID: String): UserInfo {
//        val deferred = CompletableDeferred<Any>()
//        deferredInfoMap[operationID] = deferred
//        GetSelfUserInfo(operationID)
//        return deferred.await() as UserInfo
//    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "plugins.muka.site/flutter_openim_sdk_ffi")
//        channel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = null
    }


}