

public class SignalingInvitationInfo {
    /**
     * 邀请者UserID
     */
    var inviterUserID: String? 

    /**
     * 被邀请者UserID列表，如果是单聊只有一个元素
     */
    var inviteeUserIDList: [String]?

    /**
     * 如果是单聊，为""
     */
    var groupID: String? 

    /**
     * 房间ID，必须唯一，可以不设置。
     */
    var roomID: String? 

    /**
     * 邀请超时时间（秒）
     */
    var timeout: Int64 = 0

    /**
     * 发起时间（秒）
     */
    var initiateTime: Int64 = 0

    /**
     * video 或者audio
     */
    var mediaType: String? 

    /**
     * 1为单聊，2为群聊
     */
    var sessionType = 0

    /**
     * 和之前定义一致
     */
    var platformID = 0
    var customData: String? 
}
