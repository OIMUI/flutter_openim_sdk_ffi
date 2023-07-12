package io.openim.flutter_openim_sdk_ffi.models

class RoomCallingInfo {
    var invitation: SignalingInvitationInfo? = null
    var participant: List<Participant>? = null
    var token: String? = null
    var roomID: String? = null
    var liveURL: String? = null
    var groupID: String? = null
}