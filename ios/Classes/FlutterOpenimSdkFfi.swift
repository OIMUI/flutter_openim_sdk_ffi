
import Foundation
import Flutter


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

@objc public class FlutterOpenimSdkFfi: NSObject {
    private var handle: UnsafeMutableRawPointer?
    
    private var channel: FlutterMethodChannel?
    
    private var listeners: [Any] = []
    
    @objc public func addListener(_ listener: Any) {
        listeners.append(listener)
    }
    
    @objc public func removeListener(_ listener: Any) {
        if let index = listeners.firstIndex(where: { ($0 as AnyObject) === listener as AnyObject }) {
            listeners.remove(at: index)
        }
    }
    
    @objc public func register(binaryMessenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: "plugins.muka.site/flutter_openim_sdk_ffi", binaryMessenger: binaryMessenger)
        channel?.setMethodCallHandler(onMethodCall)
    }
    
    func onMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let methodName = call.method as? String else {
            return
        }
        
        switch methodName {
        case "onEventCall":
            if let message = call.arguments["data"] as? String,
               let errCode = call.arguments["errCode"] as? Int {
                let operationID = call.arguments["operationID"] as? String ?? ""
                
                for listener in listeners {
                    if let onConnListener = listener as? OnConnListener {
                        switch methodName {
                        case "OnKickedOffline":
                            onConnListener.onKickedOffline()
                        case "OnConnecting":
                            onConnListener.onConnecting()
                        case "OnUserTokenExpired":
                            onConnListener.onUserTokenExpired()
                        case "OnConnectSuccess":
                            onConnListener.onConnectSuccess()
                        case "OnConnectFailed":
                            onConnListener.onConnectFailed(errCode: errCode, message: message)
                        default:
                            break
                        }
                    } else if let onConversationListener = listener as? OnConversationListener,
                              let conversationInfos = JsonUtil.toArray(message, ConversationInfo.self) {
                        switch methodName {
                        case "OnConversationChanged":
                            onConversationListener.onConversationChanged(conversationInfos)
                        case "OnNewConversation":
                            onConversationListener.onNewConversation(conversationInfos)
                        case "OnSyncServerFailed":
                            onConversationListener.onSyncServerFailed()
                        case "OnSyncServerStart":
                            onConversationListener.onSyncServerStart()
                        case "OnSyncServerFinish":
                            onConversationListener.onSyncServerFinish()
                        case "OnTotalUnreadMessageCountChanged":
                            onConversationListener.onTotalUnreadMessageCountChanged(errCode)
                        default:
                            break
                        }
                    } else if let onAdvanceMsgListener = listener as? OnAdvanceMsgListener {
                        switch methodName {
                        case "OnRecvNewMessage":
                            if let newMessage = JsonUtil.toObj(message, Message.self) {
                                onAdvanceMsgListener.onRecvNewMessage(newMessage)
                            }
                        case "OnRecvC2CReadReceipt":
                            if let readReceiptInfos = JsonUtil.toArray(message, ReadReceiptInfo.self) {
                                onAdvanceMsgListener.onRecvC2CReadReceipt(readReceiptInfos)
                            }
                        case "OnRecvGroupMessageReadReceipt":
                            if let readReceiptInfos = JsonUtil.toArray(message, ReadReceiptInfo.self) {
                                onAdvanceMsgListener.onRecvGroupMessageReadReceipt(readReceiptInfos)
                            }
                        case "OnRecvMessageRevoked":
                            onAdvanceMsgListener.onRecvMessageRevoked(message)
                        case "OnRecvMessageRevokedV2":
                            if let revokedInfo = JsonUtil.toObj(message, RevokedInfo.self) {
                                onAdvanceMsgListener.onRecvMessageRevokedV2(revokedInfo)
                            }
                        case "OnRecvMessageExtensionsChanged":
                            if let keyValuePairs = JsonUtil.toArray(message, KeyValue.self) {
                                onAdvanceMsgListener.onRecvMessageExtensionsChanged(operationID: operationID, keyValuePairs: keyValuePairs)
                            }
                        case "OnRecvMessageExtensionsDeleted":
                            if let keys = JsonUtil.toArray(message, String.self) {
                                onAdvanceMsgListener.onRecvMessageExtensionsDeleted(operationID: operationID, keys: keys)
                            }
                        case "OnRecvMessageExtensionsAdded":
                            if let keyValuePairs = JsonUtil.toArray(message, KeyValue.self) {
                                onAdvanceMsgListener.onRecvMessageExtensionsAdded(operationID: operationID, keyValuePairs: keyValuePairs)
                            }
                        default:
                            break
                        }
                    }
                }
            }
        default:
            break
        }
    }
    
    @objc public func initSDK(appID: String, secret: String) {
        var dictionary = [String: Any]()
        dictionary["appID"] = appID
        dictionary["secret"] = secret
        channel?.invokeMethod("initSDK", arguments: dictionary)
    }
    // 登陆
    @objc public func login(userID: String, nickname: String?, faceURL:String?, phoneNumber: String?) {
        var dictionary = [String: Any]()
        dictionary["userID"] = userID
        dictionary["nickname"] = nickname
        dictionary["faceURL"] = faceURL
        dictionary["phoneNumber"] = phoneNumber
        channel?.invokeMethod("Login", arguments: dictionary)
    }
}

class CustomException: Error {
    var errorCode: Int
    var message: String
    
    init(errCode: Int, message: String) {
        self.errorCode = errCode
        self.message = message
    }
}

class Deferred<T> {
    private let semaphore = DispatchSemaphore(value: 0)
    private var result: T?
    private var error: Error?
    
    func complete(result: T) {
        self.result = result
        semaphore.signal()
    }
    
    func complete(with error: Error) {
        self.error = error
        semaphore.signal()
    }
    
    func await() throws -> T {
        semaphore.wait()
        if let error = error {
            throw error
        }
        return result!
    }
}
