package io.openim.flutter_openim_sdk_ffi.models

class OfflinePushInfo {
    var title: String? = null
    var desc: String? = null
    var ex: String? = null
    private var iOSPushSound: String? = null
    private var iOSBadgeCount = false
    fun getiOSPushSound(): String? {
        return iOSPushSound
    }

    fun setiOSPushSound(iOSPushSound: String?) {
        this.iOSPushSound = iOSPushSound
    }

    fun isiOSBadgeCount(): Boolean {
        return iOSBadgeCount
    }

    fun setiOSBadgeCount(iOSBadgeCount: Boolean) {
        this.iOSBadgeCount = iOSBadgeCount
    }
}