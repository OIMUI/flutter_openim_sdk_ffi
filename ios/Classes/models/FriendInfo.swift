

/**
 * 好友信息
 */
public class FriendInfo: Decodable {
    /// 好友id
    var userID: String?
    
    /// 好友昵称
    var nickname: String?
    
    /// 好友头像
    var faceURL: String?
    
    /// 性别
    var gender: Int = 0
    
    /// 手机号
    var phoneNumber: String?
    
    /// 出生日期
    var birth: Int64 = 0
    
    /// 邮箱
    var email: String?
    
    /// 好友备注名
    var remark: String?
    
    /// 扩展字段
    var ex: String?
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 添加方式
    var addSource = 0
    
    /// 操作者id
    var operatorUserID: String?
    
    public static func == (lhs: FriendInfo, rhs: FriendInfo) -> Bool {
        return lhs.userID == rhs.userID
    }
}
