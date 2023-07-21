
public class UserInfo: Decodable {
    private var userID: String? = nil

    var nickname: String? {
        get {
            if isFriendship {
                return friendInfo?.nickname
            } else if isBlacklist {
                return blackInfo?.nickname
            } else if let publicInfo = publicInfo {
                return publicInfo.nickname
            }
            return self.nickname
        }
        set {
            self.nickname = newValue
        }
    }

    var faceURL: String? {
        get {
            if let faceURL = self.faceURL {
                return faceURL
            } else if isFriendship {
                return friendInfo?.faceURL
            } else if isBlacklist {
                return blackInfo?.faceURL
            } else if let publicInfo = publicInfo {
                return publicInfo.faceURL
            }
            return nil
        }
        set {
            self.faceURL = newValue
        }
    }

    var gender:Int {
        get {
            if isFriendship {
                return friendInfo?.gender ?? 0
            } else if isBlacklist {
                return blackInfo?.gender ?? 0
            } else if let publicInfo = publicInfo {
                return publicInfo.gender
            }
            return self.gender
        }
        set {
            self.gender = newValue
        }
    }

    var phoneNumber: String? {
        get {
            if let phoneNumber = self.phoneNumber {
                return phoneNumber
            } else if isFriendship {
                return friendInfo?.phoneNumber
            }
            return nil
        }
        set {
            self.phoneNumber = newValue
        }
    }

    var birth: Int64 {
        get {
            if isFriendship {
                return friendInfo?.birth ?? 0
            }
            return self.birth
        }
        set {
            self.birth = newValue
        }
    }

    var birthTime: String? = nil

    var email: String? {
        get {
            if let email = self.email {
                return email
            } else if isFriendship {
                return friendInfo?.email
            }
            return nil
        }
        set {
            self.email = newValue
        }
    }

    var ex: String? {
        get {
            if let ex = self.ex {
                return ex
            } else if isFriendship {
                return friendInfo?.ex
            } else if isBlacklist {
                return blackInfo?.ex
            }
            return nil
        }
        set {
            self.ex = newValue
        }
    }

    var remark: String? {
        get {
            if let remark = self.remark {
                return remark
            } else if isFriendship {
                return friendInfo?.remark
            }
            return nil
        }
        set {
            self.remark = newValue
        }
    }

    var publicInfo: PublicUserInfo? = nil
    var friendInfo: FriendInfo? = nil
    var blackInfo: BlacklistInfo? = nil
    var globalRecvMsgOpt = 0

    func getUserID() -> String? {
        if let userID = userID {
            return userID
        } else if isFriendship {
            return friendInfo?.userID
        } else if isBlacklist {
            return blackInfo?.userID
        } else if let publicInfo = publicInfo {
            return publicInfo.userID
        }
        return nil
    }

    func setUserID(userID: String?) {
        self.userID = userID
    }

    var isBlacklist: Bool {
        return blackInfo != nil
    }

    var isFriendship: Bool {
        return friendInfo != nil
    }

    static func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
        return lhs.userID == rhs.userID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(userID)
    }
}
