

/**
 * 黑名单详细
 */
public class BlacklistInfo: Decodable {
    /// 用户id
    var userID: String?
    
    /// 昵称
    var nickname: String?
    
    /// 头像
    var faceURL: String?
    
    /// 性别
    var gender = 0
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 添加方式
    var addSource = 0
    
    /// 操作者
    var operatorUserID: String?
    
    /// 附加信息
    var ex: String?
}
