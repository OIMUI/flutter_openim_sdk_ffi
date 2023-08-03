part of flutter_openim_sdk_ffi;

class _PortResult<T> {
  final T? data;

  final String? error;

  final int? errCode;

  final String? callMethodName;

  _PortResult({
    this.data,
    this.error,
    this.errCode,
    this.callMethodName,
  });

  T get value {
    if (error != null) {
      throw OpenIMError(errCode!, error!, methodName: callMethodName);
    }
    return data!;
  }
}

class _PortModel {
  final String method;

  dynamic data;

  final SendPort? sendPort;

  final dynamic errCode;

  final String? operationID;

  final String? callMethodName;

  _PortModel({
    required this.method,
    this.data,
    this.sendPort,
    this.errCode,
    this.operationID,
    this.callMethodName,
  });

  factory _PortModel.fromJson(Map<String, dynamic> json) => _PortModel(
        method: json['method'] as String,
        data: json['data'],
        errCode: json['errCode'],
        operationID: json['operationID'] as String?,
        callMethodName: json['callMethodName'] as String?,
      );

  toJson() => {
        'method': method,
        'data': data,
        'errCode': errCode,
        'operationID': operationID,
        'callMethodName': callMethodName,
      };
}

class _IsolateTaskData<T> {
  final SendPort sendPort;

  RootIsolateToken? rootIsolateToken;

  final T data;

  _IsolateTaskData(this.sendPort, this.data, this.rootIsolateToken);
}

class InitSdkParams {
  final String apiAddr;
  final String wsAddr;
  final String? dataDir;

  final int logLevel;
  final String objectStorage;

  final String? operationID;

  final bool isLogStandardOutput;
  final String? logFilePath;
  final bool isExternalExtensions;

  InitSdkParams({
    required this.apiAddr,
    required this.wsAddr,
    required this.logLevel,
    this.objectStorage = 'cos',
    this.dataDir,
    this.operationID,
    this.isLogStandardOutput = true,
    this.logFilePath,
    this.isExternalExtensions = false,
  });
}

class OpenIMManager {
  static bool _isInit = false;

  /// 主进程通信端口
  static final ReceivePort _receivePort = ReceivePort();

  /// openIm 通信端口
  static late final SendPort _openIMSendPort;

  /// 通信存储
  static final Map<String, SendPort> _sendPortMap = {};

  static int getIMPlatform() {
    if (kIsWeb) {
      return IMPlatform.web;
    }
    if (Platform.isAndroid) {
      return IMPlatform.android;
    }
    if (Platform.isIOS) {
      return IMPlatform.ios;
    }
    if (Platform.isWindows) {
      return IMPlatform.windows;
    }
    if (Platform.isMacOS) {
      return IMPlatform.xos;
    }
    if (Platform.isLinux) {
      return IMPlatform.linux;
    }
    return IMPlatform.ipad;
  }

