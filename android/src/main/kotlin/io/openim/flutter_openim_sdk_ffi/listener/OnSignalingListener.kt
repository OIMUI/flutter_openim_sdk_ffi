package io.openim.flutter_openim_sdk_ffi.listener

import io.openim.flutter_openim_sdk_ffi.models.CustomSignalingInfo
import io.openim.flutter_openim_sdk_ffi.models.MeetingStreamEvent
import io.openim.flutter_openim_sdk_ffi.models.RoomCallingInfo
import io.openim.flutter_openim_sdk_ffi.models.SignalingInfo

interface OnSignalingListener {
    fun onInvitationCancelled(s: SignalingInfo?)
    fun onInvitationTimeout(s: SignalingInfo?)
    fun onInviteeAccepted(s: SignalingInfo?)
    fun onInviteeAcceptedByOtherDevice(s: SignalingInfo?)
    fun onInviteeRejected(s: SignalingInfo?)
    fun onInviteeRejectedByOtherDevice(s: SignalingInfo?)
    fun onReceiveNewInvitation(s: SignalingInfo?)
    fun onHangup(s: SignalingInfo?)
    fun onRoomParticipantConnected(s: RoomCallingInfo?)
    fun onRoomParticipantDisconnected(s: RoomCallingInfo?)
    fun onMeetingStreamChanged(e: MeetingStreamEvent?)
    fun onReceiveCustomSignal(s: CustomSignalingInfo?)
}