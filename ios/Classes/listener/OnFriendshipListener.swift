

/**
 * 好友关系监听
 */
protocol OnFriendshipListener {
    func onBlacklistAdded(_ info: BlacklistInfo)
    func onBlacklistDeleted(_ info: BlacklistInfo)
    func onFriendApplicationAccepted(_ info: FriendApplicationInfo)
    func onFriendApplicationAdded(_ info: FriendApplicationInfo)
    func onFriendApplicationDeleted(_ info: FriendApplicationInfo)
    func onFriendApplicationRejected(_ info: FriendApplicationInfo)
    func onFriendInfoChanged(_ info: FriendInfo)
    func onFriendAdded(_ info: FriendInfo)
    func onFriendDeleted(_ info: FriendInfo)
}