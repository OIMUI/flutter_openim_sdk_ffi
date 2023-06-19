part of flutter_openim_sdk_ffi;

class IMManager {
  MethodChannel _channel;
  late ConversationManager conversationManager;
  late FriendshipManager friendshipManager;
  late MessageManager messageManager;
  late GroupManager groupManager;
  late UserManager userManager;

  // late OfflinePushManager offlinePushManager;
  late SignalingManager signalingManager;
  late WorkMomentsManager workMomentsManager;
  late OrganizationManager organizationManager;
  OnListenerForService? _listenerForService;
  late String uid;
  late UserInfo uInfo;
  bool isLogined = false;
  String? token;
  String? _objectStorage;

  IMManager(this._channel) {
    conversationManager = ConversationManager(_channel);
    friendshipManager = FriendshipManager(_channel);
    messageManager = MessageManager(_channel);
    groupManager = GroupManager(_channel);
    userManager = UserManager(_channel);
    // offlinePushManager = OfflinePushManager(_channel);
    signalingManager = SignalingManager(_channel);
    workMomentsManager = WorkMomentsManager(_channel);
    organizationManager = OrganizationManager(_channel);
    // _addNativeCallback(_channel);
  }

  // void _addNativeCallback(MethodChannel _channel) {
  //   _channel.setMethodCallHandler((call) {
  //     try {
  //       Logger.print('Flutter : $call');
  //       if (call.method == ListenerType.connectListener) {
  //         String type = call.arguments['type'];
  //         switch (type) {
  //           case 'onConnectFailed':
  //             int? errCode = call.arguments['errCode'];
  //             String? errMsg = call.arguments['errMsg'];
  //             // _connectListener.connectFailed(errCode, errMsg);
  //             break;
  //           case 'onConnecting':
  //             _connectListener.connecting();
  //             break;
  //           case 'onConnectSuccess':
  //             _connectListener.connectSuccess();
  //             break;
  //           case 'onKickedOffline':
  //             _connectListener.kickedOffline();
  //             break;
  //           case 'onUserTokenExpired':
  //             _connectListener.userTokenExpired();
  //             break;
  //         }
  //       } else if (call.method == ListenerType.userListener) {
  //         String type = call.arguments['type'];
  //         dynamic data = call.arguments['data'];
  //         switch (type) {
  //           case 'onSelfInfoUpdated':
  //             uInfo = Utils.toObj(data, (map) => UserInfo.fromJson(map));
  //             userManager.listener.selfInfoUpdated(uInfo);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.groupListener) {
  //         String type = call.arguments['type'];
  //         dynamic data = call.arguments['data'];
  //         switch (type) {
  //           case 'onGroupApplicationAccepted':
  //             final i = Utils.toObj(data, (map) => GroupApplicationInfo.fromJson(map));
  //             groupManager.listener.groupApplicationAccepted(i);
  //             break;
  //           case 'onGroupApplicationAdded':
  //             final i = Utils.toObj(data, (map) => GroupApplicationInfo.fromJson(map));
  //             groupManager.listener.groupApplicationAdded(i);
  //             break;
  //           case 'onGroupApplicationDeleted':
  //             final i = Utils.toObj(data, (map) => GroupApplicationInfo.fromJson(map));
  //             groupManager.listener.groupApplicationDeleted(i);
  //             break;
  //           case 'onGroupApplicationRejected':
  //             final i = Utils.toObj(data, (map) => GroupApplicationInfo.fromJson(map));
  //             groupManager.listener.groupApplicationRejected(i);
  //             break;
  //           case 'onGroupInfoChanged':
  //             final i = Utils.toObj(data, (map) => GroupInfo.fromJson(map));
  //             groupManager.listener.groupInfoChanged(i);
  //             break;
  //           case 'onGroupMemberAdded':
  //             final i = Utils.toObj(data, (map) => GroupMembersInfo.fromJson(map));
  //             groupManager.listener.groupMemberAdded(i);
  //             break;
  //           case 'onGroupMemberDeleted':
  //             final i = Utils.toObj(data, (map) => GroupMembersInfo.fromJson(map));
  //             groupManager.listener.groupMemberDeleted(i);
  //             break;
  //           case 'onGroupMemberInfoChanged':
  //             final i = Utils.toObj(data, (map) => GroupMembersInfo.fromJson(map));
  //             groupManager.listener.groupMemberInfoChanged(i);
  //             break;
  //           case 'onJoinedGroupAdded':
  //             final i = Utils.toObj(data, (map) => GroupInfo.fromJson(map));
  //             groupManager.listener.joinedGroupAdded(i);
  //             break;
  //           case 'onJoinedGroupDeleted':
  //             final i = Utils.toObj(data, (map) => GroupInfo.fromJson(map));
  //             groupManager.listener.joinedGroupDeleted(i);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.advancedMsgListener) {
  //         var type = call.arguments['type'];
  //         // var id = call.arguments['data']['id'];
  //         switch (type) {
  //           case 'onRecvNewMessage':
  //             var value = call.arguments['data']['newMessage'];
  //             final msg = Utils.toObj(value, (map) => Message.fromJson(map));
  //             messageManager.msgListener.recvNewMessage(msg);
  //             break;
  //           case 'onRecvMessageRevoked':
  //             var msgID = call.arguments['data']['revokedMessage'];
  //             messageManager.msgListener.recvMessageRevoked(msgID);
  //             break;
  //           case 'onRecvC2CReadReceipt':
  //             var value = call.arguments['data']['c2cMessageReadReceipt'];
  //             var list = Utils.toList(value, (map) => ReadReceiptInfo.fromJson(map));
  //             messageManager.msgListener.recvC2CMessageReadReceipt(list);
  //             break;
  //           case 'onRecvGroupReadReceipt':
  //             var value = call.arguments['data']['groupMessageReadReceipt'];
  //             var list = Utils.toList(value, (map) => ReadReceiptInfo.fromJson(map));
  //             messageManager.msgListener.recvGroupMessageReadReceipt(list);
  //             break;
  //           case 'onNewRecvMessageRevoked':
  //             var value = call.arguments['data']['revokedMessageV2'];
  //             var info = Utils.toObj(value, (map) => RevokedInfo.fromJson(map));
  //             messageManager.msgListener.recvMessageRevokedV2(info);
  //             break;
  //           case 'onRecvMessageExtensionsChanged':
  //             var msgID = call.arguments['data']['msgID'];
  //             var value = call.arguments['data']['list'];
  //             var list = Utils.toList(value, (map) => KeyValue.fromJson(map));
  //             messageManager.msgListener.recvMessageExtensionsChanged(msgID, list);
  //             break;
  //           case 'onRecvMessageExtensionsDeleted':
  //             var msgID = call.arguments['data']['msgID'];
  //             var value = call.arguments['data']['list'];
  //             var list = Utils.toList(value, (map) => '$map');
  //             messageManager.msgListener.recvMessageExtensionsDeleted(msgID, list);
  //             break;
  //           case 'onRecvMessageExtensionsAdded':
  //             var msgID = call.arguments['data']['msgID'];
  //             var value = call.arguments['data']['list'];
  //             var list = Utils.toList(value, (map) => KeyValue.fromJson(map));
  //             messageManager.msgListener.recvMessageExtensionsAdded(msgID, list);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.msgSendProgressListener) {
  //         String type = call.arguments['type'];
  //         dynamic data = call.arguments['data'];
  //         String msgID = data['clientMsgID'] ?? '';
  //         int progress = data['progress'] ?? 100;
  //         switch (type) {
  //           case 'onProgress':
  //             messageManager.msgSendProgressListener?.progress(
  //               msgID,
  //               progress,
  //             );
  //             break;
  //         }
  //       } else if (call.method == ListenerType.conversationListener) {
  //         String type = call.arguments['type'];
  //         dynamic data = call.arguments['data'];
  //         switch (type) {
  //           case 'onSyncServerStart':
  //             conversationManager.listener.syncServerStart();
  //             break;
  //           case 'onSyncServerFinish':
  //             conversationManager.listener.syncServerFinish();
  //             break;

