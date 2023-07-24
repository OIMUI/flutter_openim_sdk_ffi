part of flutter_openim_sdk_ffi;

class ConversationInfo {
  /// 会话ID
  String conversationID;

  /// 会话类型[ConversationType]
  int? conversationType;

  /// 参与会话的userID
  String? userID;

  /// 参与会话的groupID
  String? groupID;

  /// 昵称
  String? showName;

  /// 头像
  String? faceURL;

  /// 免打扰 0：正常；1：不接受消息；2：接受在线消息不接受离线消息；
  int? recvMsgOpt;

  /// 未读消息数
  int? unreadCount;

  /// 强制提示，[GroupAtType]包含@所有人，@个人以及公告提示
  int? groupAtType;

  /// 会话最新消息内容
  Message? latestMsg;

  /// 最新消息发送时间
  int? latestMsgSendTime;

  /// 草稿
  String? draftText;

  /// 草稿生成时间
  int? draftTextTime;

  /// 是否置顶
  bool? isPinned;

  /// 是否开启了私聊（阅后即焚）
  bool? isPrivateChat;

  /// 可阅读期限 s
  int? burnDuration;

  /// 是否开启定期销毁
  bool? isMsgDestruct;

  /// 定期销毁时间 s
  int? msgDestructTime;

  /// 附加内容
  String? ex;

  /// 是否还在组内，如果退群返回true
  bool? isNotInGroup;

  ConversationInfo({
    required this.conversationID,
    this.conversationType,
    this.userID,
    this.groupID,
    this.showName,
    this.faceURL,
    this.recvMsgOpt,
    this.unreadCount,
    this.latestMsg,
    this.latestMsgSendTime,
    this.draftText,
    this.draftTextTime,
    this.isPrivateChat,
    this.burnDuration,
    this.isPinned,
    this.isNotInGroup,
    this.ex,
    this.groupAtType,
    this.isMsgDestruct,
    this.msgDestructTime,
  });

  ConversationInfo.fromJson(Map<String, dynamic> json) : conversationID = json['conversationID'] {
    conversationType = json['conversationType'];
    userID = json['userID'];
    groupID = json['groupID'];
    showName = json['showName'];
    faceURL = json['faceURL'];
    recvMsgOpt = json['recvMsgOpt'];
    unreadCount = json['unreadCount'];
    try {
      if (json['latestMsg'] is String) {
        latestMsg = Message.fromJson(jsonDecode(json['latestMsg']));
      } else if (json['latestMsg'] is Map) {
        latestMsg = Message.fromJson(json['latestMsg']);
      }
    } catch (e) {
      debugPrint('latestMsg error: $e');
    }
    latestMsgSendTime = json['latestMsgSendTime'];
    draftText = json['draftText'];
    draftTextTime = json['draftTextTime'];
    isPinned = json['isPinned'];
    isPrivateChat = json['isPrivateChat'];
    burnDuration = json['burnDuration'];
    isNotInGroup = json['isNotInGroup'];
    groupAtType = json['groupAtType'];
    ex = json['ex'];
    isMsgDestruct = json['isMsgDestruct'];
    msgDestructTime = json['msgDestructTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['conversationID'] = conversationID;
    data['conversationType'] = conversationType;
    data['userID'] = userID;
    data['groupID'] = groupID;
    data['showName'] = showName;
    data['faceURL'] = faceURL;
    data['recvMsgOpt'] = recvMsgOpt;
    data['unreadCount'] = unreadCount;
    data['latestMsg'] = latestMsg?.toJson();
    data['latestMsgSendTime'] = latestMsgSendTime;
    data['draftText'] = draftText;
    data['draftTextTime'] = draftTextTime;
    data['isPinned'] = isPinned;
    data['isPrivateChat'] = isPrivateChat;
    data['burnDuration'] = burnDuration;
    data['isNotInGroup'] = isNotInGroup;
    data['groupAtType'] = groupAtType;
    data['ex'] = ex;
    data['isMsgDestruct'] = isMsgDestruct;
    data['msgDestructTime'] = msgDestructTime;
    return data;
  }

  /// 是单聊
  bool get isSingleChat => conversationType == ConversationType.single;

  /// 是群聊
  bool get isGroupChat => conversationType == ConversationType.group || conversationType == ConversationType.superGroup;

  /// 是有效的
  bool get isValid => isSingleChat || isGroupChat && !isNotInGroup!;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ConversationInfo && runtimeType == other.runtimeType && conversationID == other.conversationID;

  @override
  int get hashCode => conversationID.hashCode;
}
