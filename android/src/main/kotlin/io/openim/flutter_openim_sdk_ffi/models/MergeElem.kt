package io.openim.flutter_openim_sdk_ffi.models

class MergeElem {
    /**
     * 标题
     */
    var title: String? = null

    /**
     * 摘要
     */
    var abstractList: List<String>? = null

    /**
     * 具体选择合并的消息列表
     */
    var multiMessage: List<Message>? = null
}