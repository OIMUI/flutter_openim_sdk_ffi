package io.openim.flutter_openim_sdk_ffi.models

class VideoElem {
    /**
     * 视频本地资源地址
     */
    var videoPath: String? = null

    /**
     * 视频唯一ID
     */
    var videoUUID: String? = null

    /**
     * 视频oss地址
     */
    var videoUrl: String? = null

    /**
     * 视频类型
     */
    var videoType: String? = null

    /**
     * 视频大小
     */
    var videoSize: Long = 0

    /**
     * 视频时长
     */
    var duration: Long = 0

    /**
     * 视频快照本地地址
     */
    var snapshotPath: String? = null

    /**
     * 视频快照唯一ID
     */
    var snapshotUUID: String? = null

    /**
     * 视频快照大小
     */
    var snapshotSize: Long = 0

    /**
     * 视频快照oss地址
     */
    var snapshotUrl: String? = null

    /**
     * 视频快照宽度
     */
    var snapshotWidth = 0

    /**
     * 视频快照高度
     */
    var snapshotHeight = 0
}