  //           case 'onSyncServerFailed':
  //             conversationManager.listener.syncServerFailed();
  //             break;
  //           case 'onNewConversation':
  //             var list = Utils.toList(data, (map) => ConversationInfo.fromJson(map));
  //             conversationManager.listener.newConversation(list);
  //             break;
  //           case 'onConversationChanged':
  //             var list = Utils.toList(data, (map) => ConversationInfo.fromJson(map));
  //             conversationManager.listener.conversationChanged(list);
  //             break;
  //           case 'onTotalUnreadMessageCountChanged':
  //             conversationManager.listener.totalUnreadMessageCountChanged(data ?? 0);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.friendListener) {
  //         String type = call.arguments['type'];
  //         dynamic data = call.arguments['data'];

  //         switch (type) {
  //           case 'onBlacklistAdded':
  //             final u = Utils.toObj(data, (map) => BlacklistInfo.fromJson(map));
  //             friendshipManager.listener.blacklistAdded(u);
  //             break;
  //           case 'onBlacklistDeleted':
  //             final u = Utils.toObj(data, (map) => BlacklistInfo.fromJson(map));
  //             friendshipManager.listener.blacklistDeleted(u);
  //             break;
  //           case 'onFriendApplicationAccepted':
  //             final u = Utils.toObj(data, (map) => FriendApplicationInfo.fromJson(map));
  //             friendshipManager.listener.friendApplicationAccepted(u);
  //             break;
  //           case 'onFriendApplicationAdded':
  //             final u = Utils.toObj(data, (map) => FriendApplicationInfo.fromJson(map));
  //             friendshipManager.listener.friendApplicationAdded(u);
  //             break;
  //           case 'onFriendApplicationDeleted':
  //             final u = Utils.toObj(data, (map) => FriendApplicationInfo.fromJson(map));
  //             friendshipManager.listener.friendApplicationDeleted(u);
  //             break;
  //           case 'onFriendApplicationRejected':
  //             final u = Utils.toObj(data, (map) => FriendApplicationInfo.fromJson(map));
  //             friendshipManager.listener.friendApplicationRejected(u);
  //             break;
  //           case 'onFriendInfoChanged':
  //             final u = Utils.toObj(data, (map) => FriendInfo.fromJson(map));
  //             friendshipManager.listener.friendInfoChanged(u);
  //             break;
  //           case 'onFriendAdded':
  //             final u = Utils.toObj(data, (map) => FriendInfo.fromJson(map));
  //             friendshipManager.listener.friendAdded(u);
  //             break;
  //           case 'onFriendDeleted':
  //             final u = Utils.toObj(data, (map) => FriendInfo.fromJson(map));
  //             friendshipManager.listener.friendDeleted(u);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.signalingListener) {
  //         String type = call.arguments['type'];
  //         dynamic data = call.arguments['data'];
  //         dynamic info;
  //         switch (type) {
  //           case 'onRoomParticipantConnected':
  //           case 'onRoomParticipantDisconnected':
  //             info = Utils.toObj(data, (map) => RoomCallingInfo.fromJson(map));
  //             break;
  //           case 'onStreamChange':
  //             info = Utils.toObj(data, (map) => MeetingStreamEvent.fromJson(map));
  //             break;
  //           case 'onReceiveCustomSignal':
  //             info = Utils.toObj(data, (map) => CustomSignaling.fromJson(map));
  //             break;
  //           default:
  //             info = Utils.toObj(data, (map) => SignalingInfo.fromJson(map));
  //             break;
  //         }
  //         switch (type) {
  //           case 'onInvitationCancelled':
  //             signalingManager.listener.invitationCancelled(info);
  //             break;
  //           case 'onInvitationTimeout':
  //             signalingManager.listener.invitationTimeout(info);
  //             break;
  //           case 'onInviteeAccepted':
  //             signalingManager.listener.inviteeAccepted(info);
  //             break;
  //           case 'onInviteeRejected':
  //             signalingManager.listener.inviteeRejected(info);
  //             break;
  //           case 'onReceiveNewInvitation':
  //             signalingManager.listener.receiveNewInvitation(info);
  //             break;
  //           case 'onInviteeAcceptedByOtherDevice':
  //             signalingManager.listener.inviteeAcceptedByOtherDevice(info);
  //             break;
  //           case 'onInviteeRejectedByOtherDevice':
  //             signalingManager.listener.inviteeRejectedByOtherDevice(info);
  //             break;
  //           case 'onHangUp':
  //             signalingManager.listener.hangup(info);
  //             break;
  //           case 'onRoomParticipantConnected':
  //             signalingManager.listener.roomParticipantConnected(info);
  //             break;
  //           case 'onRoomParticipantDisconnected':
  //             signalingManager.listener.roomParticipantDisconnected(info);
  //             break;
  //           case 'onStreamChange':
  //             signalingManager.listener.streamChangedEvent(info);
  //             break;
  //           case 'onReceiveCustomSignal':
  //             signalingManager.listener.receiveCustomSignal(info);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.workMomentsListener) {
  //         String type = call.arguments['type'];
  //         switch (type) {
  //           case 'OnRecvNewNotification':
  //             workMomentsManager.listener.recvNewNotification();
  //             break;
  //         }
  //       } else if (call.method == ListenerType.organizationListener) {
  //         String type = call.arguments['type'];
  //         switch (type) {
  //           case 'onOrganizationUpdated':
  //             organizationManager.listener.organizationUpdated();
  //             break;
  //         }
  //       } else if (call.method == ListenerType.customBusinessListener) {
  //         String type = call.arguments['type'];
  //         String data = call.arguments['data'];
  //         switch (type) {
  //           case 'onRecvCustomBusinessMessage':
  //             messageManager.customBusinessListener?.recvCustomBusinessMessage(data);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.messageKvInfoListener) {
  //         String type = call.arguments['type'];
  //         String data = call.arguments['data'];
  //         switch (type) {
  //           case 'onMessageKvInfoChanged':
  //             final list = Utils.toList(data, (map) => MessageKv.fromJson(map)).toList();
  //             messageManager.messageKvInfoListener?.messageKvInfoChanged(list);
  //             break;
  //         }
  //       } else if (call.method == ListenerType.listenerForService) {
  //         String type = call.arguments['type'];
  //         String data = call.arguments['data'];
  //         switch (type) {
  //           case 'onFriendApplicationAccepted':
  //             final u = Utils.toObj(data, (map) => FriendApplicationInfo.fromJson(map));
  //             _listenerForService?.friendApplicationAccepted(u);
  //             break;
  //           case 'onFriendApplicationAdded':
  //             final u = Utils.toObj(data, (map) => FriendApplicationInfo.fromJson(map));
  //             _listenerForService?.friendApplicationAdded(u);
  //             break;
  //           case 'onGroupApplicationAccepted':
  //             final i = Utils.toObj(data, (map) => GroupApplicationInfo.fromJson(map));
  //             _listenerForService?.groupApplicationAccepted(i);
  //             break;
  //           case 'onGroupApplicationAdded':
  //             final i = Utils.toObj(data, (map) => GroupApplicationInfo.fromJson(map));
  //             _listenerForService?.groupApplicationAdded(i);
  //             break;
  //           case 'onRecvNewMessage':
  //             final msg = Utils.toObj(data, (map) => Message.fromJson(map));
  //             _listenerForService?.recvNewMessage(msg);
  //             break;
  //         }
  //       }
  //     } catch (error, stackTrace) {
  //       Logger.print("回调失败了。${call.method} ${call.arguments['type']} ${call.arguments['data']} $error $stackTrace");
  //     }
  //     return Future.value(null);
  //   });
  // }

