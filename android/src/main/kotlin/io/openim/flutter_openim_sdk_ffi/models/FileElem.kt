package io.openim.flutter_openim_sdk_ffi.models

class FileElem {
    /**
     * 文件本地资源地址
     */
    var filePath: String? = null

    /**
     * id
     */
    var uuid: String? = null

    /**
     * oss地址
     */
    var sourceUrl: String? = null

    /**
     * 文件名称
     */
    var fileName: String? = null

    /**
     * 文件大小
     */
    var fileSize: Long = 0
}