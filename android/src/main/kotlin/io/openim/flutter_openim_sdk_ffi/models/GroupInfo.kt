package io.openim.flutter_openim_sdk_ffi.models

import java.util.Objects

class GroupInfo {
    /**
     * 组ID
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
    var faceURL: String? = null

    /**
     * 群主id
     */
    var ownerUserID: String? = null

    /**
     * 创建时间
     */
    var createTime: Long = 0

    /**
     * 群成员数量
     */
    var memberCount = 0

    /**
     * 群状态： ok = 0 blocked = 1 Dismissed = 2 Muted  = 3
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
     * 扩展字段
     */
    var ex: String? = null

    /**
     * 进群验证方式 [io.openim.android.sdk.enums.GroupVerification]
     */
    var needVerification = 0

    /**
     * 不允许通过群获取成员资料 0：关闭，1：打开
     */
    var lookMemberInfo = 0

    /**
     * 不允许通过群添加好友 0：关闭，1：打开
     */
    var applyMemberFriend = 0

    /**
     * 通知更新时间
     */
    var notificationUpdateTime: Long = 0

    /**
     * 通知更新人
     */
    var notificationUserID: String? = null
    override fun equals(o: Any?): Boolean {
        if (this === o) return true
        if (o !is GroupInfo) return false
        return groupID == o.groupID
    }

    override fun hashCode(): Int {
        return Objects.hash(groupID)
    }
}