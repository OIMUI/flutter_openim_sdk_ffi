

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
    
    /**
     * 连接服务器失败
     * 可以提示用户当前网络连接不可用
     */
    @objc func onConnectFailed(code: Int64, error: String)
    
    /**
     * 已经成功连接到服务器
     */
    @objc func onConnectSuccess()
    
    /**
     * 正在连接到服务器
     * 适合在 UI 上展示“正在连接”状态。
     */
    @objc func onConnecting()
    
    /**
     * 当前用户被踢下线
     * 此时可以 UI 提示用户“您已经在其他端登录了当前账号，是否重新登录？”
     */
    @objc func onKickedOffline()
    
    /**
     * 登录票据已经过期
     * 请使用新签发的 UserSig 进行登录。
     */
    @objc func onUserTokenExpired()

    /**
     * sdk初始化成功
     */
    @objc func onInit()
}
