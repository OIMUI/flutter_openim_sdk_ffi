package io.openim.flutter_openim_sdk_ffi.models

import java.util.Objects

/**
 * 好友信息
 */
class FriendInfo {
    /**
     * 好友id
     */
    var userID: String? = null

    /**
     * 好友昵称
     */
    var nickname: String? = null

    /**
     * 好友头像
     */
    var faceURL: String? = null

    /**
     * 性别
     */
    var gender = 0

    /**
     * 手机号
     */
    var phoneNumber: String? = null

    /**
     * 出生日期
     */
    var birth: Long = 0

    /**
     * 邮箱
     */
    var email: String? = null

    /**
     * 好友备注名
     */
    var remark: String? = null

    /**
     * 扩展字段
     */
    var ex: String? = null

    /**
     * 创建时间
     */
    var createTime: Long = 0

    /**
     * 添加方式
     */
    var addSource = 0

    /**
     * 操作者id
     */
    var operatorUserID: String? = null
    override fun equals(o: Any?): Boolean {
        if (this === o) return true
        if (o !is FriendInfo) return false
        return userID == o.userID
    }

    override fun hashCode(): Int {
        return Objects.hash(userID)
    }
}