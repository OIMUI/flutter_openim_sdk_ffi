package io.openim.flutter_openim_sdk_ffi.listener

/**
 * api接口回调
 */
interface OnBase<T> {
    /**
     * 失败
     */
    fun onError(code: Int, error: String)

    /**
     * 成功
     */
    fun onSuccess(data: T)
}