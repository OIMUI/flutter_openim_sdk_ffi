package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.KeyValue
import io.openim.flutter_openim_sdk_ffi.models.Message
import io.openim.flutter_openim_sdk_ffi.models.ReadReceiptInfo
import io.openim.flutter_openim_sdk_ffi.models.RevokedInfo

/**
 * 消息监听
 */
interface OnAdvanceMsgListener {
    /**
     * 收到新消息
     * 需要添加到列表，然后刷新界面
     */
    fun onRecvNewMessage(msg: Message?)

    /**
     * 对方已阅读消息回执
     * 需更新界面已读状态
     */
    fun onRecvC2CReadReceipt(list: List<ReadReceiptInfo>)

    /**
     * 群成员已阅读消息回执
     * 需更新界面已读状态
     */
    fun onRecvGroupMessageReadReceipt(list: List<ReadReceiptInfo>)

    /**
     * 对方撤回了消息
     * 需要将消息类型更改为MessageType.REVOKE，然后刷新界面
     */
    @Deprecated("")
    fun onRecvMessageRevoked(msgId: String)

    /**
     * 对方撤回了消息
     * 单聊撤回，群聊测回以及群组管理员撤回其他人消息
     * 新版本只会通过此回调回传被撤回的详细信息，不会触发onRecvNewMessage回调
     */
    fun onRecvMessageRevokedV2(info: RevokedInfo)
    fun onRecvMessageExtensionsChanged(msgID: String, list: List<KeyValue>)
    fun onRecvMessageExtensionsDeleted(msgID: String, list: List<String>)
    fun onRecvMessageExtensionsAdded(msgID: String, list: List<KeyValue>)
}