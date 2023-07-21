protocol OnSignalingListener {
    func onInvitationCancelled(_ info: SignalingInfo?)
    func onInvitationTimeout(_ info: SignalingInfo?)
    func onInviteeAccepted(_ info: SignalingInfo?)
    func onInviteeAcceptedByOtherDevice(_ info: SignalingInfo?)
    func onInviteeRejected(_ info: SignalingInfo?)
    func onInviteeRejectedByOtherDevice(_ info: SignalingInfo?)
    func onReceiveNewInvitation(_ info: SignalingInfo?)
    func onHangup(_ info: SignalingInfo?)
    func onRoomParticipantConnected(_ info: RoomCallingInfo?)
    func onRoomParticipantDisconnected(_ info: RoomCallingInfo?)
    func onMeetingStreamChanged(_ event: MeetingStreamEvent?)
    func onReceiveCustomSignal(_ info: CustomSignalingInfo?)
}