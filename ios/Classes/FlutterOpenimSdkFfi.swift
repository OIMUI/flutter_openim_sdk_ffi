//
//  FlutterOpenimSdkFfi.swift
//  flutter_openim_sdk_ffi
//
//  Created by Muka on 2023/7/10.
//

import Foundation


public class FlutterOpenimSdkFfi {
    public static func registerCallback() {
        // 打开动态库
        let handle = dlopen("flutter_openim_sdk_ffi.framework/flutter_openim_sdk_ffi", RTLD_NOW)

        if handle != nil {
            print("动态库打开成功")
            // 执行你想要的操作，比如调用库中的函数或使用库中的符号

            // 关闭动态库
            dlclose(handle)
        } else {
            // 动态库打开失败
            let error = String(cString: dlerror())
            print("无法打开动态库: \(error)")
        }
    }
}