  static Future<void> _isolateEntry(_IsolateTaskData<InitSdkParams> task) async {
    if (task.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(task.rootIsolateToken!);
    }
    try {
      final receivePort = ReceivePort();
      task.sendPort.send(receivePort.sendPort);

      _bindings.setPrintCallback(ffi.Pointer.fromFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>(_printMessage));

      InitSdkParams data = task.data;
      String? dataDir = data.dataDir;
      if (dataDir == null) {
        Directory document = await getApplicationDocumentsDirectory();
        dataDir = document.path;
      }
      String config = jsonEncode({
        'platformID': getIMPlatform(),
        'apiAddr': data.apiAddr,
        'wsAddr': data.wsAddr,
        'dataDir': dataDir,
        'logLevel': data.logLevel,
        "objectStorage": data.objectStorage,
        'LogFilePath': data.logFilePath,
        'isLogStandardOutput': data.isLogStandardOutput,
        'isExternalExtensions': data.isExternalExtensions,
      });

      bool status = _imBindings.InitSDK(
        IMUtils.checkOperationID(data.operationID).toNativeUtf8().cast<ffi.Char>(),
        config.toNativeUtf8().cast<ffi.Char>(),
      );

      _bindings.ffi_Dart_RegisterCallback(_imDylib.handle, receivePort.sendPort.nativePort);
      if (status) {
        _bindings.ffi_Dart_InitSDK();
      }
      task.sendPort.send(_PortModel(method: _PortMethod.initSDK, data: status));

      receivePort.listen((msg) {
        if (msg is String) {
          _PortModel data = _PortModel.fromJson(jsonDecode(msg));

          switch (data.method) {
            case 'OnError':
              NativeCall.onError(data);
              break;
            case 'OnSuccess':
              NativeCall.onSuccess(data);
              break;
            case ListenerType.onConversationChanged:
            case ListenerType.onNewConversation:
              data.data = IMUtils.toList(data.data, (map) => ConversationInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onRecvNewMessage:
              data.data = IMUtils.toObj(data.data, (map) => Message.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onSelfInfoUpdated:
              data.data = IMUtils.toObj(data.data, (map) => UserInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onGroupApplicationAccepted:
            case ListenerType.onGroupApplicationAdded:
            case ListenerType.onGroupApplicationDeleted:
            case ListenerType.onGroupApplicationRejected:
              data.data = IMUtils.toObj(data.data, (map) => GroupApplicationInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onGroupInfoChanged:
            case ListenerType.onJoinedGroupAdded:
            case ListenerType.onJoinedGroupDeleted:
              data.data = IMUtils.toObj(data.data, (map) => GroupInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onGroupMemberAdded:
            case ListenerType.onGroupMemberDeleted:
            case ListenerType.onGroupMemberInfoChanged:
              data.data = IMUtils.toObj(data.data, (map) => GroupMembersInfo.fromJson(map));
              task.sendPort.send(data);
              break;

            case ListenerType.onFriendAdded:
            case ListenerType.onFriendDeleted:
            case ListenerType.onFriendInfoChanged:
              data.data = IMUtils.toObj(data.data, (map) => FriendInfo.fromJson(map));
              break;
            case ListenerType.onFriendApplicationAccepted:
            case ListenerType.onFriendApplicationAdded:
            case ListenerType.onFriendApplicationDeleted:
            case ListenerType.onFriendApplicationRejected:
              data.data = IMUtils.toObj(data.data, (map) => FriendApplicationInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            // case ListenerType.onRecvC2CMessageReadReceipt:
            // case ListenerType.onRecvGroupMessageReadReceipt:
            //   data.data = IMUtils.toList(data.data, (map) => ReadReceiptInfo.fromJson(map));
            //   break;
            // case ListenerType.onRecvMessageRevokedV2:
            //   data.data = IMUtils.toObj(data.data, (map) => RevokedInfo.fromJson(map));
            //   task.sendPort.send(data);
            //   break;
            case ListenerType.onRecvMessageExtensionsChanged:
            case ListenerType.onRecvMessageExtensionsAdded:
              data.data = IMUtils.toList(data.data, (map) => KeyValue.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onRecvMessageExtensionsDeleted:
              data.data = IMUtils.toList(data.data, (map) => map);
              task.sendPort.send(data);
              break;

            case ListenerType.onInvitationCancelled:
            case ListenerType.onInvitationTimeout:
            case ListenerType.onInviteeAccepted:
            case ListenerType.onInviteeRejected:
            case ListenerType.onReceiveNewInvitation:
            case ListenerType.onInviteeAcceptedByOtherDevice:
            case ListenerType.onInviteeRejectedByOtherDevice:
            case ListenerType.onHangUp:
              data.data = IMUtils.toList(data.data, (map) => SignalingInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onRoomParticipantConnected:
            case ListenerType.onRoomParticipantDisconnected:
              data.data = IMUtils.toObj(data.data, (map) => RoomCallingInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            // case ListenerType.onMeetingStreamChanged:
            //   data.data = IMUtils.toObj(data.data, (map) => MeetingStreamEvent.fromJson(map));
            //   task.sendPort.send(data);
            //   break;
            // case ListenerType.onReceiveCustomSignal:
            //   data.data = IMUtils.toObj(data.data, (map) => CustomSignaling.fromJson(map));
            //   task.sendPort.send(data);
            //   break;

            case ListenerType.onRecvC2CReadReceipt:
            case ListenerType.onRecvGroupReadReceipt:
              data.data = IMUtils.toList(data.data, (map) => ReadReceiptInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onNewRecvMessageRevoked:
              data.data = IMUtils.toObj(data.data, (map) => ReadReceiptInfo.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.onMessageKvInfoChanged:
              data.data = IMUtils.toList(data.data, (map) => MessageKv.fromJson(map));
              task.sendPort.send(data);
              break;
            case ListenerType.open:
            case ListenerType.partSize:
            case ListenerType.hashPartProgress:
            case ListenerType.hashPartComplete:
            case ListenerType.uploadPartComplete:
            case ListenerType.uploadComplete:
            case ListenerType.complete:
              data.data = jsonDecode(data.data);
              task.sendPort.send(data);
              break;
            default:
              task.sendPort.send(data);
          }
          return;
        }

        switch ((msg as _PortModel).method) {
          case _PortMethod.login:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            final token = (msg.data['token'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.Login(operationID, uid, token);
            calloc.free(operationID);
            calloc.free(uid);
            calloc.free(token);
            break;
          case _PortMethod.version:
            String version = _imBindings.GetSdkVersion().cast<Utf8>().toDartString();
            msg.sendPort?.send(_PortResult(data: version));
            break;
          case _PortMethod.getUsersInfo:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final uidList = (jsonEncode(msg.data['uidList'] as List<String>)).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetUsersInfo(operationID, uidList);
            calloc.free(operationID);
            calloc.free(uidList);
            break;
          case _PortMethod.getSelfUserInfo:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetSelfUserInfo(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.getAllConversationList:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetAllConversationList(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.getOneConversation:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final sourceID = (msg.data['sourceID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetOneConversation(operationID, msg.data['sessionType'], sourceID);
            calloc.free(operationID);
            calloc.free(sourceID);
            break;
          case _PortMethod.getConversationListSplit:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetConversationListSplit(operationID, msg.data['offset'], msg.data['count']);
            calloc.free(operationID);
            break;

          case _PortMethod.sendMessage:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final userID = (msg.data['userID'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupID = (msg.data['groupID'] as String).toNativeUtf8().cast<ffi.Char>();
            final offlinePushInfo = jsonEncode(msg.data['offlinePushInfo']).toNativeUtf8().cast<ffi.Char>();
            final clientMsgID = jsonEncode(msg.data['message']['clientMsgID']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SendMessage(operationID, message, userID, groupID, offlinePushInfo);
            calloc.free(operationID);
            calloc.free(message);
            calloc.free(userID);
            calloc.free(groupID);
            calloc.free(offlinePushInfo);
            calloc.free(clientMsgID);
          case _PortMethod.sendMessageNotOss:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final userID = (msg.data['userID'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupID = (msg.data['groupID'] as String).toNativeUtf8().cast<ffi.Char>();
            final offlinePushInfo = jsonEncode(msg.data['offlinePushInfo']).toNativeUtf8().cast<ffi.Char>();
            final clientMsgID = jsonEncode(msg.data['message']['clientMsgID']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SendMessageNotOss(operationID, message, userID, groupID, offlinePushInfo);
            calloc.free(operationID);
            calloc.free(message);
            calloc.free(userID);
            calloc.free(groupID);
            calloc.free(offlinePushInfo);
            calloc.free(clientMsgID);
            break;
          case _PortMethod.insertSingleMessageToLocalStorage:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final receiverID = (msg.data['receiverID'] as String).toNativeUtf8().cast<ffi.Char>();
            final senderID = (msg.data['senderID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.InsertSingleMessageToLocalStorage(operationID, message, receiverID, senderID);
            calloc.free(operationID);
            calloc.free(message);
            calloc.free(receiverID);
            calloc.free(senderID);
            break;
          case _PortMethod.insertGroupMessageToLocalStorage:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final groupID = (msg.data['groupID'] as String).toNativeUtf8().cast<ffi.Char>();
            final senderID = (msg.data['senderID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.InsertGroupMessageToLocalStorage(operationID, message, groupID, senderID);
            calloc.free(operationID);
            calloc.free(message);
            calloc.free(groupID);
            calloc.free(senderID);
            break;
          case _PortMethod.markMessageAsReadByMsgID:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final conversationID = (msg.data['conversationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final messageIDList = jsonEncode(msg.data['messageIDList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.MarkMessagesAsReadByMsgID(operationID, conversationID, messageIDList);
            calloc.free(operationID);
            calloc.free(conversationID);
            calloc.free(messageIDList);
            break;
          case _PortMethod.typingStatusUpdate:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final userID = (msg.data['userID'] as String).toNativeUtf8().cast<ffi.Char>();
            final msgTip = (msg.data['msgTip'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.TypingStatusUpdate(operationID, userID, msgTip);
            calloc.free(operationID);
            calloc.free(userID);
            calloc.free(msgTip);
            break;
          case _PortMethod.createTextMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final text = (msg.data['text'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateTextMessage(operationID, text);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(text);
            calloc.free(newMsg);
            break;
          case _PortMethod.createTextAtMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final text = (msg.data['text'] as String).toNativeUtf8().cast<ffi.Char>();
            final atUserList = jsonEncode(msg.data['atUserList']).toNativeUtf8().cast<ffi.Char>();
            final atUsersInfo = jsonEncode(msg.data['atUsersInfo']).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateTextAtMessage(operationID, text, atUserList, atUsersInfo, message);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(text);
            calloc.free(atUserList);
            calloc.free(atUsersInfo);
            calloc.free(message);
            calloc.free(newMsg);
            break;
          case _PortMethod.createImageMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final imagePath = (msg.data['imagePath'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateImageMessage(operationID, imagePath);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(imagePath);
            calloc.free(newMsg);
            break;
          case _PortMethod.createImageMessageFromFullPath:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final imagePath = (msg.data['imagePath'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateImageMessageFromFullPath(operationID, imagePath);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(imagePath);
            calloc.free(newMsg);
            break;
          case _PortMethod.createSoundMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final soundPath = (msg.data['soundPath'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateSoundMessage(operationID, soundPath, msg.data['duration']);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(soundPath);
            calloc.free(newMsg);
            break;
          case _PortMethod.createSoundMessageFromFullPath:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final soundPath = (msg.data['soundPath'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateSoundMessageFromFullPath(operationID, soundPath, msg.data['duration']);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(soundPath);
            calloc.free(newMsg);
            break;
          case _PortMethod.createVideoMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final videoPath = (msg.data['videoPath'] as String).toNativeUtf8().cast<ffi.Char>();
            final videoType = (msg.data['videoType'] as String).toNativeUtf8().cast<ffi.Char>();
            final snapshotPath = (msg.data['snapshotPath'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateVideoMessage(operationID, videoPath, videoType, msg.data['duration'], snapshotPath);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(videoPath);
            calloc.free(videoType);
            calloc.free(snapshotPath);
            calloc.free(newMsg);
            break;
          case _PortMethod.createVideoMessageFromFullPath:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final videoPath = (msg.data['videoPath'] as String).toNativeUtf8().cast<ffi.Char>();
            final videoType = (msg.data['videoType'] as String).toNativeUtf8().cast<ffi.Char>();
            final snapshotPath = (msg.data['snapshotPath'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg =
                _imBindings.CreateVideoMessageFromFullPath(operationID, videoPath, videoType, msg.data['duration'], snapshotPath);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(videoPath);
            calloc.free(videoType);
            calloc.free(snapshotPath);
            calloc.free(newMsg);
            break;
          case _PortMethod.createFileMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final filePath = (msg.data['filePath'] as String).toNativeUtf8().cast<ffi.Char>();
            final fileName = (msg.data['fileName'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateFileMessage(operationID, filePath, fileName);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(filePath);
            calloc.free(fileName);
            calloc.free(newMsg);
            break;
          case _PortMethod.createFileMessageFromFullPath:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final filePath = (msg.data['filePath'] as String).toNativeUtf8().cast<ffi.Char>();
            final fileName = (msg.data['fileName'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateFileMessageFromFullPath(operationID, filePath, fileName);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(filePath);
            calloc.free(fileName);
            calloc.free(newMsg);
            break;
          case _PortMethod.createMergerMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final messageList = jsonEncode(msg.data['messageList']).toNativeUtf8().cast<ffi.Char>();
            final title = (msg.data['title'] as String).toNativeUtf8().cast<ffi.Char>();
            final summaryList = jsonEncode(msg.data['summaryList']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateMergerMessage(operationID, messageList, title, summaryList);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(messageList);
            calloc.free(title);
            calloc.free(summaryList);
            calloc.free(newMsg);
            break;
          case _PortMethod.createForwardMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateForwardMessage(operationID, message);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(message);
            calloc.free(newMsg);
            break;
          case _PortMethod.createLocationMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final description = (msg.data['description'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateLocationMessage(operationID, description, msg.data['longitude'], msg.data['latitude']);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(description);
            calloc.free(newMsg);
            break;
          case _PortMethod.createCustomMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final data = (msg.data['data'] as String).toNativeUtf8().cast<ffi.Char>();
            final extension = (msg.data['extension'] as String).toNativeUtf8().cast<ffi.Char>();
            final description = (msg.data['description'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateCustomMessage(operationID, data, extension, description);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(data);
            calloc.free(extension);
            calloc.free(description);
            calloc.free(newMsg);
            break;
          case _PortMethod.createQuoteMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final text = (msg.data['text'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateQuoteMessage(operationID, text, message);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(text);
            calloc.free(message);
            calloc.free(newMsg);
            break;
          case _PortMethod.createCardMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final data = jsonEncode(msg.data['data']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateCardMessage(operationID, data);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(data);
            calloc.free(newMsg);
            break;
          case _PortMethod.createFaceMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final data = (msg.data['data'] as String).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateFaceMessage(operationID, msg.data['index'], data);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(data);
            calloc.free(newMsg);
            break;
          case _PortMethod.searchLocalMessages:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final searchParam = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SearchLocalMessages(operationID, searchParam);
            calloc.free(operationID);
            calloc.free(searchParam);
            break;
          case _PortMethod.deleteAllMsgFromLocal:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.DeleteAllMsgFromLocal(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.deleteAllMsgFromLocalAndSvr:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.DeleteAllMsgFromLocalAndSvr(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.findMessageList:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final searchParams = jsonEncode(msg.data['searchParams']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.FindMessageList(operationID, searchParams);
            calloc.free(operationID);
            calloc.free(searchParams);
            break;
          case _PortMethod.createAdvancedTextMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final text = (msg.data['text'] as String).toNativeUtf8().cast<ffi.Char>();
            final messageEntityList = jsonEncode(msg.data['richMessageInfoList']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateAdvancedTextMessage(operationID, text, messageEntityList);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(text);
            calloc.free(messageEntityList);
            calloc.free(newMsg);
            break;
          case _PortMethod.createAdvancedQuoteMessage:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final text = (msg.data['text'] as String).toNativeUtf8().cast<ffi.Char>();
            final message = jsonEncode(msg.data['message']).toNativeUtf8().cast<ffi.Char>();
            final messageEntityList = jsonEncode(msg.data['richMessageInfoList']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateAdvancedQuoteMessage(operationID, text, message, messageEntityList);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(text);
            calloc.free(message);
            calloc.free(messageEntityList);
            calloc.free(newMsg);
            break;
          case _PortMethod.createImageMessageByURL:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final sourcePicture = jsonEncode(msg.data['sourcePicture']).toNativeUtf8().cast<ffi.Char>();
            final bigPicture = jsonEncode(msg.data['bigPicture']).toNativeUtf8().cast<ffi.Char>();
            final snapshotPicture = jsonEncode(msg.data['snapshotPicture']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateImageMessageByURL(operationID, sourcePicture, bigPicture, snapshotPicture);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(sourcePicture);
            calloc.free(bigPicture);
            calloc.free(snapshotPicture);
            break;
          case _PortMethod.createSoundMessageByURL:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final soundElem = jsonEncode(msg.data['soundElem']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateSoundMessageByURL(operationID, soundElem);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(soundElem);
            calloc.free(newMsg);
            break;
          case _PortMethod.createVideoMessageByURL:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final videoElem = jsonEncode(msg.data['videoElem']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateVideoMessageByURL(operationID, videoElem);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(videoElem);
            calloc.free(newMsg);
            break;
          case _PortMethod.createFileMessageByURL:
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final fileElem = jsonEncode(msg.data['fileElem']).toNativeUtf8().cast<ffi.Char>();
            final newMsg = _imBindings.CreateFileMessageByURL(operationID, fileElem);
            msg.sendPort?.send(_PortResult(data: IMUtils.toObj(newMsg.cast<Utf8>().toDartString(), (v) => Message.fromJson(v))));
            calloc.free(operationID);
            calloc.free(fileElem);
            calloc.free(newMsg);
            break;
          case _PortMethod.getAdvancedHistoryMessageList:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final getMessageOptions = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetAdvancedHistoryMessageList(operationID, getMessageOptions);
            calloc.free(operationID);
            calloc.free(getMessageOptions);
            break;
          case _PortMethod.getAdvancedHistoryMessageListReverse:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final getMessageOptions = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetAdvancedHistoryMessageListReverse(operationID, getMessageOptions);
            calloc.free(operationID);
            calloc.free(getMessageOptions);
            break;
          case _PortMethod.setConversationDraft:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final conversationID = (msg.data['conversationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final draftText = (msg.data['draftText'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetConversationDraft(operationID, conversationID, draftText);
            calloc.free(operationID);
            calloc.free(conversationID);
            calloc.free(draftText);
            break;
          case _PortMethod.pinConversation:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final conversationID = (msg.data['conversationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.PinConversation(operationID, conversationID, msg.data['isPinned']);
            calloc.free(operationID);
            calloc.free(conversationID);
            break;
          case _PortMethod.getTotalUnreadMsgCount:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetTotalUnreadMsgCount(operationID);
            calloc.free(operationID);
            break;

          case _PortMethod.setConversationRecvMessageOpt:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final conversationIDList = jsonEncode(msg.data['conversationIDList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetConversationRecvMessageOpt(operationID, conversationIDList, msg.data['status']);
            calloc.free(operationID);
            calloc.free(conversationIDList);
            break;
          case _PortMethod.getConversationRecvMessageOpt:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final conversationIDList = jsonEncode(msg.data['conversationIDList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetConversationRecvMessageOpt(operationID, conversationIDList);
            calloc.free(operationID);
            calloc.free(conversationIDList);
            break;

          case _PortMethod.deleteAllConversationFromLocal:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.DeleteAllConversationFromLocal(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.resetConversationGroupAtType:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final conversationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.ResetConversationGroupAtType(operationID, conversationID);
            calloc.free(operationID);
            calloc.free(conversationID);
            break;

          case _PortMethod.setGlobalRecvMessageOpt:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGlobalRecvMessageOpt(operationID, msg.data['status']);
            calloc.free(operationID);
            break;

          case _PortMethod.addFriend:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final userIDReqMsg = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.AddFriend(operationID, userIDReqMsg);
            calloc.free(operationID);
            calloc.free(userIDReqMsg);
            break;

          case _PortMethod.getFriendList:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetFriendList(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.setFriendRemark:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final ops = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetFriendRemark(operationID, ops);
            calloc.free(operationID);
            calloc.free(ops);
            break;
          case _PortMethod.addBlacklist:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.AddBlack(operationID, uid);
            calloc.free(operationID);
            calloc.free(uid);
            break;
          case _PortMethod.getBlacklist:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetBlackList(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.removeBlacklist:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.RemoveBlack(operationID, uid);
            calloc.free(operationID);
            calloc.free(uid);
            break;
          case _PortMethod.checkFriend:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final uidList = jsonEncode(msg.data['uidList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.CheckFriend(operationID, uidList);
            calloc.free(operationID);
            calloc.free(uidList);
            break;
          case _PortMethod.deleteFriend:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final uidList = jsonEncode(msg.data['uidList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.DeleteFriend(operationID, uidList);
            calloc.free(operationID);
            calloc.free(uidList);
            break;
          case _PortMethod.acceptFriendApplication:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final ops = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.AcceptFriendApplication(operationID, ops);
            calloc.free(operationID);
            calloc.free(ops);
            break;
          case _PortMethod.refuseFriendApplication:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final ops = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.RefuseFriendApplication(operationID, ops);
            calloc.free(operationID);
            calloc.free(ops);
            break;
          case _PortMethod.searchFriends:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final ops = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SearchFriends(operationID, ops);
            calloc.free(operationID);
            calloc.free(ops);
            break;

          // case _PortMethod.signalingUpdateMeetingInfo:
          //   final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
          //   final roomID = (msg.data['roomID'] as String).toNativeUtf8().cast<ffi.Char>();
          //   _imBindings.SignalingUpdateMeetingInfo(operationID, roomID);
          //   _sendPortMap[msg.data['operationID']] = msg.sendPort!;
          //   calloc.free(operationID);
          //   calloc.free(roomID);
          //   break;
          case _PortMethod.inviteUserToGroup:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupId = (msg.data['groupId'] as String).toNativeUtf8().cast<ffi.Char>();
            final reason = (msg.data['reason'] as String).toNativeUtf8().cast<ffi.Char>();
            final uidList = jsonEncode(msg.data['uidList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.InviteUserToGroup(operationID, groupId, reason, uidList);
            calloc.free(operationID);
            calloc.free(groupId);
            calloc.free(reason);
            calloc.free(uidList);
            break;
          case _PortMethod.kickGroupMember:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupId = (msg.data['groupId'] as String).toNativeUtf8().cast<ffi.Char>();
            final reason = (msg.data['reason'] as String).toNativeUtf8().cast<ffi.Char>();
            final uidList = jsonEncode(msg.data['uidList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.KickGroupMember(operationID, groupId, reason, uidList);
            calloc.free(operationID);
            calloc.free(groupId);
            calloc.free(reason);
            calloc.free(uidList);
            break;

          case _PortMethod.getGroupMemberList:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupId = (msg.data['groupId'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetGroupMemberList(operationID, groupId, msg.data['filter'], msg.data['offset'], msg.data['count']);
            calloc.free(operationID);
            calloc.free(groupId);
            break;
          case _PortMethod.getJoinedGroupList:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetJoinedGroupList(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.createGroup:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gInfo = jsonEncode(msg.data['gInfo']).toNativeUtf8().cast<ffi.Char>();
            final memberList = jsonEncode(msg.data['memberList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.CreateGroup(operationID, gInfo);
            calloc.free(operationID);
            calloc.free(gInfo);
            calloc.free(memberList);
            break;

          case _PortMethod.joinGroup:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final reason = (msg.data['reason'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.JoinGroup(operationID, gid, reason, msg.data['joinSource']);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(reason);
            break;
          case _PortMethod.quitGroup:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.QuitGroup(operationID, gid);
            calloc.free(operationID);
            calloc.free(gid);
            break;
          case _PortMethod.transferGroupOwner:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.TransferGroupOwner(operationID, gid, uid);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uid);
            break;

          case _PortMethod.acceptGroupApplication:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            final handleMsg = (msg.data['handleMsg'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.AcceptGroupApplication(operationID, gid, uid, handleMsg);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uid);
            calloc.free(handleMsg);
            break;
          case _PortMethod.refuseGroupApplication:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            final handleMsg = (msg.data['handleMsg'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.RefuseGroupApplication(operationID, gid, uid, handleMsg);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uid);
            calloc.free(handleMsg);
            break;
          case _PortMethod.dismissGroup:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.DismissGroup(operationID, gid);
            calloc.free(operationID);
            calloc.free(gid);
            break;
          case _PortMethod.changeGroupMute:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.ChangeGroupMute(operationID, gid, msg.data['mute']);
            calloc.free(operationID);
            calloc.free(gid);
            break;
          case _PortMethod.changeGroupMemberMute:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.ChangeGroupMemberMute(operationID, gid, uid, msg.data['seconds']);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uid);
            break;
          case _PortMethod.setGroupMemberNickname:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupNickname = (msg.data['groupNickname'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGroupMemberNickname(operationID, gid, uid, msg.data['groupNickname']);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uid);
            calloc.free(groupNickname);
            break;
          case _PortMethod.searchGroups:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final ops = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SearchGroups(operationID, ops);
            calloc.free(operationID);
            calloc.free(ops);
            break;
          case _PortMethod.setGroupMemberRoleLevel:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uid = (msg.data['uid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGroupMemberRoleLevel(operationID, gid, uid, msg.data['roleLevel']);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uid);
            break;
          case _PortMethod.getGroupMemberListByJoinTimeFilter:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            final uIds = jsonEncode(msg.data['excludeUserIDList']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetGroupMemberListByJoinTimeFilter(
                operationID, gid, msg.data['offset'], msg.data['count'], msg.data['joinTimeBegin'], msg.data['joinTimeEnd'], uIds);
            calloc.free(operationID);
            calloc.free(gid);
            calloc.free(uIds);
            break;
          case _PortMethod.setGroupVerification:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGroupVerification(operationID, gid, msg.data['needVerification']);
            calloc.free(operationID);
            calloc.free(gid);
            break;
          case _PortMethod.setGroupLookMemberInfo:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGroupLookMemberInfo(operationID, gid, msg.data['status']);
            calloc.free(operationID);
            calloc.free(gid);
            break;
          case _PortMethod.setGroupApplyMemberFriend:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGroupApplyMemberFriend(operationID, gid, msg.data['status']);
            calloc.free(operationID);
            calloc.free(gid);
            break;

          case _PortMethod.getGroupMemberOwnerAndAdmin:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final gid = (msg.data['gid'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.GetGroupMemberOwnerAndAdmin(operationID, gid);
            calloc.free(operationID);
            calloc.free(gid);
            break;
          case _PortMethod.searchGroupMembers:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final searchParam = jsonEncode(msg.data['searchParam']).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SearchGroupMembers(operationID, searchParam);
            calloc.free(operationID);
            calloc.free(searchParam);
            break;
          case _PortMethod.setGroupMemberInfo:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final groupMemberInfo = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetGroupMemberInfo(operationID, groupMemberInfo);
            calloc.free(operationID);
            calloc.free(groupMemberInfo);
            break;
          case _PortMethod.networkStatusChanged:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.NetworkStatusChanged(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.setAppBackgroundStatus:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetAppBackgroundStatus(operationID, msg.data['isBackground']);
            calloc.free(operationID);
            break;
          case _PortMethod.updateFcmToken:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final fcmToken = (msg.data['fcmToken'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.UpdateFcmToken(operationID, fcmToken);
            calloc.free(operationID);
            calloc.free(fcmToken);
            break;

          case _PortMethod.logout:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            _imBindings.Logout(operationID);
            calloc.free(operationID);
            break;
          case _PortMethod.uploadFile:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final req = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.UploadFile(operationID, req);
            calloc.free(operationID);
            calloc.free(req);
            break;
          case _PortMethod.setSelfInfo:
            _sendPortMap[msg.data['operationID']] = msg.sendPort!;
            final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
            final userInfo = jsonEncode(msg.data).toNativeUtf8().cast<ffi.Char>();
            _imBindings.SetSelfInfo(operationID, userInfo);
            calloc.free(operationID);
            calloc.free(userInfo);
            break;
          //  case _PortMethod.unInitSDK:
          // final operationID = (msg.data['operationID'] as String).toNativeUtf8().cast<ffi.Char>();
          // _imBindings.(operationID);
          // _sendPortMap[msg.data['operationID']] = msg.sendPort!;
          // calloc.free(operationID);
          // break;
        }
      });
    } catch (e) {
      Logger.print(e.toString());
    }
  }

  /// 初始化
  static Future<bool> init({
    required String apiAddr,
    required String wsAddr,
    String? dataDir,
    int logLevel = 6,
    String objectStorage = 'cos',
    String? operationID,
    bool isLogStandardOutput = false,
    String? logFilePath,
    bool isExternalExtensions = false,
  }) async {
    if (_isInit) return false;
    _isInit = true;
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    await Isolate.spawn(
        _isolateEntry,
        _IsolateTaskData<InitSdkParams>(
          _receivePort.sendPort,
          InitSdkParams(
            apiAddr: apiAddr,
            wsAddr: wsAddr,
            dataDir: dataDir,
            logLevel: logLevel,
            objectStorage: objectStorage,
            isLogStandardOutput: isLogStandardOutput,
            logFilePath: logFilePath,
            isExternalExtensions: isExternalExtensions,
          ),
          rootIsolateToken,
        ));

    _bindings.ffi_Dart_InitializeApiDL(ffi.NativeApi.initializeApiDLData);

    final completer = Completer();
    _receivePort.listen((msg) {
      if (msg is _PortModel) {
        _methodChannel(msg, completer);
        return;
      }
      if (msg is SendPort) {
        _openIMSendPort = msg;
        return;
      }
    });
    return await completer.future;
  }

  static void _methodChannel(_PortModel port, Completer completer) {
    switch (port.method) {
      case _PortMethod.initSDK:
        completer.complete(port.data);
        break;
      default:
        OpenIM.iMManager._nativeCallback(port);
    }
  }

  /// 事件触发
  static void _onEvent(Function(OpenIMListener) callback) {
    for (OpenIMListener listener in OpenIMManager.listeners) {
      if (!_listeners.contains(listener)) {
        return;
      }
      callback(listener);
    }
  }

  static final ObserverList<OpenIMListener> _listeners = ObserverList<OpenIMListener>();
  static List<OpenIMListener> get listeners {
    final List<OpenIMListener> localListeners = List<OpenIMListener>.from(_listeners);
    return localListeners;
  }

  static bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  static void addListener(OpenIMListener listener) {
    _listeners.add(listener);
  }

  static void removeListener(OpenIMListener listener) {
    _listeners.remove(listener);
  }

  static String get operationID => DateTime.now().millisecondsSinceEpoch.toString();
}
