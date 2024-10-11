import 'dart:ffi' as ffi;
import 'dart:io';

import '../open_im_sdk_bindings_generated.dart';

class SDKBindings {
  late final OpenImSdkBindings bindings;

  static SDKBindings? _instance;
  factory SDKBindings() {
    _instance ??= SDKBindings._();

    return _instance!;
  }

  SDKBindings._() {
    _init();
  }

  void _init() {
    final dylib = () {
      const lib = 'openimsdk';

      if (Platform.isIOS) {
        return ffi.DynamicLibrary.open('$lib.framework/$lib');
      }

      if (Platform.isMacOS) {
        return ffi.DynamicLibrary.open('lib$lib.dylib');
      }

      if (Platform.isAndroid || Platform.isLinux) {
        return ffi.DynamicLibrary.open('lib$lib.so');
      }

      if (Platform.isWindows) {
        return ffi.DynamicLibrary.open('lib$lib.dll');
      }
      throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
    }();

    bindings = OpenImSdkBindings(dylib);
  }
}
