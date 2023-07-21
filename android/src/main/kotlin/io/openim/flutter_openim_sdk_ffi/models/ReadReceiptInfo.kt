package io.openim.flutter_openim_sdk_ffi.models

class ReadReceiptInfo {
    /**
     * 用户id
     */
    var userID: String? = null

    /**
     * 组id
     */
    var groupID: String? = null

    /**
     * 已读消息id
     */
    var msgIDList: List<String>? = null

    /**
     * 阅读时间
     */
    var readTime: Long = 0

    /**
     * 标识消息是用户级别还是系统级别 100:用户 200:系统
     */
    var msgFrom = 0

    /**
     * [io.openim.android.sdk.enums.MessageType]
     * 消息类型：
     * 101:文本消息
     * 102:图片消息
     * 103:语音消息
     * 104:视频消息
     * 105:文件消息
     * 106:@消息
     * 107:合并消息
     * 108:转发消息
     * 109:位置消息
     * 110:自定义消息
     * 111:撤回消息回执
     * 112:C2C已读回执
     * 113:正在输入状态
     */
    var contentType = 0

    /**
     * [io.openim.android.sdk.enums.ConversationType]
     * 会话类型 1:单聊 2:群聊
     */
    var sessionType = 0
}