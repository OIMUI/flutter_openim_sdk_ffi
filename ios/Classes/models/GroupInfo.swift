
public class GroupInfo: Equatable {
    /// 组ID
    var groupID: String?
    
    /// 群名
    var groupName: String?
    
    /// 群公告
    var notification: String?
    
    /// 群简介
    var introduction: String?
    
    /// 群头像
    var faceURL: String?
    
    /// 群主id
    var ownerUserID: String?
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 群成员数量
    var memberCount = 0
    
    /// 群状态： ok = 0 blocked = 1 Dismissed = 2 Muted  = 3
    var status = 0
    
    /// 创建者id
    var creatorUserID: String?
    
    /// 群类型
    var groupType = 0
    
    /// 扩展字段
    var ex: String?
    
    /// 进群验证方式 [io.openim.android.sdk.enums.GroupVerification]
    var needVerification = 0
    
    /// 不允许通过群获取成员资料 0：关闭，1：打开
    var lookMemberInfo = 0
    
    /// 不允许通过群添加好友 0：关闭，1：打开
    var applyMemberFriend = 0
    
    /// 通知更新时间
    var notificationUpdateTime: Int64 = 0
    
    /// 通知更新人
    var notificationUserID: String?
    
    public static func == (lhs: GroupInfo, rhs: GroupInfo) -> Bool {
        return lhs.groupID == rhs.groupID
    }
}
