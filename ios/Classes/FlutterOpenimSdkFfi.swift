
import Foundation
import Flutter


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

@objc public class FlutterOpenimSdkFfi: NSObject {
    private var handle: UnsafeMutableRawPointer?
    
    private var channel: FlutterMethodChannel?
    
    var viewController :FlutterViewController?
    
    private var listeners: [Any] = []
    
    private var flutterEngine: FlutterEngine?
    
    @objc public func addListener(_ listener: Any) {
        listeners.append(listener)
    }
    
    @objc public func removeListener(_ listener: Any) {
        if let index = listeners.firstIndex(where: { ($0 as AnyObject) === listener as AnyObject }) {
            listeners.remove(at: index)
        }
    }
    
    func onMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = call.method as String
        
        switch method {
        case "onEventCall":
            let args = call.arguments as! [String: Any]
            let message = args["data"] as? String
            if let methodName = args["method"] as? String {
                for listener in listeners {
                    if listener is OnConnListener {
                        let onConnListener = listener as! OnConnListener
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
                            if let errCode = args["errCode"] as? Int {
                                onConnListener.onConnectFailed(code: Int64(errCode), error: message!)
                            }
                        default:
                            break
                        }
                    }
                    else if  listener is OnConversationListener {
                        let onConversationListener = listener as! OnConversationListener
                        switch methodName {
                            //                        case "OnConversationChanged":
                            //                            onConversationListener.onConversationChanged(list: <#T##[ConversationInfo]#>)(conversationInfos)
                            //                        case "OnNewConversation":
                            //                            onConversationListener.onNewConversation(conversationInfos)
                        case "OnSyncServerFailed":
                            onConversationListener.onSyncServerFailed()
                        case "OnSyncServerStart":
                            onConversationListener.onSyncServerStart()
                        case "OnSyncServerFinish":
                            onConversationListener.onSyncServerFinish()
                        case "OnTotalUnreadMessageCountChanged":
                            print(args["errCode"])
                            if let errCode = args["errCode"] as? Int {
                                onConversationListener.onTotalUnreadMessageCountChanged(count: errCode)
                            }
                        default:
                            break
                        }
                    }
                    //                    else if let onAdvanceMsgListener = listener as? OnAdvanceMsgListener {
                    //                        switch methodName {
                    //                        case "OnRecvNewMessage":
                    //                            if let newMessage = JsonUtil.toObj(message, to: Message.self) {
                    //                                onAdvanceMsgListener.onRecvNewMessage(msg: newMessage)
                    //                            }
                    //                        case "OnRecvC2CReadReceipt":
                    //                            if let readReceiptInfos = JsonUtil.toArray(message, ReadReceiptInfo.self) {
                    //                                onAdvanceMsgListener.onRecvC2CReadReceipt(readReceiptInfos)
                    //                            }
                    //                        case "OnRecvGroupMessageReadReceipt":
                    //                            if let readReceiptInfos = JsonUtil.toArray(message, ReadReceiptInfo.self) {
                    //                                onAdvanceMsgListener.onRecvGroupMessageReadReceipt(readReceiptInfos)
                    //                            }
                    //                        case "OnRecvMessageRevoked":
                    //                            onAdvanceMsgListener.onRecvMessageRevoked(message)
                    //                        case "OnRecvMessageRevokedV2":
                    //                            if let revokedInfo = JsonUtil.toObj(message, RevokedInfo.self) {
                    //                                onAdvanceMsgListener.onRecvMessageRevokedV2(revokedInfo)
                    //                            }
                    //                        case "OnRecvMessageExtensionsChanged":
                    //                            if let keyValuePairs = JsonUtil.toArray(message, KeyValue.self) {
                    //                                onAdvanceMsgListener.onRecvMessageExtensionsChanged(operationID: operationID, keyValuePairs: keyValuePairs)
                    //                            }
                    //                        case "OnRecvMessageExtensionsDeleted":
                    //                            if let keys = JsonUtil.toArray(message, String.self) {
                    //                                onAdvanceMsgListener.onRecvMessageExtensionsDeleted(operationID: operationID, keys: keys)
                    //                            }
                    //                        case "OnRecvMessageExtensionsAdded":
                    //                            if let keyValuePairs = JsonUtil.toArray(message, to: KeyValue.self) {
                    //                                onAdvanceMsgListener.onRecvMessageExtensionsAdded(operationID: operationID, keyValuePairs: keyValuePairs)
                    //                            }
                    //                        default:
                    //                            break
                    //                        }
                    //                    }
                }
            }
        default:
            break
        }
    }
    
    @objc public func initSDK(engine: FlutterEngine, appID: String, secret: String) {
        flutterEngine = engine
        channel = FlutterMethodChannel(name: "plugins.muka.site/flutter_openim_sdk_ffi", binaryMessenger: flutterEngine!.binaryMessenger)
        channel?.setMethodCallHandler(onMethodCall)
        
        var dictionary = [String: Any]()
        dictionary["appID"] = appID
        dictionary["secret"] = secret
        channel?.invokeMethod("InitSDK", arguments: dictionary)
        viewController = FlutterViewController(engine: flutterEngine!, nibName: nil, bundle: nil)
    }
    
    @objc public func getListPage() -> FlutterViewController {
        return viewController!
    }
    
    @objc public func getChatPage(userID: String, pageName: String) -> FlutterViewController {
        let route = String(format: "/chat?sourceID=%@&sessionType=1&showName=%@&native=1", userID, pageName)
        viewController!.pushRoute(route)
        return viewController!
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
    
    // 登出
    @objc public func logout() {
        channel?.invokeMethod("Logout", arguments: "")
    }
    
    // 设置语言
    @objc public func setLocale(language: String) {
        channel?.invokeMethod("SetLocale", arguments: language)
    }
    
    @objc public func getAppUserID(userID: String, callback: @escaping FlutterResult) {
        var dictionary = [String: Any]()
        dictionary["userID"] = userID
        
        channel?.invokeMethod("GetAppUserId",arguments: dictionary, result: callback)
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

