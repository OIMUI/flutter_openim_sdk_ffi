package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.BlacklistInfo
import io.openim.flutter_openim_sdk_ffi.models.FriendApplicationInfo
import io.openim.flutter_openim_sdk_ffi.models.FriendInfo

/**
 * 好友关系监听
 */
interface OnFriendshipListener {
    fun onBlacklistAdded(u: BlacklistInfo)
    fun onBlacklistDeleted(u: BlacklistInfo)
    fun onFriendApplicationAccepted(u: FriendApplicationInfo)
    fun onFriendApplicationAdded(u: FriendApplicationInfo)
    fun onFriendApplicationDeleted(u: FriendApplicationInfo)
    fun onFriendApplicationRejected(u: FriendApplicationInfo)
    fun onFriendInfoChanged(u: FriendInfo)
    fun onFriendAdded(u: FriendInfo)
    fun onFriendDeleted(u: FriendInfo)
}