

/**
 * 会话监听
 */
@objc public protocol OnConversationListener {
//    /**
//     * 会话列表有数据更新
//     * 可刷新会话列表
//     */
//    @objc func onConversationChanged(list: [ConversationInfo])
//
//    /**
//     * 新增会话
//     * 可刷新会话列表
//     */
//    @objc func onNewConversation(list: [ConversationInfo])

    /**
     *
     */
    @objc func onSyncServerFailed()

    /**
     *
     */
    @objc func onSyncServerFinish()

    /**
     *
     */
    @objc func onSyncServerStart()

    /**
     * 未读消息总数改变
     */
    @objc func onTotalUnreadMessageCountChanged(count: Int)
}
