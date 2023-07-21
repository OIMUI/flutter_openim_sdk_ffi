

/**
 * 会话监听
 */
protocol OnConversationListener {
    /**
     * 会话列表有数据更新
     * 可刷新会话列表
     */
    func onConversationChanged(list: [ConversationInfo])

    /**
     * 新增会话
     * 可刷新会话列表
     */
    func onNewConversation(list: [ConversationInfo])

    /**
     *
     */
    func onSyncServerFailed()

    /**
     *
     */
    func onSyncServerFinish()

    /**
     *
     */
    func onSyncServerStart()

    /**
     * 未读消息总数改变
     */
    func onTotalUnreadMessageCountChanged(count: Int)
}
