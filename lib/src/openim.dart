part of flutter_openim_sdk_ffi;

const String _libName = 'flutter_openim_sdk_ffi';

const String _imLibName = 'openim_sdk_ffi';

const mode = kReleaseMode
    ? 'Release'
    : kProfileMode
        ? 'Profile'
        : 'Debug';

final ffi.DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return ffi.DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return ffi.DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final ffi.DynamicLibrary _imDylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return ffi.DynamicLibrary.open('lib$_imLibName.dylib');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return ffi.DynamicLibrary.open('lib$_imLibName.so');
  }
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('$_imLibName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final FlutterOpenimSdkFfiBindings _bindings = FlutterOpenimSdkFfiBindings(_dylib);

class OpenIM {
  static Future<String> get version async {
    ReceivePort receivePort = ReceivePort();
    OpenIMManager._openIMSendPort.send(_PortModel(method: _PortMethod.version, sendPort: receivePort.sendPort));
    _PortResult<String> data = await receivePort.first;
    receivePort.close();
    return data.value;
  }

  static final iMManager = IMManager();

  OpenIM._();
}
