package io.openim.flutter_openim_sdk_ffi.models

class FriendApplicationInfo {
    /**
     * 请求用户id
     */
    var fromUserID: String? = null

    /**
     * 请求用户昵称
     */
    var fromNickname: String? = null

    /**
     * 请求用户头像
     */
    var fromFaceURL: String? = null

    /**
     * 请求用户性别
     */
    var fromGender = 0

    /**
     * 接受用户id
     */
    var toUserID: String? = null

    /**
     * 接受用户昵称
     */
    var toNickname: String? = null

    /**
     * 接受用户头像
     */
    var toFaceURL: String? = null

    /**
     * 接受用户性别
     */
    var toGender = 0

    /**
     * 处理结果 0 等待处理，1 已同意， 2 已拒绝
     */
    var handleResult = 0

    /**
     * 请求备注
     */
    var reqMsg: String? = null

    /**
     * 创建时间
     */
    var createTime: Long = 0

    /**
     * 处理者id
     */
    var handlerUserID: String? = null

    /**
     * 处理备注
     */
    var handleMsg: String? = null

    /**
     * 处理时间
     */
    var handleTime: Long = 0

    /**
     * 扩展字段
     */
    var ex: String? = null
}