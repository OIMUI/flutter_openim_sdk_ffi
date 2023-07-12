package io.openim.flutter_openim_sdk_ffi.models

class GroupMemberRole {
    /**
     * 成员id
     */
    var userID: String? = null

    /**
     * 1普通成员, 2群主，3管理员 [io.openim.android.sdk.enums.GroupRole]
     */
    var roleLevel = 0
}