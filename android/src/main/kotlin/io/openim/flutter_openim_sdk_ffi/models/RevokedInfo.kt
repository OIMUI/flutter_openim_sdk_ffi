package io.openim.flutter_openim_sdk_ffi.models

class RevokedInfo {
    /**
     * 撤回者ID
     */
    var revokerID: String? = null

    /**
     * 撤回者群角色 [io.openim.android.sdk.enums.GroupRole]
     */
    var revokerRole = 0

    /**
     * 撤回者昵称
     */
    var revokerNickname: String? = null

    /**
     * 消息id
     */
    var clientMsgID: String? = null

    /**
     * 撤回时间
     */
    var revokeTime: Long = 0

    /**
     * 消息发送时间
     */
    var sourceMessageSendTime: Long = 0

    /**
     * 消息发送者
     */
    var sourceMessageSendID: String? = null

    /**
     * 消息发送者昵称
     */
    var sourceMessageSenderNickname: String? = null

    /**
     * 会话类型 [io.openim.android.sdk.enums.ConversationType]
     */
    var sessionType = 0
}