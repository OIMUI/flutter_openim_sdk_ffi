package io.openim.android.sdk.listener

import io.openim.flutter_openim_sdk_ffi.models.GroupApplicationInfo
import io.openim.flutter_openim_sdk_ffi.models.GroupInfo
import io.openim.flutter_openim_sdk_ffi.models.GroupMembersInfo


/**
 * 群组监听
 */
interface OnGroupListener {
    fun onGroupApplicationAccepted(info: GroupApplicationInfo)
    fun onGroupApplicationAdded(info: GroupApplicationInfo)
    fun onGroupApplicationDeleted(info: GroupApplicationInfo)
    fun onGroupApplicationRejected(info: GroupApplicationInfo)
    fun onGroupInfoChanged(info: GroupInfo)
    fun onGroupMemberAdded(info: GroupMembersInfo)
    fun onGroupMemberDeleted(info: GroupMembersInfo)
    fun onGroupMemberInfoChanged(info: GroupMembersInfo)
    fun onJoinedGroupAdded(info: GroupInfo)
    fun onJoinedGroupDeleted(info: GroupInfo)
}