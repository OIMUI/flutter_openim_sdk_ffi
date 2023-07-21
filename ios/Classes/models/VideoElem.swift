

public class VideoElem {
    /**
     * 视频本地资源地址
     */
    var videoPath: String? 

    /**
     * 视频唯一ID
     */
    var videoUUID: String? 

    /**
     * 视频oss地址
     */
    var videoUrl: String? 

    /**
     * 视频类型
     */
    var videoType: String? 

    /**
     * 视频大小
     */
    var videoSize: Int64 = 0

    /**
     * 视频时长
     */
    var duration: Int64 = 0

    /**
     * 视频快照本地地址
     */
    var snapshotPath: String? 

    /**
     * 视频快照唯一ID
     */
    var snapshotUUID: String? 

    /**
     * 视频快照大小
     */
    var snapshotSize: Int64 = 0

    /**
     * 视频快照oss地址
     */
    var snapshotUrl: String? 

    /**
     * 视频快照宽度
     */
    var snapshotWidth = 0

    /**
     * 视频快照高度
     */
    var snapshotHeight = 0
}
