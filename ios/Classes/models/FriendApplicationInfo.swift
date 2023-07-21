

public class FriendApplicationInfo {
    /// 请求用户id
    var fromUserID: String?
    
    /// 请求用户昵称
    var fromNickname: String?
    
    /// 请求用户头像
    var fromFaceURL: String?
    
    /// 请求用户性别
    var fromGender = 0
    
    /// 接受用户id
    var toUserID: String?
    
    /// 接受用户昵称
    var toNickname: String?
    
    /// 接受用户头像
    var toFaceURL: String?
    
    /// 接受用户性别
    var toGender = 0
    
    /// 处理结果 0 等待处理，1 已同意， 2 已拒绝
    var handleResult = 0
    
    /// 请求备注
    var reqMsg: String?
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 处理者id
    var handlerUserID: String?
    
    /// 处理备注
    var handleMsg: String?
    
    /// 处理时间
    var handleTime: Int64 = 0
    
    /// 扩展字段
    var ex: String?
}
