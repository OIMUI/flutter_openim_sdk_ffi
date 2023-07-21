package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.listener.OnBase

/**
 * 消息发送监听
 */
interface OnFileUploadProgressListener : OnBase<String> {
    /**
     * 上传失败
     */
    override fun onError(code: Int, error: String)

    /**
     * 上传进度
     */
    fun onProgress(progress: Long)

    /**
     * 上传成功
     */
    override fun onSuccess(s: String)
}