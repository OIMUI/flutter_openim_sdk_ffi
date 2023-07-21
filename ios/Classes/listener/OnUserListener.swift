protocol OnUserListener {
    /**
     * 当前用户的资料发生了更新
     * 可以在 UI 上更新自己的头像和昵称。
     */
    func onSelfInfoUpdated(_ info: UserInfo?)
}