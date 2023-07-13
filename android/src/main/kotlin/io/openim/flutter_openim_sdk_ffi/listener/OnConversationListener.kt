package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.ConversationInfo

/**
 * 会话监听
 */
interface OnConversationListener {
    /**
     * 会话列表有数据更新
     * 可刷新会话列表
     */
    fun onConversationChanged(list: List<ConversationInfo>)

    /**
     * 新增会话
     * 可刷新会话列表
     */
    fun onNewConversation(list: List<ConversationInfo>)

    /**
     *
     */
    fun onSyncServerFailed()

    /**
     *
     */
    fun onSyncServerFinish()

    /**
     *
     */
    fun onSyncServerStart()

    /**
     * 未读消息总数改变
     */
    fun onTotalUnreadMessageCountChanged(i: Int)
}