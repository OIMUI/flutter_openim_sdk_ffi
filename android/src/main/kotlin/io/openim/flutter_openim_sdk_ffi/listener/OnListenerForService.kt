package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.FriendApplicationInfo
import io.openim.flutter_openim_sdk_ffi.models.GroupApplicationInfo
import io.openim.flutter_openim_sdk_ffi.models.Message

interface OnListenerForService {
    fun onFriendApplicationAccepted(u: FriendApplicationInfo?)
    fun onFriendApplicationAdded(u: FriendApplicationInfo?)
    fun onGroupApplicationAccepted(info: GroupApplicationInfo?)
    fun onGroupApplicationAdded(info: GroupApplicationInfo?)
    fun onRecvNewMessage(msg: Message?)
}