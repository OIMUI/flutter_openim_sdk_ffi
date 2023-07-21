public class OfflinePushInfo {
    var title: String?
    var desc: String?
    var ex: String?
    private var iOSPushSound: String?
    private var iOSBadgeCount = false
    
    func getiOSPushSound() -> String? {
        return iOSPushSound
    }
    
    func setiOSPushSound(_ iOSPushSound: String?) {
        self.iOSPushSound = iOSPushSound
    }
    
    func isiOSBadgeCount() -> Bool {
        return iOSBadgeCount
    }
    
    func setiOSBadgeCount(_ iOSBadgeCount: Bool) {
        self.iOSBadgeCount = iOSBadgeCount
    }
}
