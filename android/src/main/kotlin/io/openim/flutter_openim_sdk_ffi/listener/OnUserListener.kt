package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.UserInfo

interface OnUserListener {
    /**
     * 当前用户的资料发生了更新
     * 可以在 UI 上更新自己的头像和昵称。
     */
    fun onSelfInfoUpdated(info: UserInfo?)
}