
import Foundation
import Flutter


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

@objc public class FlutterOpenimSdkFfi: NSObject {
    private static var channel: FlutterMethodChannel?
    
    private var deferredInfoMap: [String: (Any?, Error?) -> Void] = [:]
    
    private static var listeners: [Any] = []
    
    @objc public static func addListener(_ listener: Any) {
        listeners.append(listener)
    }
    
    @objc public static func removeListener(_ listener: Any) {
        if let index = listeners.firstIndex(where: { ($0 as AnyObject) === listener as AnyObject }) {
            listeners.remove(at: index)
        }
    }
    
    public override init() {
        super.init()
    }
    
    // 这个方法将被C函数调用，用于通知Swift
    private func handleNativeMethodCallback(methodName: UnsafePointer<Int8>, operationID: UnsafePointer<Int8>?, callMethodName: UnsafePointer<Int8>?, errCode: UnsafePointer<Double>?, message: UnsafePointer<Int8>?) {
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
                if let callback = deferredInfoMap[operationIDString] {
                    callback(userInfo, nil)
                    deferredInfoMap.removeValue(forKey: operationIDString)
                }
                //            case "GetTotalUnreadMsgCount":
                //                if let unreadCount = Int(messageString) {
                //                    deferredInfoMap[operationIDString]??.complete(result: unreadCount)
                //                    deferredInfoMap.removeValue(forKey: operationIDString)
                //                }
            case "Login":
                if let callback = deferredInfoMap[operationIDString] {
                    callback(nil, nil)
                    deferredInfoMap.removeValue(forKey: operationIDString)
                }
            default:
                break
            }
        case "OnError":
            let customException = CustomException(errCode: Int(bitPattern: errCode) , message: messageString)
            if let callback = deferredInfoMap[operationIDString] {
                callback(nil, customException)
                deferredInfoMap.removeValue(forKey: operationIDString)
            }
        case "OnConnectFailed":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onConnectFailed(code:Int64(Int(bitPattern: errCode)),error:messageString)
                }
            }
        case "OnKickedOffline":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onKickedOffline()
                }
            }
        case "OnConnectSuccess":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onConnectSuccess()
                }
            }
        case "OnConnecting":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onConnecting()
                }
            }case "OnUserTokenExpired":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onUserTokenExpired()
                }
            }
        default:
            break
        }
    }
    
    @objc public static func register(binaryMessenger: FlutterBinaryMessenger) {
        FlutterOpenimSdkFfi.channel = FlutterMethodChannel(name: "plugins.muka.site/flutter_openim_sdk_ffi", binaryMessenger: binaryMessenger)
        FlutterOpenimSdkFfi.channel?.setMethodCallHandler(onMethodCall)
    }
    
    // 登陆
    @objc public func login(userID: String, token: String) {
        let arg: [String: Any] = ["userID": userID, "token": token]
        FlutterOpenimSdkFfi.channel?.invokeMethod("Login", arguments: arg)
    }
    
    static func onMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "OnInitSDK":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onInitSDK()
                }
            }
            result(true)
        default: break
            
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
    
    // 获取用户信息
    @objc public func getSelfUserInfo(completion: @escaping (Any?, Error?) -> Void) {
//        let operationID = getCurrentTimeMillisString()
//        let operationIDString = operationID.cString(using: .utf8)!
//        deferredInfoMap[operationID] = completion
//
//        typealias FunctionType = @convention(c) (UnsafePointer<CChar>) -> Void
//        let functionPointer = dlsym(handle, "getSelfUserInfo")
//        let getSelfUserInfoCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
//        getSelfUserInfoCallback(operationIDString)
    }
    
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
