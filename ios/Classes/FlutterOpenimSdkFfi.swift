
import Foundation
import Flutter


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

@objc public class FlutterOpenimSdkFfi: NSObject {
    private var handle: UnsafeMutableRawPointer?
    
    private var channel: FlutterMethodChannel?
    
    private var deferredInfoMap: [String: Deferred<Any?>?] = [:]
    
    private let backgroundQueue = DispatchQueue(label: "com.muka.backgroundQueue", qos: .background)
    
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
        switch call.method {
            
        default: break
            
        }
    }
    
    // 这个方法将被C函数调用，用于通知Swift
    private func handleNativeMethodCallback(methodName: UnsafePointer<Int8>, operationID: UnsafePointer<Int8>?, callMethodName:
                                            UnsafePointer<Int8>?, errCode: UnsafePointer<Double>?, message: UnsafePointer<Int8>?) {
        backgroundQueue.async {
            let methodNameString = String(cString: methodName)
            var operationIDString = ""
            var callMethodNameString = ""
            var messageString = ""
            
            if operationID != nil {
                operationIDString = String(cString: operationID!)
            }
            if callMethodName != nil {
                callMethodNameString = String(cString: callMethodName!)
            }
            if message != nil {
                messageString = String(cString: message!)
            }
            switch methodNameString {
            case "OnSuccess":
                switch callMethodNameString {
                case "GetSelfUserInfo":
                    let userInfo = JsonUtil.toObj(messageString, to: UserInfo.self)
                    self.deferredInfoMap[operationIDString]??.complete(result: userInfo)
                    self.deferredInfoMap.removeValue(forKey: operationIDString)
                case "GetTotalUnreadMsgCount":
                    if let unreadCount = Int(messageString) {
                        self.deferredInfoMap[operationIDString]??.complete(result: unreadCount)
                        self.deferredInfoMap.removeValue(forKey: operationIDString)
                    }
                case "Login":
                    self.self.deferredInfoMap[operationIDString]??.complete(result: nil)
                    self.deferredInfoMap.removeValue(forKey: operationIDString)
                default:
                    break
                }
            case "OnError":
                let customException = CustomException(errCode: Int(bitPattern: errCode) , message: messageString)
                self.deferredInfoMap[operationIDString]??.complete(with: customException)
                self.deferredInfoMap.removeValue(forKey: operationIDString)
            case "OnConnectFailed":
                for listener in self.listeners {
                    if let onConnListener = listener as? OnConnListener {
                        onConnListener.onConnectFailed(code:Int64(Int(bitPattern: errCode)),error:messageString)
                    }
                }
            case "OnKickedOffline":
                for listener in self.listeners {
                    if let onConnListener = listener as? OnConnListener {
                        onConnListener.onKickedOffline()
                    }
                }
            case "OnConnectSuccess":
                for listener in self.listeners {
                    if let onConnListener = listener as? OnConnListener {
                        onConnListener.onConnectSuccess()
                    }
                }
            case "OnConnecting":
                for listener in self.listeners {
                    if let onConnListener = listener as? OnConnListener {
                        onConnListener.onConnecting()
                    }
                }
            case "OnUserTokenExpired":
                for listener in self.listeners {
                    if let onConnListener = listener as? OnConnListener {
                        onConnListener.onUserTokenExpired()
                    }
                }
            default:
                break
            }
        }
    }
    
    
    func convertToCCharArray(_ inputString: String) -> UnsafeMutablePointer<UInt8>? {
        // 将字符串转换为UTF-8编码的数据
        guard let data = inputString.data(using: .utf8) else {
            return nil
        }
        
        // 分配内存来容纳字符数组
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count + 1)
        
        // 将数据复制到字符数组中（包括结尾的null字符）
        data.copyBytes(to: buffer, count: data.count)
        buffer[data.count] = 0 // 添加结尾的null字符
        
        return buffer
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
    //    // 获取用户信息
    //    @objc public func getSelfUserInfo() throws -> UserInfo {
    ////        let operationID = getCurrentTimeMillisString()
    ////        let operationIDString = operationID.cString(using: .utf8)!
    ////        let deferred = Deferred<Any?>()
    ////        deferredInfoMap[operationID] = deferred
    ////
    ////        typealias FunctionType = @convention(c) (UnsafePointer<CChar>) -> Void
    ////        let functionPointer = dlsym(dylibHandle, "getSelfUserInfo")
    ////        let getSelfUserInfoCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
    ////        getSelfUserInfoCallback(operationIDString)
    ////
    ////        return try deferred.await() as! UserInfo
    //    }
    
    private func getCurrentTimeMillisString() -> String {
        let currentTime = Date()
        let timeInterval = currentTime.timeIntervalSince1970
        return String(Int64(timeInterval * 1000))
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
