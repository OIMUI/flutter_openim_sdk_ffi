package io.openim.flutter_openim_sdk_ffi.models

class PictureElem {
    /**
     * 本地资源地址
     */
    var sourcePath: String? = null

    /**
     * 本地图片详情
     */
    var sourcePicture: PictureInfo? = null

    /**
     * 大图详情
     */
    var bigPicture: PictureInfo? = null

    /**
     * 缩略图详情
     */
    var snapshotPicture: PictureInfo? = null
}