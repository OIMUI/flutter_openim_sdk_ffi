public class PublicUserInfo: Decodable {
    /**
     * 用户id
     */
    var userID: String?
    
    /**
     * 昵称
     */
    var nickname: String?
    
    /**
     * 头像
     */
    var faceURL: String?
    
    /**
     * 性别
     */
    var gender = 0
    
    /**
     *
     */
    var appMangerLevel = 0
    
    /**
     * 扩展字段
     */
    var ex: String?
}
