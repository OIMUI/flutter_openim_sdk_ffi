

public class SoundElem {
    /**
     * 唯一ID
     */
    var uuid: String? 

    /**
     * 本地资源地址
     */
    var soundPath: String? 

    /**
     * oss地址
     */
    var sourceUrl: String? 

    /**
     * 音频大小
     */
    var dataSize: Int64 = 0

    /**
     * 音频时长 s
     */
    var duration: Int64 = 0
}
