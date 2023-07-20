
import Foundation


// 定义一个Swift函数类型，与C函数指针匹配
typealias NativeMethodCallback = @convention(c) (UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Int8>, UnsafePointer<Double>, UnsafePointer<Int8>) -> Void

public class FlutterOpenimSdkFfi: NSObject {
    let handle: UnsafeMutableRawPointer
    
    private static var sharedCallbackInstance: FlutterOpenimSdkFfi?
    
    public override init() {
        handle = dlopen("flutter_openim_sdk_ffi.framework/flutter_openim_sdk_ffi", RTLD_NOW)
        super.init()
        FlutterOpenimSdkFfi.sharedCallbackInstance = self
    }
    
    // 这个方法将被C函数调用，用于通知Swift
    private func handleNativeMethodCallback(methodName: UnsafePointer<Int8>, operationID: UnsafePointer<Int8>, callMethodName: UnsafePointer<Int8>, errCode: UnsafePointer<Double>, message: UnsafePointer<Int8>) {
        let methodNameString = String(cString: methodName)
        print("Swift: Received callback from C with method name \(methodNameString)")
    }
    
    public func registerCallback() {
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
}
