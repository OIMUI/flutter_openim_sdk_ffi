package io.openim.flutter_openim_sdk_ffi.models

class PublicUserInfo {
    /**
     * 用户id
     */
    var userID: String? = null

    /**
     * 昵称
     */
    var nickname: String? = null

    /**
     * 头像
     */
    var faceURL: String? = null

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
    var ex: String? = null
}