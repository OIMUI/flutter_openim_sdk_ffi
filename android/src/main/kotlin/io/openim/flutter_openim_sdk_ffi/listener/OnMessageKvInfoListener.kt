package io.openim.flutter_openim_sdk_ffi.listener


import io.openim.flutter_openim_sdk_ffi.models.MessageKv

interface OnMessageKvInfoListener {
    fun onMessageKvInfoChanged(list: List<MessageKv>)
}