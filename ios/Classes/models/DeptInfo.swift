

/**
 * 部门信息
 */
public class DeptInfo {
    /// 部门id
    var departmentID: String?
    
    /// 头像
    var faceURL: String?
    
    /// 名称
    var name: String?
    
    /// 上一级id
    var parentID: String?
    
    /// 排序
    var order = 0
    
    /// 部门类型
    var departmentType = 0
    
    /// 创建时间
    var createTime: Int64 = 0
    
    /// 子部门数量
    var subDepartmentNum = 0
    
    /// 成员数量
    var memberNum = 0
    
    /// 附加字段
    var ex: String?
    
    /// 附加信息
    var attachedInfo: String?
    
    /// Related Group ID
    var relatedGroupID: String?
}
