

/**
 * 群组监听
 */
protocol OnGroupListener {
    func onGroupApplicationAccepted(_ info: GroupApplicationInfo)
    func onGroupApplicationAdded(_ info: GroupApplicationInfo)
    func onGroupApplicationDeleted(_ info: GroupApplicationInfo)
    func onGroupApplicationRejected(_ info: GroupApplicationInfo)
    func onGroupInfoChanged(_ info: GroupInfo)
    func onGroupMemberAdded(_ info: GroupMembersInfo)
    func onGroupMemberDeleted(_ info: GroupMembersInfo)
    func onGroupMemberInfoChanged(_ info: GroupMembersInfo)
    func onJoinedGroupAdded(_ info: GroupInfo)
    func onJoinedGroupDeleted(_ info: GroupInfo)
}