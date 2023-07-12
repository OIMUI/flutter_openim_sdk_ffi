package io.openim.flutter_openim_sdk_ffi.models

import java.util.Objects

class UserInfo {
    /**
     * 用户id
     */
    private var userID: String? = null

    /**
     * 用户名
     */
    var nickname: String? = null
        get() {
            if (null == field) {
                if (isFriendship) {
                    return friendInfo!!.nickname
                } else if (isBlacklist) {
                    return blackInfo!!.nickname
                } else if (null != publicInfo) {
                    return publicInfo!!.nickname
                }
            }
            return field
        }

    /**
     * 用户头像
     */
    var faceURL: String? = null
        get() {
            if (null == field) {
                if (isFriendship) {
                    return friendInfo!!.faceURL
                } else if (isBlacklist) {
                    return blackInfo!!.faceURL
                } else if (null != publicInfo) {
                    return publicInfo!!.faceURL
                }
            }
            return field
        }

    /**
     * 性别：1男，2女
     */
    var gender = 0
        get() {
            if (isFriendship) {
                return friendInfo!!.gender
            } else if (isBlacklist) {
                return blackInfo!!.gender
            } else if (null != publicInfo) {
                return publicInfo!!.gender
            }
            return field
        }

    /**
     * 手机号
     */
    var phoneNumber: String? = null
        get() {
            if (null == field) {
                if (isFriendship) {
                    return friendInfo!!.phoneNumber
                }
            }
            return field
        }

    /**
     * 生日
     */
    var birth: Long = 0
        get() = if (isFriendship) {
            friendInfo!!.birth
        } else field
    var birthTime: String? = null

    /**
     * 邮箱
     */
    var email: String? = null
        get() {
            if (null == field) {
                if (isFriendship) {
                    return friendInfo!!.email
                }
            }
            return field
        }

    /**
     * 扩展字段
     */
    var ex: String? = null
        get() {
            if (null == field) {
                if (isFriendship) {
                    return friendInfo!!.ex
                } else if (isBlacklist) {
                    return blackInfo!!.ex
                }
            }
            return field
        }

    /**
     * 备注
     */
    var remark: String? = null
        get() {
            if (null == field) {
                if (isFriendship) {
                    return friendInfo!!.remark
                }
            }
            return field
        }

    /**
     * 公开的信息
     */
    var publicInfo: PublicUserInfo? = null

    /**
     * 仅好友可见的信息
     */
    var friendInfo: FriendInfo? = null

    /**
     * 黑名单信息
     */
    var blackInfo: BlacklistInfo? = null

    /**
     * 全局免打扰
     */
    var globalRecvMsgOpt = 0
    fun getUserID(): String? {
        if (null == userID) {
            if (isFriendship) {
                return friendInfo!!.userID
            } else if (isBlacklist) {
                return blackInfo!!.userID
            } else if (null != publicInfo) {
                return publicInfo!!.userID
            }
        }
        return userID
    }

    fun setUserID(userID: String?) {
        this.userID = userID
    }

    /**
     * true：黑名单
     */
    val isBlacklist: Boolean
        get() = null != blackInfo

    /**
     * true：是好友
     */
    val isFriendship: Boolean
        get() = null != friendInfo

    override fun equals(o: Any?): Boolean {
        if (this === o) return true
        if (o !is UserInfo) return false
        return userID == o.userID
    }

    override fun hashCode(): Int {
        return Objects.hash(userID)
    }
}