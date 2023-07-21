package io.openim.flutter_openim_sdk_ffi.models

class GroupHasReadInfo {
    /**
     * 已读的用户id列表
     */
    var hasReadUserIDList: List<String>? = null

    /**
     * 已读总数
     */
    var hasReadCount = 0

    /**
     * 发送此条消息时的群人数
     */
    var groupMemberCount = 0
}