  /// 反初始化SDK
  Future<dynamic> unInitSDK() {
    return _channel.invokeMethod('unInitSDK', _buildParam({}));
  }

  /// 登录
  /// [uid] 用户id
  /// [token] 登录token，从业务服务器上获取
  /// [defaultValue] 获取失败后使用的默认值
  void login({
    required String uid,
    required String token,
    String? operationID,
    Future<UserInfo> Function()? defaultValue,
  }) async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.login,
      data: {
        'operationID': Utils.checkOperationID(operationID),
        'uid': uid,
        'token': token,
      },
      sendPort: receivePort.sendPort,
    ));
    // return await receivePort.first;

    // OpenIMManager._openIMSendPort.send({
    //   'type': 'login',
    //   'uid': uid,
    //   'token': token,
    //   'operationID': Utils.checkOperationID(operationID),
    //   'defaultValue': defaultValue,
    // });
    // calloc.free(id);
    // calloc.free(t);
    // calloc.free(i);
    // await _channel.invokeMethod(
    //   'login',
    //   _buildParam({
    //     'uid': uid,
    //     'token': token,
    //     'operationID': Utils.checkOperationID(operationID),
    //   }),
    // );
    // this.isLogined = true;
    // this.uid = uid;
    // this.token = token;
    // try {
    //   return this.uInfo = await userManager.getSelfUserInfo();
    // } catch (error, stackTrace) {
    //   log('login e: $error  s: $stackTrace');
    //   if (null != defaultValue) {
    //     return this.uInfo = await (defaultValue.call());
    //   }
    //   return Future.error(error, stackTrace);
    // }
    // return uInfo;
  }

  /// 登出
  Future<dynamic> logout({String? operationID}) async {
    var value = await _channel.invokeMethod(
        'logout',
        _buildParam({
          'operationID': Utils.checkOperationID(operationID),
        }));
    this.isLogined = false;
    this.token = null;
    return value;
  }

  /// 获取登录状态
  Future<int?> getLoginStatus() => _channel.invokeMethod<int>('getLoginStatus', _buildParam({}));

  /// 获取当前登录用户id
  Future<String> getLoginUserID() async => uid;

  /// 获取当前登录用户信息
  Future<UserInfo> getLoginUserInfo() async => uInfo;

  /// 从后台回到前台立刻唤醒
  Future wakeUp({String? operationID}) => _channel.invokeMethod(
      'wakeUp',
      _buildParam({
        'operationID': Utils.checkOperationID(operationID),
      }));

  /// 上传图片到服务器
  /// [path] 图片路径
  /// [token] im token
  /// [objectStorage] 存储对象 cos/minio
  Future uploadImage({
    required String path,
    String? token,
    String? objectStorage,
    String? operationID,
  }) =>
      _channel.invokeMethod(
          'uploadImage',
          _buildParam({
            'path': path,
            'token': token ?? this.token,
            'obj': objectStorage ?? this._objectStorage,
            'operationID': Utils.checkOperationID(operationID),
          }));

  /// 更新firebase客户端注册token
  /// [fcmToken] firebase token
  Future updateFcmToken({
    required String fcmToken,
    String? operationID,
  }) =>
      _channel.invokeMethod(
          'updateFcmToken',
          _buildParam({
            'fcmToken': fcmToken,
            'operationID': Utils.checkOperationID(operationID),
          }));

  /// 标记app处于后台
  Future setAppBackgroundStatus({
    required bool isBackground,
    String? operationID,
  }) =>
      _channel.invokeMethod(
          'setAppBackgroundStatus',
          _buildParam({
            'isBackground': isBackground,
            'operationID': Utils.checkOperationID(operationID),
          }));

  /// 网络改变
  Future networkChanged({
    String? operationID,
  }) =>
      _channel.invokeMethod(
          'networkChanged',
          _buildParam({
            'operationID': Utils.checkOperationID(operationID),
          }));

  ///
  Future setListenerForService(OnListenerForService listener) {
    if (Platform.isAndroid) {
      this._listenerForService = listener;
      return _channel.invokeMethod('setListenerForService', _buildParam({}));
    } else {
      throw UnsupportedError("only supprot android platform");
    }
  }

  MethodChannel get channel => _channel;

  static Map _buildParam(Map param) {
    param["ManagerName"] = "imManager";
    return param;
  }
}
