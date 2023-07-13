package io.openim.flutter_openim_sdk_ffi

import com.google.gson.Gson
import com.google.gson.JsonParser
import com.google.gson.reflect.TypeToken

object JsonUtil {
    private val gson = Gson()

    /**
     * 将object对象转成json字符串
     */
    fun toString(`object`: Any): String {
        return gson.toJson(`object`)
    }

    /**
     * 将gsonString转成泛型bean
     */
    fun <T> toObj(gsonString: String, cls: Class<T>): T {
        return gson.fromJson(gsonString, cls)
    }

    /**
     * 转成list
     * 解决泛型在编译期类型被擦除导致报错
     */
    fun <T> toArray(json: String, cls: Class<T>): List<T> {
        val list: MutableList<T> = ArrayList()
        val array = JsonParser.parseString(json).asJsonArray
        for (elem in array) {
            list.add(gson.fromJson(elem, cls))
        }
        return list
    }

    /**
     * 转成list中有map的
     */
    fun <T> toListMaps(gsonString: String?): List<Map<String, T>>? {
        return gson.fromJson(gsonString, object : TypeToken<List<Map<String, T>>>() {}.type)
    }

    /**
     * 转成map的
     */
    fun <T> toMaps(gsonString: String?): Map<String, T>? {
        return gson.fromJson(gsonString, object : TypeToken<Map<String, T>>() {}.type)
    }
}
