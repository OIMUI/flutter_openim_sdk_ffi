part of flutter_openim_sdk_ffi;

class IMManager {
  late ConversationManager conversationManager;
  late FriendshipManager friendshipManager;
  late MessageManager messageManager;
  late GroupManager groupManager;
  late UserManager userManager;

  // late OfflinePushManager offlinePushManager;
  late SignalingManager signalingManager;
  late OrganizationManager organizationManager;

  late String uid;

  late UserInfo uInfo;

  bool isLogined = false;
  String? token;

  IMManager() {
    conversationManager = ConversationManager();
    friendshipManager = FriendshipManager();
    messageManager = MessageManager();
    groupManager = GroupManager();
    userManager = UserManager();
    // offlinePushManager = OfflinePushManager(_channel);
    signalingManager = SignalingManager();
    organizationManager = OrganizationManager();
  }

  void _nativeCallback(_PortModel channel) {
    switch (channel.method) {
      case ListenerType.onConnectFailed:
        OpenIMManager._onEvent((listener) => listener.onConnectFailed(channel.errCode, ''));
        break;
      case ListenerType.onConnecting:
        OpenIMManager._onEvent((listener) => listener.onConnecting());
        break;
      case ListenerType.onConnectSuccess:
        OpenIMManager._onEvent((listener) => listener.onConnectSuccess());
        break;
      case ListenerType.onKickedOffline:
        OpenIMManager._onEvent((listener) => listener.onKickedOffline());
        break;
      case ListenerType.onUserTokenExpired:
        OpenIMManager._onEvent((listener) => listener.onUserTokenExpired());
        break;
      case ListenerType.onSyncServerStart:
        OpenIMManager._onEvent((listener) => listener.onSyncServerStart());
        break;
      case ListenerType.onSyncServerFinish:
        OpenIMManager._onEvent((listener) => listener.onSyncServerFinish());
        break;
      case ListenerType.onSyncServerFailed:
        OpenIMManager._onEvent((listener) => listener.onSyncServerFailed());
        break;
      case ListenerType.onNewConversation:
        OpenIMManager._onEvent((listener) => listener.onNewConversation(channel.data));
        break;
      case ListenerType.onConversationChanged:
        OpenIMManager._onEvent((listener) => listener.onConversationChanged(channel.data));
        break;
      case ListenerType.onTotalUnreadMessageCountChanged:
        OpenIMManager._onEvent((listener) => listener.onTotalUnreadMessageCountChanged(channel.errCode ?? 0));
        break;
      case ListenerType.onProgress:
        OpenIMManager._onEvent((listener) => listener.onProgress(channel.data ?? '', channel.errCode ?? 0));
      case ListenerType.onRecvNewMessage:
        OpenIMManager._onEvent((listener) => listener._onRecvNewMessage(channel.data));
        break;
      case ListenerType.onSelfInfoUpdated:
        OpenIMManager._onEvent((listener) => listener.onSelfInfoUpdated(channel.data));
        break;

      case ListenerType.onGroupApplicationAccepted:
        OpenIMManager._onEvent((listener) => listener.onGroupApplicationAccepted(channel.data));
        break;
      case ListenerType.onGroupApplicationAdded:
        OpenIMManager._onEvent((listener) => listener.onGroupApplicationAdded(channel.data));
        break;
      case ListenerType.onGroupApplicationDeleted:
        OpenIMManager._onEvent((listener) => listener.onGroupApplicationDeleted(channel.data));
        break;
      case ListenerType.onGroupApplicationRejected:
        OpenIMManager._onEvent((listener) => listener.onGroupApplicationRejected(channel.data));
        break;
      case ListenerType.onGroupInfoChanged:
        OpenIMManager._onEvent((listener) => listener.onGroupInfoChanged(channel.data));
        break;
      case ListenerType.onGroupMemberAdded:
        OpenIMManager._onEvent((listener) => listener.onGroupMemberAdded(channel.data));
        break;
      case ListenerType.onGroupMemberDeleted:
        OpenIMManager._onEvent((listener) => listener.onGroupMemberDeleted(channel.data));
        break;
      case ListenerType.onGroupMemberInfoChanged:
        OpenIMManager._onEvent((listener) => listener.onGroupMemberInfoChanged(channel.data));
        break;
      case ListenerType.onJoinedGroupAdded:
        OpenIMManager._onEvent((listener) => listener.onJoinedGroupAdded(channel.data));
        break;
      case ListenerType.onJoinedGroupDeleted:
        OpenIMManager._onEvent((listener) => listener.onJoinedGroupDeleted(channel.data));
        break;

      // case ListenerType.onRecvMessageRevoked:
      //   OpenIMManager._onEvent((listener) => listener.onRecvMessageRevoked(channel.data));
      //   break;
      case ListenerType.onRecvC2CReadReceipt:
        OpenIMManager._onEvent((listener) => listener.onRecvC2CMessageReadReceipt(channel.data));
        break;
      case ListenerType.onRecvGroupReadReceipt:
        OpenIMManager._onEvent((listener) => listener.onRecvGroupMessageReadReceipt(channel.data));
        break;
      case ListenerType.onNewRecvMessageRevoked:
        OpenIMManager._onEvent((listener) => listener.onRecvMessageRevokedV2(channel.data));
        break;
      // case ListenerType.onRecvMessageExtensionsChanged:
      //   OpenIMManager._onEvent((listener) => listener.onRecvMessageExtensionsChanged(channel., channel.data));
      //   break;
      // case ListenerType.onRecvMessageExtensionsDeleted:
      //   OpenIMManager._onEvent((listener) => listener.onRecvMessageExtensionsDeleted(channel.data));
      // case ListenerType.onRecvMessageExtensionsAdded:
      //   OpenIMManager._onEvent((listener) => listener.onRecvMessageExtensionsAdded(channel.data));
      //   break;

      // case ListenerType.onBlacklistAdded:
      //   OpenIMManager._onEvent((listener) => listener.onBlacklistAdded(channel.data));
      //   break;
      // case ListenerType.onBlacklistDeleted:
      //   OpenIMManager._onEvent((listener) => listener.onBlacklistDeleted(channel.data));
      //   break;
      case ListenerType.onFriendApplicationAccepted:
        OpenIMManager._onEvent((listener) => listener.onFriendApplicationAccepted(channel.data));
        break;
      case ListenerType.onFriendApplicationAdded:
        OpenIMManager._onEvent((listener) => listener.onFriendApplicationAdded(channel.data));
        break;
      case ListenerType.onFriendApplicationDeleted:
        OpenIMManager._onEvent((listener) => listener.onFriendApplicationDeleted(channel.data));
        break;
      case ListenerType.onFriendApplicationRejected:
        OpenIMManager._onEvent((listener) => listener.onFriendApplicationRejected(channel.data));
        break;
      case ListenerType.onFriendInfoChanged:
        OpenIMManager._onEvent((listener) => listener.onFriendInfoChanged(channel.data));
        break;
      case ListenerType.onFriendAdded:
        OpenIMManager._onEvent((listener) => listener.onFriendAdded(channel.data));
        break;
      case ListenerType.onFriendDeleted:
        OpenIMManager._onEvent((listener) => listener.onFriendDeleted(channel.data));
        break;

      case ListenerType.onInvitationCancelled:
        OpenIMManager._onEvent((listener) => listener.onInvitationCancelled(channel.data));
        break;
      case ListenerType.onInvitationTimeout:
        OpenIMManager._onEvent((listener) => listener.onInvitationTimeout(channel.data));
        break;
      case ListenerType.onInviteeAccepted:
        OpenIMManager._onEvent((listener) => listener.onInviteeAccepted(channel.data));
        break;
      case ListenerType.onInviteeRejected:
        OpenIMManager._onEvent((listener) => listener.onInviteeRejected(channel.data));
        break;
      case ListenerType.onReceiveNewInvitation:
        OpenIMManager._onEvent((listener) => listener.onReceiveNewInvitation(channel.data));
        break;
      case ListenerType.onInviteeAcceptedByOtherDevice:
        OpenIMManager._onEvent((listener) => listener.onInviteeAcceptedByOtherDevice(channel.data));
        break;
      case ListenerType.onInviteeRejectedByOtherDevice:
        OpenIMManager._onEvent((listener) => listener.onInviteeRejectedByOtherDevice(channel.data));
        break;
      case ListenerType.onHangUp:
        OpenIMManager._onEvent((listener) => listener.onHangup(channel.data));
        break;
      case ListenerType.onRoomParticipantConnected:
        OpenIMManager._onEvent((listener) => listener.onRoomParticipantConnected(channel.data));
        break;
      case ListenerType.onRoomParticipantDisconnected:
        OpenIMManager._onEvent((listener) => listener.onRoomParticipantDisconnected(channel.data));
        break;
      // case ListenerType.onStreamChange:
      //   OpenIMManager._onEvent((listener) => listener.onStreamChangedEvent(channel.data));
      //   break;
      // case ListenerType.onReceiveCustomSignal:
      //   OpenIMManager._onEvent((listener) => listener.onReceiveCustomSignal(channel.data));
      //   break;

      // case ListenerType.onRecvNewNotification:
      //   OpenIMManager._onEvent((listener) => listener.onRecvNewNotification());
      //   break;
      // case ListenerType.onOrganizationUpdated:
      //   OpenIMManager._onEvent((listener) => listener.onOrganizationUpdated());
      //   break;
      case ListenerType.onRecvCustomBusinessMessage:
        OpenIMManager._onEvent((listener) => listener.onRecvCustomBusinessMessage(channel.data));
        break;
      case ListenerType.onMessageKvInfoChanged:
        OpenIMManager._onEvent((listener) => listener.onMessageKvInfoChanged(channel.data));
        break;

      /// UploadFileListener
      case ListenerType.open:
        OpenIMManager._onEvent((listener) => listener.onUploadFileOpen(channel.operationID!, channel.data['size']));
        break;
      case ListenerType.partSize:
        OpenIMManager._onEvent(
            (listener) => listener.onUploadFilePartSize(channel.operationID!, channel.data['partSize'], channel.data['num']));
        break;
      case ListenerType.hashPartProgress:
        OpenIMManager._onEvent((listener) => listener.onUploadFileHashPartProgress(
            channel.operationID!, channel.data['index'], channel.data['size'], channel.data['partHash']));
        break;
      case ListenerType.hashPartComplete:
        OpenIMManager._onEvent(
            (listener) => listener.onUploadFileHashPartComplete(channel.operationID!, channel.data['partsHash'], channel.data['fileHash']));
        break;
      case ListenerType.uploadID:
        OpenIMManager._onEvent((listener) => listener.onUploadFileID(channel.operationID!, channel.data));
        break;
      case ListenerType.uploadPartComplete:
        OpenIMManager._onEvent((listener) => listener.onUploadFilePartComplete(
            channel.operationID!, channel.data['index'], channel.data['partSize'], channel.data['partHash']));
        break;
      case ListenerType.uploadComplete:
        OpenIMManager._onEvent((listener) => listener.onUploadFileProgress(
            channel.operationID!, channel.data['fileSize'], channel.data['streamSize'], channel.data['storageSize']));
        break;
      case ListenerType.complete:
        OpenIMManager._onEvent((listener) =>
            listener.onUploadFileComplete(channel.operationID!, channel.data['size'], channel.data['url'], channel.data['typ']));
        break;
    }
  }

