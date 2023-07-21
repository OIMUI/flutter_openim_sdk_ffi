package io.openim.flutter_openim_sdk_ffi.models

class SearchResultItem {
    /**
     * 会话ID
     */
    var conversationID: String? = null

    /**
     * 这个会话下的消息数量
     */
    var messageCount = 0

    /**
     * 显示名
     */
    var showName: String? = null

    /**
     * 头像
     */
    var faceURL: String? = null

    /**
     * Message的列表
     */
    var messageList: List<Message>? = null
}