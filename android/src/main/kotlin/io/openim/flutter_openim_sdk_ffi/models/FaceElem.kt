package io.openim.flutter_openim_sdk_ffi.models

/**
 * 表情
 */
class FaceElem {
    /**
     * app内嵌表情包，根据index 匹配显示表情图
     */
    var index = 0

    /**
     * 其他表情，如url表情，直接加载url即可
     */
    var data: String? = null
}