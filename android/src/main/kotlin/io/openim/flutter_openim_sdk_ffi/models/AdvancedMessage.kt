package io.openim.flutter_openim_sdk_ffi.models

class AdvancedMessage {
    var errCode = 0
    var errMsg: String? = null
    var lastMinSeq = 0
    var isEnd = false
    var messageList: List<Message>? = null
}