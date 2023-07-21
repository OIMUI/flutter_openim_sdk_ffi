package io.openim.flutter_openim_sdk_ffi.models

class NotDisturbInfo {
    /**
     * 会话id
     */
    var conversationId: String? = null

    /**
     * 免打扰状态
     * 1:屏蔽消息; 2:接收消息但不提示; 0:正常
     */
    var result = 0
}