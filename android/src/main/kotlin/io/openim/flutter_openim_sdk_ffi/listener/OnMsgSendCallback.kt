package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.Message

/**
 * 消息发送监听
 */
interface OnMsgSendCallback : OnBase<Message> {
    /**
     * 发送失败
     */
    override fun onError(code: Int, error: String)

    /**
     * 上传进度
     */
    fun onProgress(progress: Long)

    /**
     * 发送成功
     */
    override fun onSuccess(data: Message)
}