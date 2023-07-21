
protocol OnListenerForService {
    func onFriendApplicationAccepted(_ info: FriendApplicationInfo?)
    func onFriendApplicationAdded(_ info: FriendApplicationInfo?)
    func onGroupApplicationAccepted(_ info: GroupApplicationInfo?)
    func onGroupApplicationAdded(_ info: GroupApplicationInfo?)
    func onRecvNewMessage(_ msg: Message?)
}