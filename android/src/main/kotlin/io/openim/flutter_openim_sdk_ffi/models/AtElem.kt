package io.openim.flutter_openim_sdk_ffi.models

class AtElem {
    /**
     * at 消息内容
     */
    var text: String? = null

    /**
     * 被@的用户id集合
     */
    var atUserList: List<String>? = null

    /**
     * 自己是否被@了
     */
    var isAtSelf = false
}