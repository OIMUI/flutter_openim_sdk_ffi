package io.openim.flutter_openim_sdk_ffi.models

class AttachedInfoElem {
    /**
     * 组信息已读详细
     */
    var groupHasReadInfo: GroupHasReadInfo? = null

    /**
     * 是否是私聊消息（阅后即焚消息）
     */
    var isPrivateChat = false

    /**
     * 消息已读时间
     */
    var hasReadTime: Long = 0

    /**
     * 阅读时长 s
     * 即从hasReadTime时间算起，超过了burnDuration秒触发销毁
     */
    var burnDuration = 0
}