  /// 反初始化SDK
  // Future<void> unInitSDK() async {
  //   ReceivePort receivePort = ReceivePort();

  //   OpenIMManager._openIMSendPort.send(_PortModel(
  //     method: _PortMethod.unInitSDK,
  //     sendPort: receivePort.sendPort,
  //   ));
  //   _PortResult result = await receivePort.first;
  //   if (result.error != null) {
  //     throw OpenIMError(result.errCode!, result.data!, methodName: result.callMethodName);
  //   }
  //   receivePort.close();
  // }

  /// 登录
  /// [uid] 用户id
  /// [token] 登录token，从业务服务器上获取
  /// [defaultValue] 获取失败后使用的默认值
  Future<UserInfo> login({
    required String uid,
    required String token,
    String? operationID,
    Future<UserInfo> Function()? defaultValue,
  }) async {
    isLogined = true;
    this.uid = uid;
    this.token = token;
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.login,
      data: {'operationID': IMUtils.checkOperationID(operationID), 'uid': uid, 'token': token},
      sendPort: receivePort.sendPort,
    ));
    await receivePort.first;
    receivePort.close();

    try {
      return uInfo = await userManager.getSelfUserInfo();
    } catch (error, stackTrace) {
      log('login e: $error  s: $stackTrace');
      if (null != defaultValue) {
        return uInfo = await (defaultValue.call());
      }
      return Future.error(error, stackTrace);
    }
  }

  /// 登出
  Future<void> logout({String? operationID}) async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.logout,
      data: {'operationID': IMUtils.checkOperationID(operationID)},
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;
    receivePort.close();

    return result.value;
  }

  /// 获取登录状态
  Future<int?> getLoginStatus() async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.getLoginStatus,
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;
    receivePort.close();

    return result.value;
  }

  /// 获取当前登录用户id
  Future<String> getLoginUserID() async => uid;

  /// 获取当前登录用户信息
  Future<UserInfo> getLoginUserInfo() async => uInfo;

  /// 从后台回到前台立刻唤醒
  Future wakeUp({String? operationID}) async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.wakeUp,
      data: {'operationID': IMUtils.checkOperationID(operationID)},
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;

    receivePort.close();
    if (result.error != null) {
      throw OpenIMError(result.errCode!, result.data!, methodName: result.callMethodName);
    }
  }

  /// 上传文件到服务器
  ///
  ///[id] 区分是哪个文件的回调
  Future<void> uploadFile({
    required String operationID,
    required String filePath,
    required String fileName,
    String? contentType,
    String? cause,
  }) async {
    ReceivePort receivePort = ReceivePort();
    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.uploadFile,
      data: {
        'filePath': filePath,
        'name': fileName,
        'contentType': contentType ?? '',
        'cause': cause,
        'operationID': IMUtils.checkOperationID(operationID),
      },
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;
    receivePort.close();
    if (result.error != null) {
      throw OpenIMError(result.errCode!, result.error!, methodName: result.callMethodName);
    }
  }

  /// 更新firebase客户端注册token
  /// [fcmToken] firebase token
  Future<void> updateFcmToken({
    required String fcmToken,
    String? operationID,
  }) async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.updateFcmToken,
      data: {
        'operationID': IMUtils.checkOperationID(operationID),
        'fcmToken': fcmToken,
      },
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;

    receivePort.close();
    if (result.error != null) {
      throw OpenIMError(result.errCode!, result.data!, methodName: result.callMethodName);
    }
  }

  /// 标记app处于后台
  Future<void> setAppBackgroundStatus({
    required bool isBackground,
    String? operationID,
  }) async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.setAppBackgroundStatus,
      data: {
        'operationID': IMUtils.checkOperationID(operationID),
        'isBackground': isBackground,
      },
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;

    receivePort.close();
    if (result.error != null) {
      throw OpenIMError(result.errCode!, result.data!, methodName: result.callMethodName);
    }
  }

  /// 网络改变
  Future<void> networkChanged({
    String? operationID,
  }) async {
    ReceivePort receivePort = ReceivePort();

    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.networkStatusChanged,
      data: {
        'operationID': IMUtils.checkOperationID(operationID),
      },
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;

    receivePort.close();
    if (result.error != null) {
      throw OpenIMError(result.errCode!, result.data!, methodName: result.callMethodName);
    }
  }

  /// 设置角标
  Future<void> setAppBadge(int unreadCount, {String? operationID}) async {
    ReceivePort receivePort = ReceivePort();
    OpenIMManager._openIMSendPort.send(_PortModel(
      method: _PortMethod.setAppBadge,
      data: {
        'operationID': IMUtils.checkOperationID(operationID),
        'unreadCount': unreadCount,
      },
      sendPort: receivePort.sendPort,
    ));
    _PortResult result = await receivePort.first;

    receivePort.close();
    if (result.error != null) {
      throw OpenIMError(result.errCode!, result.data!, methodName: result.callMethodName);
    }
  }
}
