#include <jni.h>
#include <stdio.h>


static void* dlfHandle;
JavaVM* gJavaVM;
jobject gJavaObj;

void onNativeMethodChannelFunc(char* methodName, char* operationID, char* callMethodName, double* errCode, char* message) {
    JNIEnv* env;
    jint result = (*gJavaVM)->AttachCurrentThread(gJavaVM, &env, NULL);
    if (result == JNI_OK) {
        // 将参数转换为 Java 字符串对象
        jstring methodNameStr = (*env)->NewStringUTF(env, "methodName");
        jstring operationIDStr = (*env)->NewStringUTF(env, "operationID");
        jstring callMethodNameStr = (*env)->NewStringUTF(env, "callMethodName");
        jstring messageStr = (*env)->NewStringUTF(env, "message");
        jclass javaClass = (*env)->GetObjectClass(env, gJavaObj);
        jmethodID methodID = (*env)->GetMethodID(env, javaClass, "onMethodChannel", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;DLjava/lang/String;)V");
        // 调用 Java 方法
        (*env)->CallVoidMethod(env, gJavaObj, methodID, methodNameStr, operationIDStr, callMethodNameStr, 0.0, messageStr);

        // 释放局部引用
        (*env)->DeleteLocalRef(env, methodNameStr);
        (*env)->DeleteLocalRef(env, operationIDStr);
        (*env)->DeleteLocalRef(env, callMethodNameStr);
        (*env)->DeleteLocalRef(env, messageStr);

        (*gJavaVM)->DetachCurrentThread(gJavaVM);
    }
}

 JNIEXPORT void JNICALL
 Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_registerCallback(JNIEnv *env, jobject thiz) {
     (*env)->GetJavaVM(env, &gJavaVM);
     gJavaObj = (*env)->NewGlobalRef(env, thiz);
     g_listener.onNativeMethodChannel = onNativeMethodChannelFunc;
     dlfHandle = dlopen("libopenim_sdk_ffi.so", RTLD_LAZY);
     void (*NativeRegisterCallback)(CGO_OpenIM_Listener*) = dlsym(dlfHandle, "NativeRegisterCallback");
     NativeRegisterCallback(&g_listener);
 }

JNIEXPORT jboolean JNICALL
Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_InitSDK(JNIEnv *env, jobject thiz, jstring operation_id, jstring config) {
     const char *native_operation_id = (*env)->GetStringUTFChars(env, operation_id, 0);
     const char *native_config = (*env)->GetStringUTFChars(env, config, 0);

     bool (*InitSDK)(const char*, const char*) = dlsym(dlfHandle, "InitSDK");
     bool status = InitSDK(native_operation_id, native_config);

     (*env)->ReleaseStringUTFChars(env, operation_id, native_operation_id);
     (*env)->ReleaseStringUTFChars(env, config, native_config);

     return status ? JNI_TRUE : JNI_FALSE;
 }

JNIEXPORT void JNICALL
Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_login(JNIEnv *env, jobject thiz,
                                                            jstring operation_id, jstring user_id,
                                                            jstring token) {
    const char *native_operation_id = (*env)->GetStringUTFChars(env, operation_id, 0);
    const char *native_user_id = (*env)->GetStringUTFChars(env, user_id, 0);
    const char *native_token = (*env)->GetStringUTFChars(env, token, 0);

    bool (*Login)(const char*, const char*, const char*) = dlsym(dlfHandle, "Login");
    Login(native_operation_id, native_user_id, native_token);

    (*env)->ReleaseStringUTFChars(env, operation_id, native_operation_id);
    (*env)->ReleaseStringUTFChars(env, user_id, native_user_id);
    (*env)->ReleaseStringUTFChars(env, token, native_token);

}