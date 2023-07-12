package io.openim.flutter_openim_sdk_ffi.models

class GroupMembersInfo {
    /**
     * 群id
     */
    var groupID: String? = null

    /**
     * 用户id
     */
    var userID: String? = null

    /**
     * 群内昵称
     */
    var nickname: String? = null

    /**
     * 头像
     */
    var faceURL: String? = null

    /**
     * 群角色
     */
    var roleLevel = 0

    /**
     * 入群时间
     */
    var joinTime: Long = 0

    /**
     * 加入方式 2：邀请加入 3：搜索加入 4：通过二维码加入
     */
    var joinSource = 0

    /**
     * 操作者id
     */
    var operatorUserID: String? = null

    /**
     * 扩展字段
     */
    var ex: String? = null

    /**
     * 禁言结束时间
     */
    var muteEndTime: Long = 0

    /**
     * 邀请人id
     */
    var inviterUserID: String? = null
}