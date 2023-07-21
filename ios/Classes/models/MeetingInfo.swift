

public class MeetingInfo {
    /// 会议ID
    var meetingID: String?
    
    /// 会议名称
    var meetingName: String?
    
    /// 主持人用户ID
    var hostUserID: String?
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 开始时间
    var startTime: Int64 = 0
    
    /// 结束时间
    var endTime: Int64 = 0
    
    /// 参与者是否能够启用视频
    var isParticipantCanEnableVideo = false
    
    /// 是否只有主持人邀请用户
    var isOnlyHostInviteUser = false
    
    /// 参与者是否可以加入时关闭视频
    var isJoinDisableVideo = false
    
    /// 参与者是否可以解除自身静音
    var isParticipantCanUnmuteSelf = false
    
    /// 是否静音所有麦克风
    var isMuteAllMicrophone = false
    
    /// 邀请的用户ID列表
    var inviteeUserIDList: [String]?
}
