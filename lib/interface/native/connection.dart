import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';
import '/listener/manager.dart';
import '/utils/utils.dart';

import '../../listener/listener.dart';
import '../../enum/enum.dart';
import '../base/base_connection.dart';
import '../../model/init_config.dart';
import '../../utils/define.dart';
import '../../utils/sdk_bindings.dart';

class NativeConnection extends BaseConnection {
  final _bindings = SDKBindings().bindings;

  /// Initialize the SDK
  @override
  Future<bool> initSDK(InitConfig config, {OnConnectListener? listener, String? operationID}) async {
    config.platformID ??= IMPlatform.current;
    config.dataDir ??= (await getApplicationDocumentsDirectory()).path;
    config.logFilePath ??= config.dataDir;

    final param = jsonEncode(config.toMap());

    late final ffi.NativeCallable<CBISFunc> callback;

    void onResponse(int b, ffi.Pointer<ffi.Char> data) {
      debugPrint('Connect onResponse: $b ${data == ffi.nullptr ? 'data is null' : data.toDartString()}');

      ListenerManager().emitEvent(b, data: data.toDartString());
      listener?.handleListenerEvent(ListenerType.fromValue(b), data.toDartString());
    }

    callback = ffi.NativeCallable<CBISFunc>.listener(onResponse);

    int result = _bindings.init_sdk(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      param.toNativeChar(),
    );

    debugPrint('initSDK result: $result');

    if (listener != null) {
      setListener(listener);
    }

    return result > 0;
  }

  @override
  Future<bool> login(String userID, String token, {String? operationID}) async {
    ListenerManager().setSDKListener();
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.im_login(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      userID.toNativeChar(),
      token.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> logout({String? operationID}) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.im_logout(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  LoginStatus getLoginStatus({String? operationID}) {
    final data = _bindings.get_login_status(Utils.reviseToNativeOperationID(operationID));

    return LoginStatus.fromValue(data);
  }

  @override
  void setListener<T extends Listener>(T listener) {
    ListenerManager().addListener(listener);
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    ListenerManager().removeListener(listener);
  }

  @override
  Future<bool> updateFcmToken({
    required String fcmToken,
    required int expireTime,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.update_fcm_token(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      fcmToken.toNativeChar(),
      expireTime,
    );

    return completer.future;
  }

  @override
  Future<bool> uploadFile({
    required String id,
    required String filePath,
    required String fileName,
    String? contentType,
    String? cause,
    OnUploadFileListener? onProgressListener,
    String? operationID,
  }) {
    final completer = Completer<bool>(); // Create a Completer to handle the asynchronous operation
    late final ffi.NativeCallable<CBISFunc> progressCallback;

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );
    // Callback function to handle the progress from the native side
    void onProgress(int type, ffi.Pointer<ffi.Char> data) {
      onProgressListener?.handleListenerEvent(
        ListenerType.fromValue(type),
        data,
      );
    }

    progressCallback = ffi.NativeCallable<CBISFunc>.listener(onProgress); // Create a listener for the progress callback

    final options = {
      'id': id,
      'filePath': filePath,
      'name': fileName,
      'contentType': contentType,
      'cause': cause,
    };
    // Call the native function with the necessary parameters
    _bindings.upload_file(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
      progressCallback.nativeFunction,
    );

    return completer.future; // Return the future from the completer
  }

  @override
  Future<bool> uploadLogs({
    String? ex,
    int line = 0,
    OnUploadLogsListener? onProgressListener,
    String? operationID,
  }) {
    final completer = Completer<bool>(); // Create a Completer to handle the asynchronous operation
    late final ffi.NativeCallable<CBISFunc> progressCallback;

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    void onProgress(int current, ffi.Pointer<ffi.Char> values) {
      final data = jsonDecode(values.toDartString());
      final current = data['current'] as int;
      final size = data['size'] as int;

      debugPrint('uploadLogs progress: $current, ${current / size}');
      onProgressListener?.onProgress(current, size);
    }

    progressCallback = ffi.NativeCallable<CBISFunc>.listener(onProgress);

    _bindings.upload_logs(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      line,
      ex?.toNativeChar() ?? ''.toNativeChar(),
      progressCallback.nativeFunction,
    );

    return completer.future; // Return the future from the completer
  }

  @override
  Future<bool> logs({
    int logLevel = 5,
    String? file,
    int line = 0,
    String? msgs,
    String? err,
    List? keyAndValues,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.logs(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      logLevel,
      file?.toNativeChar() ?? ''.toNativeChar(),
      line,
      msgs?.toNativeChar() ?? ''.toNativeChar(),
      err?.toNativeChar() ?? ''.toNativeChar(),
      jsonEncode(keyAndValues).toNativeChar(),
    );

    return completer.future;
  }
}
