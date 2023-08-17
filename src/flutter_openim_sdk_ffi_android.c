#include <stdio.h>
#include <jni.h>
// #include <android/log.h>
JavaVM* gJavaVM;
jobject gJavaObj;

typedef struct {
    JavaVM* javaVm;
    jobject javaObj;
    char* methodName;
    char* operationID;
    char* callMethodName;
    double* errCode;
    char* message;
} JVMArgs;

void *jvm_point(void* arg)
{
    // 将void指针转换回ThreadArgs结构体指针
    JVMArgs* args = (JVMArgs*)arg;

    // 从结构体中获取参数
    JavaVM* javaVm = args->javaVm;
    jobject javaObj = args->javaObj;
    char* methodName = args->methodName;
    char* operationID = args->operationID;
    double* errCode = args->errCode;
    char* message = args->message;
    char* callMethodName = args->callMethodName;

    JNIEnv* env;
    jint result = (*javaVm)->AttachCurrentThread(javaVm, &env, NULL);
    if (result == JNI_OK) {
        // 将参数转换为 Java 字符串对象
        jstring methodNameStr = (*env)->NewStringUTF(env, methodName);
        jstring operationIDStr = NULL;
        jstring callMethodNameStr = NULL;
        jstring messageStr = NULL;
        if (operationID != NULL) {
            operationIDStr = (*env)->NewStringUTF(env, operationID);
        }
        if (callMethodName != NULL) {
            callMethodNameStr = (*env)->NewStringUTF(env, callMethodName);
        }

        if(message != NULL) {
            messageStr = (*env)->NewStringUTF(env, message);
        }
        jclass javaClass = (*env)->GetObjectClass(env, javaObj);
        jmethodID methodID = (*env)->GetMethodID(env, javaClass, "onMethodChannel",
                                                 "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Double;Ljava/lang/String;)V");
        if (errCode == NULL) {
            // 调用 Java 方法
            (*env)->CallVoidMethod(env, gJavaObj, methodID, methodNameStr, operationIDStr, callMethodNameStr, NULL, messageStr);
        } else {
            jclass doubleClass = (*env)->FindClass(env, "java/lang/Double");
            jmethodID doubleConstructor = (*env)->GetMethodID(env, doubleClass, "<init>", "(D)V");
            jobject javaDouble = (*env)->NewObject(env, doubleClass, doubleConstructor, *errCode);
            // 调用 Java 方法
            (*env)->CallVoidMethod(env, gJavaObj, methodID, methodNameStr, operationIDStr, callMethodNameStr, javaDouble, messageStr);
        }
        // 释放局部引用
        (*env)->DeleteLocalRef(env, methodNameStr);
        (*env)->DeleteLocalRef(env, operationIDStr);
        (*env)->DeleteLocalRef(env, callMethodNameStr);
        (*env)->DeleteLocalRef(env, messageStr);

        (*gJavaVM)->DetachCurrentThread(gJavaVM);
    }
    pthread_exit(NULL);
}

void onNativeMethodChannelFunc(char* methodName, char* operationID, char* callMethodName, double* errCode, char* message) {

    // __android_log_print(ANDROID_LOG_DEBUG, "methodName", "%d", methodName);
    // 创建参数结构体并分配内存
    JVMArgs* args = (JVMArgs*)malloc(sizeof(JVMArgs));

    // 设置参数值
    args->javaVm = gJavaVM;
    args->javaObj = gJavaObj;
    args->methodName = methodName;
    args->errCode = errCode;
    args->message = message;
    args->operationID = operationID;
    args->callMethodName = callMethodName;

    pthread_t thread;
    pthread_create(&thread, NULL, jvm_point, (void *)args);
    pthread_detach(thread);
}


JNIEXPORT void JNICALL
 Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_registerCallback(JNIEnv *env, jobject thiz) {
     (*env)->GetJavaVM(env, &gJavaVM);
     gJavaObj = (*env)->NewGlobalRef(env, thiz);
//    g_listener.onNativeMethodChannel = onNativeMethodChannelFunc;
     registerNativeCallback = true;
 }

JNIEXPORT void JNICALL
Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_Login(JNIEnv *env, jobject thiz,
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

JNIEXPORT void JNICALL
Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_GetSelfUserInfo(JNIEnv *env, jobject thiz,
                                                                      jstring operation_id) {
    const char *native_operation_id = (*env)->GetStringUTFChars(env, operation_id, 0);
    bool (*GetSelfUserInfo)(const char*) = dlsym(dlfHandle, "GetSelfUserInfo");
    GetSelfUserInfo(native_operation_id);
    (*env)->ReleaseStringUTFChars(env, operation_id, native_operation_id);
}

JNIEXPORT void JNICALL
Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_GetTotalUnreadMsgCount(JNIEnv *env,
                                                                             jobject thiz,
                                                                             jstring operation_id) {
    const char *native_operation_id = (*env)->GetStringUTFChars(env, operation_id, 0);
    bool (*GetTotalUnreadMsgCount)(const char*) = dlsym(dlfHandle, "GetTotalUnreadMsgCount");
    GetTotalUnreadMsgCount(native_operation_id);
    (*env)->ReleaseStringUTFChars(env, operation_id, native_operation_id);
}

JNIEXPORT void JNICALL
Java_io_openim_flutter_1openim_1sdk_1ffi_OpenIMSDKFFi_InitSDK(JNIEnv *env, jobject thiz,
                                                              jstring operation_id,
                                                              jstring params) {
    const char *native_operation_id = (*env)->GetStringUTFChars(env, operation_id, 0);
    const char *native_params = (*env)->GetStringUTFChars(env, params, 0);
    bool (*InitSDK)(const char*, const char*) = dlsym(dlfHandle, "InitSDK");
    InitSDK(native_operation_id, native_params);
    (*env)->ReleaseStringUTFChars(env, operation_id, native_operation_id);
    (*env)->ReleaseStringUTFChars(env, params, native_params);
}