# flutter_openim_sdk_ffi
 支持windows、ios、android、macos、linux 对应openim v3.1

 
## 警告！！
当前为测试版本可能面对不兼容修改
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

## 已知问题

windows平台发送消息会闪退





