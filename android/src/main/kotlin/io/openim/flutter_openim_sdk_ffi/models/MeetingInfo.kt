package io.openim.flutter_openim_sdk_ffi.models

class MeetingInfo {
    var meetingID: String? = null
    var meetingName: String? = null
    var hostUserID: String? = null
    var createTime: Long = 0
    var startTime: Long = 0
    var endTime: Long = 0
    var isParticipantCanEnableVideo = false
    var isOnlyHostInviteUser = false
    var isJoinDisableVideo = false
    var isParticipantCanUnmuteSelf = false
    var isMuteAllMicrophone = false
    var inviteeUserIDList: List<String>? = null
}