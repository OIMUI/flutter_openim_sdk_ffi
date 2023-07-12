package io.openim.flutter_openim_sdk_ffi.models

/**
 * 部门信息
 */
class DeptInfo {
    /**
     * 部门id
     */
    var departmentID: String? = null

    /**
     * 头像
     */
    var faceURL: String? = null

    /**
     * 名称
     */
    var name: String? = null

    /**
     * 上一级id
     */
    var parentID: String? = null

    /**
     * 排序
     */
    var order = 0

    /**
     * 部门类型
     */
    var departmentType = 0

    /**
     * 创建时间
     */
    var createTime: Long = 0

    /**
     * 子部门数量
     */
    var subDepartmentNum = 0

    /**
     * 成员数量
     */
    var memberNum = 0

    /**
     * 附加字段
     */
    var ex: String? = null

    /**
     * 附加信息
     */
    var attachedInfo: String? = null
    var relatedGroupID: String? = null
}