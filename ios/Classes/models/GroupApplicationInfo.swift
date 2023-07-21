
public class GroupApplicationInfo {
    /// 群id
    var groupID: String?
    
    /// 群名
    var groupName: String?
    
    /// 群公告
    var notification: String?
    
    /// 群简介
    var introduction: String?
    
    /// 群头像
    var groupFaceURL: String?
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 状态
    var status = 0
    
    /// 创建者id
    var creatorUserID: String?
    
    /// 群类型
    var groupType = 0
    
    /// 拥有者id
    var ownerUserID: String?
    
    /// 成员数量
    var memberCount = 0
    
    /// 申请者的id
    var userID: String?
    
    /// 申请者的昵称
    var nickname: String?
    
    /// 申请者的头像
    var userFaceURL: String?
    
    /// 申请者的性别
    var gender = 0
    
    /// REFUSE = -1, AGREE = 1
    /// -1：拒绝，1：同意
    var handleResult = 0
    
    /// 申请原因
    var reqMsg: String?
    
    /// 处理结果描述
    var handledMsg: String?
    
    /// 申请时间
    var reqTime: Int64 = 0
    
    /// 处理者的id
    var handleUserID: String?
    
    /// 处理时间
    var handledTime: Int64 = 0
    
    /// 扩展字段
    var ex: String?
    
    /// 2：通过邀请  3：通过搜索  4：通过二维码
    var joinSource = 0
    
    /// 邀请进群用户ID
    var inviterUserID: String?
}
