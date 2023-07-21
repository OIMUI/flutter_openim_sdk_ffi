
protocol OnAdvanceMsgListener {
    /**
     * 收到新消息
     * 需要添加到列表，然后刷新界面
     */
    func onRecvNewMessage(msg: Message?)

    /**
     * 对方已阅读消息回执
     * 需更新界面已读状态
     */
    func onRecvC2CReadReceipt(list: [ReadReceiptInfo])

    /**
     * 群成员已阅读消息回执
     * 需更新界面已读状态
     */
    func onRecvGroupMessageReadReceipt(list: [ReadReceiptInfo])

    /**
     * 对方撤回了消息
     * 需要将消息类型更改为MessageType.REVOKE，然后刷新界面
     */
    @available(*, deprecated)
    func onRecvMessageRevoked(msgId: String)

    /**
     * 对方撤回了消息
     * 单聊撤回，群聊撤回以及群组管理员撤回其他人消息
     * 新版本只会通过此回调回传被撤回的详细信息，不会触发onRecvNewMessage回调
     */
    func onRecvMessageRevokedV2(info: RevokedInfo)
    func onRecvMessageExtensionsChanged(msgID: String, list: [KeyValue])
    func onRecvMessageExtensionsDeleted(msgID: String, list: [String])
    func onRecvMessageExtensionsAdded(msgID: String, list: [KeyValue])
}
