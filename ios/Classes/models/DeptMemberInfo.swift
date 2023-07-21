

/**
 * 部门成员
 */
public class DeptMemberInfo {
    /// 成员id
    var userID: String?
    
    /// 昵称
    var nickname: String?
    
    /// 英文名
    var englishName: String?
    
    /// 头像
    var faceURL: String?
    
    /// 性别
    var gender = 0
    
    /// 移动电话
    var mobile: String?
    
    /// 座机
    var telephone: String?
    
    /// 出生日期
    var birth: Int64 = 0
    
    /// 邮箱
    var email: String?
    
    /// 部门id
    var departmentID: String?
    
    /// 排序
    var order = 0
    
    /// 职位
    var position: String?
    
    /// 领导
    var leader = 0
    
    /// 状态
    var status = 0
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 入职时间
    var entryTime: Int64 = 0
    
    /// 离职时间
    var terminationTime: Int64 = 0
    
    /// 附加字段
    var ex: String?
    
    /// 附加信息
    var attachedInfo: String?
    
    /// 部门信息
    var department: DeptMemberInfo?
}
