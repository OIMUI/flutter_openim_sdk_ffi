package io.openim.flutter_openim_sdk_ffi.models

class GroupApplicationInfo {
    /**
     * 群id
     */
    var groupID: String? = null

    /**
     * 群名
     */
    var groupName: String? = null

    /**
     * 群公告
     */
    var notification: String? = null

    /**
     * 群简介
     */
    var introduction: String? = null

    /**
     * 群头像
     */
    var groupFaceURL: String? = null

    /**
     * 创建时间
     */
    var createTime: Long = 0

    /**
     * 状态
     */
    var status = 0

    /**
     * 创建者id
     */
    var creatorUserID: String? = null

    /**
     * 群类型
     */
    var groupType = 0

    /**
     * 拥有者id
     */
    var ownerUserID: String? = null

    /**
     * 成员数量
     */
    var memberCount = 0

    /**
     * 申请者的id
     */
    var userID: String? = null

    /**
     * 申请者的昵称
     */
    var nickname: String? = null

    /**
     * 申请者的头像
     */
    var userFaceURL: String? = null

    /**
     * 申请者的性别
     */
    var gender = 0

    /**
     * REFUSE = -1, AGREE = 1
     * -1：拒绝，1：同意
     */
    var handleResult = 0

    /**
     * 申请原因
     */
    var reqMsg: String? = null

    /**
     * 处理结果描述
     */
    var handledMsg: String? = null

    /**
     * 申请时间
     */
    var reqTime: Long = 0

    /**
     * 处理者的id
     */
    var handleUserID: String? = null

    /**
     * 处理时间
     */
    var handledTime: Long = 0

    /**
     * 扩展字段
     */
    var ex: String? = null

    /**
     * 2：通过邀请  3：通过搜索  4：通过二维码
     */
    var joinSource = 0

    /**
     * 邀请进群用户ID
     */
    var inviterUserID: String? = null
}