public class MessageTypeKeyMapping {
    /// 错误码
    var errCode: Int64 = 0
    
    /// 错误消息
    var errMsg: String?
    
    /// 反应扩展列表
    var reactionExtensionList: [String: KeyValue]?
    
    /// 客户端消息ID
    var clientMsgID: String?
}
