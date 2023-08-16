
import Foundation
import Flutter


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

@objc public class FlutterOpenimSdkFfi: NSObject {
    private var handle: UnsafeMutableRawPointer?
    
    private var channel: FlutterMethodChannel?
    
    private static var sharedCallbackInstance: FlutterOpenimSdkFfi?
    
    private var deferredInfoMap: [String: Deferred<Any?>?] = [:]
    
    private var listeners: [Any] = []
    
    // 创建一个并发队列
    private let concurrentQueue = DispatchQueue(label: "com.muka.concurrentQueue", attributes: .concurrent)
    
    @objc public func addListener(_ listener: Any) {
        listeners.append(listener)
    }
    
    @objc public func removeListener(_ listener: Any) {
        if let index = listeners.firstIndex(where: { ($0 as AnyObject) === listener as AnyObject }) {
            listeners.remove(at: index)
        }
    }
    
    public override init() {
        super.init()
        concurrentQueue.async {
            self.handle = dlopen("flutter_openim_sdk_ffi.framework/flutter_openim_sdk_ffi", RTLD_NOW)
        }
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
                deferredInfoMap[operationIDString]??.complete(result: userInfo)
                deferredInfoMap.removeValue(forKey: operationIDString)
            case "GetTotalUnreadMsgCount":
                if let unreadCount = Int(messageString) {
                    deferredInfoMap[operationIDString]??.complete(result: unreadCount)
                    deferredInfoMap.removeValue(forKey: operationIDString)
                }
            case "Login":
                deferredInfoMap[operationIDString]??.complete(result: nil)
                deferredInfoMap.removeValue(forKey: operationIDString)
            default:
                break
            }
        case "OnError":
            let customException = CustomException(errCode: Int(bitPattern: errCode) , message: messageString)
            deferredInfoMap[operationIDString]??.complete(with: customException)
            deferredInfoMap.removeValue(forKey: operationIDString)
        case "OnConnectFailed":
            for listener in listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onConnectFailed(code:Int64(Int(bitPattern: errCode)),error:messageString)
                }
            }
        case "OnKickedOffline":
            for listener in listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onKickedOffline()
                }
            }
        case "OnConnectSuccess":
            for listener in listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onConnectSuccess()
                }
            }
        case "OnConnecting":
            for listener in listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onConnecting()
                }
            }
        case "OnUserTokenExpired":
            for listener in listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onUserTokenExpired()
                }
            }
        case "OnInitSDK":
            for listener in listeners {
                if let onConnListener = listener as? OnConnListener {
                    onConnListener.onInitSDK()
                }
            }
        default:
            break
        }
    }
    
    @objc public func register(binaryMessenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: "plugins.muka.site/flutter_openim_sdk_ffi", binaryMessenger: binaryMessenger)
        channel?.setMethodCallHandler(onMethodCall)
        let functionPointer = dlsym(handle, "nativeRegisterCallback")
        typealias FunctionType = @convention(c) (_ callback: NativeMethodCallback?) -> Void
        let nativeRegisterCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
        
        // Pass the bridge function as a C function pointer
        nativeRegisterCallback(FlutterOpenimSdkFfi.handleNativeMethodBridge)
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
    
    func onMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        //        switch call.method {
        //
        //        default: break
        //
        //        }
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
    
    // 登陆
    @objc public func login(userID: String, token: String) {
        concurrentQueue.async {
            let operationID = self.getCurrentTimeMillisString()
            let deferred = Deferred<Any?>()
            let operationIDString = self.convertToCCharArray(operationID)!
            let userIDCString = self.convertToCCharArray(userID)!
            let tokenCString = self.convertToCCharArray(token)!
            self.deferredInfoMap[operationID] = deferred
            
            typealias FunctionType = @convention(c) (UnsafeMutablePointer<UInt8>, UnsafeMutablePointer<UInt8>, UnsafeMutablePointer<UInt8>) -> Void
            let functionPointer = dlsym(self.handle, "login")
            let loginCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
            loginCallback(operationIDString, userIDCString, tokenCString)
        }
    }
    
    // 获取用户信息
    // 获取用户信息
    @objc public func getSelfUserInfo() throws -> UserInfo {
        let operationID = getCurrentTimeMillisString()
        let operationIDString = operationID.cString(using: .utf8)!
        let deferred = Deferred<Any?>()
        deferredInfoMap[operationID] = deferred
        
        typealias FunctionType = @convention(c) (UnsafePointer<CChar>) -> Void
        let functionPointer = dlsym(handle, "getSelfUserInfo")
        let getSelfUserInfoCallback = unsafeBitCast(functionPointer, to: FunctionType.self)
        getSelfUserInfoCallback(operationIDString)
        
        return try deferred.await() as! UserInfo
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
