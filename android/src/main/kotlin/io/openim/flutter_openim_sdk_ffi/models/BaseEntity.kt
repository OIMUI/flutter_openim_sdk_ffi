package io.openim.flutter_openim_sdk_ffi.models

import io.openim.flutter_openim_sdk_ffi.JsonUtil


class BaseEntity {
    override fun toString(): String {
        return JsonUtil.toString(this)
    }
}