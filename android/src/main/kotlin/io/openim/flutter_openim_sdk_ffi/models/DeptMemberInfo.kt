package io.openim.flutter_openim_sdk_ffi.models

/**
 * 部门成员
 */
class DeptMemberInfo {
    /**
     * 成员id
     */
    var userID: String? = null

    /**
     * 昵称
     */
    var nickname: String? = null

    /**
     * 英文名
     */
    var englishName: String? = null

    /**
     * 头像
     */
    var faceURL: String? = null

    /**
     * 性别
     */
    var gender = 0

    /**
     * 移动电话
     */
    var mobile: String? = null

    /**
     * 座机
     */
    var telephone: String? = null

    /**
     * 出生日期
     */
    var birth: Long = 0

    /**
     * 邮箱
     */
    var email: String? = null

    /**
     * 部门id
     */
    var departmentID: String? = null

    /**
     * 排序
     */
    var order = 0

    /**
     * 职位
     */
    var position: String? = null

    /**
     * 领导
     */
    var leader = 0

    /**
     * 状态
     */
    var status = 0

    /**
     * 创建时间
     */
    var createTime: Long = 0

    /**
     * 入职时间
     */
    var entryTime: Long = 0

    /**
     * 离职时间
     */
    var terminationTime: Long = 0

    /**
     * 附加字段
     */
    var ex: String? = null

    /**
     * 附加信息
     */
    var attachedInfo: String? = null

    /**
     * 部门信息
     */
    var department: DeptMemberInfo? = null
}