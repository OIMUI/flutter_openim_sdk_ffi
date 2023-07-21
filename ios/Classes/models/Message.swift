public class Message {
    /// 消息唯一ID
    var clientMsgID: String?
    
    /// 消息服务器ID，暂时不使用
    var serverMsgID: String?
    
    /// 消息创建时间，单位纳秒
    var createTime: Int64 = 0
    
    /// 消息发送时间，单位ms
    var sendTime: Int64 = 0
    
    /// 会话类型 1:单聊 2:群聊 [io.openim.android.sdk.enums.ConversationType]
    var sessionType = 0
    
    /// 发送者ID
    var sendID: String?
    
    /// 接收者ID
    var recvID: String?
    
    /// 标识消息是用户级别还是系统级别 100:用户 200:系统
    var msgFrom = 0
    
    /// [io.openim.android.sdk.enums.MessageType]
    /// 消息类型：<br></br>
    /// 101:文本消息<br></br>
    /// 102:图片消息<br></br>
    /// 103:语音消息<br></br>
    /// 104:视频消息<br></br>
    /// 105:文件消息<br></br>
    /// 106:@消息<br></br>
    /// 107:合并消息<br></br>
    /// 108:转发消息<br></br>
    /// 109:位置消息<br></br>
    /// 110:自定义消息<br></br>
    /// 111:撤回消息回执<br></br>
    /// 112:C2C已读回执<br></br>
    /// 113:正在输入状态
    var contentType = 0
    
    /// [io.openim.android.sdk.enums.Platform]
    /// 平台类型 1:ios 2:android 3:windows 4:osx 5:web 6:mini 7:linux
    var platformID = 0
    
    /// 发送者昵称
    var senderNickname: String?
    
    /// 发送者头像
    var senderFaceUrl: String?
    
    /// 群聊ID
    var groupID: String?
    
    /// 消息内容
    var content: String?
    
    /// 消息唯一序列号
    var seq = 0
    
    /// 是否已读
    var isRead = false
    
    /// [io.openim.android.sdk.enums.MessageStatus]
    /// 消息状态 1:发送中 2:发送成功 3:发送失败 4:已删除 5:已撤回
    var status = 0
    
    /// 离线消息推送内容
    var offlinePush: OfflinePushInfo?
    
    /// 附加信息
    var attachedInfo: String?
    
    ///
    var ext: Any?
    
    /// 附加字段
    var ex: Any?
    
    /// 图片信息
    var pictureElem: PictureElem?
    
    /// 语音信息
    var soundElem: SoundElem?
    
    /// 视频信息
    var videoElem: VideoElem?
    
    /// 文件信息
    var fileElem: FileElem?
    
    /// _@信息
    var atElem: AtElem?
    
    /// 位置信息
    var locationElem: LocationElem?
    
    /// 自定义信息
    var customElem: CustomElem?
    
    /// 引用消息
    var quoteElem: QuoteElem?
    
    /// 合并信息
    var mergeElem: MergeElem?
    
    /// 通知
    var notificationElem: NotificationElem?
    
    /// 自定义表情
    var faceElem: FaceElem?
    
    /// 附加信息 如：群消息已读
    var attachedInfoElem: AttachedInfoElem?
    
    var isReact = false
    var isExternalExtensions = false

    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.clientMsgID == rhs.clientMsgID
    }
}
