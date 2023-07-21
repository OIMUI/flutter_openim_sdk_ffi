import Foundation

public class RevokedInfo {
    /**
     * 撤回者ID
     */
    var revokerID: String?

    /**
     * 撤回者群角色 [io.openim.android.sdk.enums.GroupRole]
     */
    var revokerRole: Int = 0

    /**
     * 撤回者昵称
     */
    var revokerNickname: String?

    /**
     * 消息id
     */
    var clientMsgID: String?

    /**
     * 撤回时间
     */
    var revokeTime: Int64 = 0

    /**
     * 消息发送时间
     */
    var sourceMessageSendTime: Int64 = 0

    /**
     * 消息发送者
     */
    var sourceMessageSendID: String?

    /**
     * 消息发送者昵称
     */
    var sourceMessageSenderNickname: String?

    /**
     * 会话类型 [io.openim.android.sdk.enums.ConversationType]
     */
    var sessionType: Int = 0
}
