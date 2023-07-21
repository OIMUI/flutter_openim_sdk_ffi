
public class GroupMembersInfo {
    /// 群id
    var groupID: String?
    
    /// 用户id
    var userID: String?
    
    /// 群内昵称
    var nickname: String?
    
    /// 头像
    var faceURL: String?
    
    /// 群角色
    var roleLevel = 0
    
    /// 入群时间
    var joinTime: Int64 = 0
    
    /// 加入方式 2：邀请加入 3：搜索加入 4：通过二维码加入
    var joinSource = 0
    
    /// 操作者id
    var operatorUserID: String?
    
    /// 扩展字段
    var ex: String?
    
    /// 禁言结束时间
    var muteEndTime: Int64 = 0
    
    /// 邀请人id
    var inviterUserID: String?
}
