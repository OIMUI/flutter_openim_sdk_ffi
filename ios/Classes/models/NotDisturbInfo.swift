

public class NotDisturbInfo {
    /// 会话ID
    var conversationId: String?
    
    /// 免打扰状态
    /// 1: 屏蔽消息; 2: 接收消息但不提示; 0: 正常
    var result = 0
}
