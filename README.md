# flutter_openim_sdk_ffi
 支持windows、ios、android、macos、linux
# init 
```dart
  await OpenIMManager.init(
    apiAddr: 'https://web.muka.site/api',
    wsAddr: 'wss://web.muka.site/msg_gateway',
  );
```

# Listener
```dart
  class ImController extends GetxController with OpenIMListener {
  @override
  void onInit() {
    OpenIMManager.addListener(this);
    super.onInit();
  }

  @override
  void onClose() {
    OpenIMManager.removeListener(this);
    super.onClose();
  }

  @override
  void onConnectSuccess() {
    print('连接成功');
  }

  @override
  void onConnectFailed(int? code, String? errorMsg) {
    print(code);
    print(errorMsg);
  }

  @override
  void onConnecting() {
    print('连接中');
  }

  ...
}

```

# Other
```dart
  UserInfo userInfo = await OpenIM.iMManager.login(uid: userID, token: token);
```

to [OpenIMDoc](https://doc.rentsoft.cn/sdks/introduction)

## Project structure

flutter pub run ffigen --config ffigen.yaml

nm -D openim_sdk_ffi.so

nm -gU flutter_openim_sdk_ffi

dumpbin /exports openim_sdk_ffi.dll

lipo -info macos/libopenim_sdk_ffi.dylib

