part of flutter_openim_sdk_ffi;
/*
 * Summary: native通知处理
 * Created Date: 2023-08-25 17:25:25
 * Author: Spicely
 * -----
 * Last Modified: 2023-08-30 11:51:35
 * Modified By: Spicely
 * -----
 * Copyright (c) 2023 Spicely Inc.
 * 
 * May the force be with you.
 * -----
 * HISTORY:
 * Date      	By	Comments
 */

Future<dynamic> _nativeCall(MethodCall call) async {
  try {
    switch (call.method) {
      case 'initSDK':
        Map<String, dynamic> params = Map<String, dynamic>.from(call.arguments);
        InitSdkParams data = InitSdkParams(
          apiAddr: 'http://121.40.210.13:10002',
          wsAddr: 'ws://121.40.210.13:10001',
          logLevel: 1,
          appID: params['appID'],
          secret: params['secret'],
        );
        bool status = await OpenIMManager.init(params: data);
        if (status) {
          debugPrint('初始化成功');
        } else {
          debugPrint('初始化失败');
        }
        break;
      case _PortMethod.login:
        try {
          Map<String, dynamic> params = Map<String, dynamic>.from(call.arguments);
          UserInfo userInfo = await OpenIM.iMManager.login(userID: params['userID']);
          OpenIM.iMManager.userManager.setSelfInfo(
            nickname: params['nickname'],
            faceURL: params['faceURL'],
            phoneNumber: params['phoneNumber'],
          );
          return userInfo.toJson();
        } catch (e) {
          return e.toString();
        }
      case _PortMethod.getAppUserId:
        try {
          Map<String, dynamic> params = Map<String, dynamic>.from(call.arguments);
          String id = await OpenIM.iMManager.userManager.getAppUserId(userID: params['userID']);
          return id;
        } catch (e) {
          return e.toString();
        }
      default:
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return null;
}
