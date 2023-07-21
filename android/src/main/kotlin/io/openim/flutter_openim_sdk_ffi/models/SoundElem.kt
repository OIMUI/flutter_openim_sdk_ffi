package io.openim.flutter_openim_sdk_ffi.models

class SoundElem {
    /**
     * 唯一ID
     */
    var uuid: String? = null

    /**
     * 本地资源地址
     */
    var soundPath: String? = null

    /**
     * oss地址
     */
    var sourceUrl: String? = null

    /**
     * 音频大小
     */
    var dataSize: Long = 0

    /**
     * 音频时长 s
     */
    var duration: Long = 0
}