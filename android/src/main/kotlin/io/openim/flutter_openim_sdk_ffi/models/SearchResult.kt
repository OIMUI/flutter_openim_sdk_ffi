package io.openim.flutter_openim_sdk_ffi.models

class SearchResult {
    /**
     * 获取到的总的消息数量
     */
    var totalCount = 0
    var searchResultItems: List<SearchResultItem>? = null
    var findResultItems: List<SearchResultItem>? = null
}