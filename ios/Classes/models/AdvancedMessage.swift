public class AdvancedMessage {
    var errCode: Int = 0
    var errMsg: String? = nil
    var lastMinSeq: Int = 0
    var isEnd: Bool = false
    var messageList: [Message]? = nil
}