

/**
 * api接口回调
 */
protocol OnBase {
    associatedtype T

    /**
     * 失败
     */
    func onError(code: Int, error: String)

    /**
     * 成功
     */
    func onSuccess(data: T)
}