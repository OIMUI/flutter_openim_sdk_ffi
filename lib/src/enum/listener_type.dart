part of flutter_openim_sdk_ffi;

/// callback类型
class ListenerType {
  /// OnConnListener
  static const String onConnecting = 'OnConnecting';
  static const String onConnectSuccess = 'OnConnectSuccess';
  static const String onConnectFailed = 'OnConnectFailed';
  static const String onKickedOffline = 'OnKickedOffline';
  static const String onUserTokenExpired = 'OnUserTokenExpired';

  /// SendMsgCallBack
  static const String onProgress = 'OnProgress';

  /// OnUserListener
  static const String onSelfInfoUpdated = 'OnSelfInfoUpdated';

  /// OnGroupListener
  static const String onJoinedGroupAdded = 'OnJoinedGroupAdded';
  static const String onJoinedGroupDeleted = 'OnJoinedGroupDeleted';
  static const String onGroupMemberAdded = 'OnGroupMemberAdded';
  static const String onGroupMemberDeleted = 'OnGroupMemberDeleted';
  static const String onGroupApplicationAdded = 'OnGroupApplicationAdded';
  static const String onGroupApplicationDeleted = 'OnGroupApplicationDeleted';
  static const String onGroupInfoChanged = 'OnGroupInfoChanged';
  static const String onGroupDismissed = 'OnGroupDismissed';
  static const String onGroupMemberInfoChanged = 'OnGroupMemberInfoChanged';
  static const String onGroupApplicationAccepted = 'OnGroupApplicationAccepted';
  static const String onGroupApplicationRejected = 'OnGroupApplicationRejected';

  /// OnFriendshipListener
  static const String onFriendApplicationAdded = 'OnFriendApplicationAdded';
  static const String onFriendApplicationDeleted = 'OnFriendApplicationDeleted';
  static const String onFriendApplicationAccepted = 'OnFriendApplicationAccepted';
  static const String onFriendApplicationRejected = 'OnFriendApplicationRejected';
  static const String onFriendAdded = 'OnFriendAdded';
  static const String onFriendDeleted = 'OnFriendDeleted';
  static const String onFriendInfoChanged = 'OnFriendInfoChanged';
  static const String onBlackAdded = 'OnBlackAdded';
  static const String onBlackDeleted = 'OnBlackDeleted';

  /// OnConversationListener
  static const String onSyncServerStart = 'OnSyncServerStart';
  static const String onSyncServerFinish = 'OnSyncServerFinish';
  static const String onSyncServerFailed = 'OnSyncServerFailed';
  static const String onNewConversation = 'OnNewConversation';
  static const String onConversationChanged = 'OnConversationChanged';
  static const String onTotalUnreadMessageCountChanged = 'OnTotalUnreadMessageCountChanged';

  /// OnAdvancedMsgListener
  static const String onRecvNewMessage = 'OnRecvNewMessage';
  static const String onRecvC2CReadReceipt = 'OnRecvC2CReadReceipt';
  static const String onRecvGroupReadReceipt = 'OnRecvGroupReadReceipt';
  static const String onNewRecvMessageRevoked = 'OnNewRecvMessageRevoked';
  static const String onRecvMessageExtensionsChanged = 'OnRecvMessageExtensionsChanged';
  static const String onRecvMessageExtensionsDeleted = 'OnRecvMessageExtensionsDeleted';
  static const String onRecvMessageExtensionsAdded = 'OnRecvMessageExtensionsAdded';
  static const String onRecvOfflineNewMessage = 'OnRecvOfflineNewMessage';
  static const String onMsgDeleted = 'OnMsgDeleted';

  /// OnBatchMsgListener
  static const String onRecvNewMessages = 'OnRecvNewMessages';
  static const String onRecvOfflineNewMessages = 'OnRecvOfflineNewMessages';

  /// OnCustomBusinessListener
  static const String onRecvCustomBusinessMessage = 'OnRecvCustomBusinessMessage';

  /// OnMessageKvInfoListener
  static const String onMessageKvInfoChanged = 'OnMessageKvInfoChanged';

  /// OnListenerForService
  // static const String onGroupApplicationAdded = 'OnGroupApplicationAdded';
  // static const String onGroupApplicationAccepted = 'OnGroupApplicationAccepted';
  // static const String onFriendApplicationAdded = 'OnFriendApplicationAdded';
  // static const String onFriendApplicationAccepted = 'OnFriendApplicationAccepted';
  // static const String onRecvNewMessage = 'OnRecvNewMessage';

  /// OnSignalingListener
  static const String onReceiveNewInvitation = 'OnReceiveNewInvitation';
  static const String onInviteeAccepted = 'OnInviteeAccepted';
  static const String onInviteeAcceptedByOtherDevice = 'OnInviteeAcceptedByOtherDevice';
  static const String onInviteeRejected = 'OnInviteeRejected';
  static const String onInviteeRejectedByOtherDevice = 'OnInviteeRejectedByOtherDevice';
  static const String onInvitationCancelled = 'OnInvitationCancelled';
  static const String onInvitationTimeout = 'OnInvitationTimeout';
  static const String onHangUp = 'OnHangUp';
  static const String onRoomParticipantConnected = 'OnRoomParticipantConnected';
  static const String onRoomParticipantDisconnected = 'OnRoomParticipantDisconnected';

  /// UploadFileListener
  static const String open = 'Open';
  static const String partSize = 'PartSize';
  static const String hashPartProgress = 'HashPartProgress';
  static const String hashPartComplete = 'HashPartComplete';
  static const String uploadID = 'UploadID';
  static const String uploadPartComplete = 'UploadPartComplete';
  static const String uploadComplete = 'UploadComplete';
  static const String complete = 'Complete';
}
