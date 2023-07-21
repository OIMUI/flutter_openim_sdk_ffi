

public class SearchResultItem {
    /**
     * 会话ID
     */
    var conversationID: String? 

    /**
     * 这个会话下的消息数量
     */
    var messageCount = 0

    /**
     * 显示名
     */
    var showName: String? 

    /**
     * 头像
     */
    var faceURL: String? 

    /**
     * Message的列表
     */
    var messageList: [Message]? 
}
