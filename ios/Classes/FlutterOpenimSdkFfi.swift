
import Foundation


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

@objc public class FlutterOpenimSdkFfi: NSObject {
    let handle: UnsafeMutableRawPointer
    
    private var deferredInfoMap: [String: (Any?, Error?) -> Void] = [:]
    
    private static var listeners: [Any] = []
    
    private static var sharedCallbackInstance: FlutterOpenimSdkFfi?
    
    @objc public static func addListener(_ listener: Any) {
        listeners.append(listener)
    }
    
    @objc public static func removeListener(_ listener: Any) {
        if let index = listeners.firstIndex(where: { ($0 as AnyObject) === listener as AnyObject }) {
            listeners.remove(at: index)
        }
    }
    
    public override init() {
        handle = dlopen("flutter_openim_sdk_ffi.framework/flutter_openim_sdk_ffi", RTLD_NOW)
        super.init()
        FlutterOpenimSdkFfi.sharedCallbackInstance = self
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
        case "OnInitSDK":
            for listener in FlutterOpenimSdkFfi.listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onInitSDK()
                }
            }
        default:
            break
        }
    }
    
    @objc public func registerCallback() {
        let functionPointer = dlsym(handle, "nativeRegisterCallback")
        typealias FunctionType = @convention(c) (_ callback: NativeMethodCallback?) -> Void
        let nativeRegisterCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
        
        // Pass the bridge function as a C function pointer
        nativeRegisterCallback(FlutterOpenimSdkFfi.handleNativeMethodBridge)
    }
    
    // 登陆
    @objc public func login(userID: String, token: String, completion: @escaping (Any?, Error?) -> Void) {
        let operationID = getCurrentTimeMillisString()
        let operationIDString = convertToCCharArray(operationID)!
        let userIDCString = convertToCCharArray(userID)!
        let tokenCString = convertToCCharArray(token)!
        deferredInfoMap[operationID] = completion
        
        typealias FunctionType = @convention(c) (UnsafeMutablePointer<UInt8>, UnsafeMutablePointer<UInt8>, UnsafeMutablePointer<UInt8>) -> Void
        let functionPointer = dlsym(handle, "login")
        let loginCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
        loginCallback(operationIDString, userIDCString, tokenCString)
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
        let operationID = getCurrentTimeMillisString()
        let operationIDString = operationID.cString(using: .utf8)!
        deferredInfoMap[operationID] = completion
        
        typealias FunctionType = @convention(c) (UnsafePointer<CChar>) -> Void
        let functionPointer = dlsym(handle, "getSelfUserInfo")
        let getSelfUserInfoCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
        getSelfUserInfoCallback(operationIDString)
    }
    
    private func getCurrentTimeMillisString() -> String {
        let currentTime = Date()
        let timeInterval = currentTime.timeIntervalSince1970
        return String(Int64(timeInterval * 1000))
    }
    
    
    // Bridge function to avoid capturing 'self' within the closure
    private static let handleNativeMethodBridge: NativeMethodCallback = { (methodName, operationID, callMethodName, errCode, message) in
        sharedCallbackInstance?.handleNativeMethodCallback(
            methodName: methodName,
            operationID: operationID,
            callMethodName: callMethodName,
            errCode: errCode,
            message: message
        )
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
