



/**
 * 消息发送监听
 */
protocol OnFileUploadProgressListener: OnBase  where T == String {
    /**
     * 上传进度
     */
    func onProgress(progress: Int64)

    // Optionally, you can provide default implementations for the onSuccess and onError methods
    func onSuccess(data: String) 

    func onError(code: Int, error: String) 
}