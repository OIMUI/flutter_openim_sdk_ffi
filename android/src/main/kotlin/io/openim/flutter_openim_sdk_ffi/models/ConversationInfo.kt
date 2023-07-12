package io.openim.flutter_openim_sdk_ffi.models

import java.util.Objects

class ConversationInfo {
    /**
     * 会话id
     */
    var conversationID: String? = null

    /**
     * 会话类型 1:单聊 2:群聊
     */
    var conversationType = 0

    /**
     * 会话对象用户ID
     */
    var userID: String? = null

    /**
     * 会话群聊ID
     */
    var groupID: String? = null

    /**
     * 会话对象(用户或群聊)名称
     */
    var showName: String? = null

    /**
     * 用户头像或群聊头像
     */
    var faceURL: String? = null

    /**
     * 接收消息选项：<br></br>
     * 0:在线正常接收消息，离线时进行推送 <br></br>
     * 1:不会接收到消息<br></br>
     * 2:在线正常接收消息，离线不会有推送
     */
    var recvMsgOpt = 0

    /**
     * 未读消息数量
     */
    var unreadCount = 0

    /**
     * 强提示 如at消息，公告 [io.openim.android.sdk.enums.GroupAtType]
     */
    var groupAtType = 0

    /**
     * 最后一条消息 消息对象json字符串
     */
    var latestMsg: String? = null

    /**
     * 最后一条消息发送时间(ms)
     */
    var latestMsgSendTime: Long = 0

    /**
     * 会话草稿
     */
    var draftText: String? = null

    /**
     * 会话草稿设置时间
     */
    var draftTextTime: Long = 0

    /**
     * 是否置顶，1置顶
     */
    var isPinned = false

    /**
     * 是否开启私聊
     */
    var isPrivateChat = false

    /**
     * 扩展预留字段
     */
    var ext: String? = null

    /**
     * 扩展预留字段
     */
    var ex: String? = null

    /**
     * 是否还在群里
     */
    var isNotInGroup = false

    /**
     * 阅读时长 s，即超过了burnDuration秒触发销毁
     */
    var burnDuration = 0
    override fun equals(o: Any?): Boolean {
        if (this === o) return true
        if (o !is ConversationInfo) return false
        return conversationID == o.conversationID
    }

    override fun hashCode(): Int {
        return Objects.hash(conversationID)
    }
}