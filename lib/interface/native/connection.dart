import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
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
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('login failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(errorCode, errorMsg.toDartString()));
      } else {
        debugPrint('login success: ${operationID.toDartString()}, $errorCode, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.login(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      userID.toNativeChar(),
      token.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> logout({String? operationID}) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('loginout failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(errorCode, errorMsg.toDartString()));
      } else {
        debugPrint('loginout success: $operationID, $errorCode, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.logout(callback.nativeFunction, Utils.reviseToNativeOperationID(operationID));

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
    final completer = Completer<bool>(); // Create a Completer to handle the asynchronous operation
    late final ffi.NativeCallable<CBSISSFunc> callback;

    // Callback function to handle the response from the native side
    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('updateFcmToken failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(errorCode, errorMsg.toDartString()));
      } else {
        debugPrint('updateFcmToken success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close(); // Close the callback to free resources
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse); // Create a listener for the callback

    // Call the native function with the necessary parameters
    _bindings.update_fcm_token(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      fcmToken.toNativeChar(),
      expireTime,
    );

    return completer.future; // Return the future from the completer
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
    late final ffi.NativeCallable<CBSISSFunc> callback;
    late final ffi.NativeCallable<CBISFunc> progressCallback;

    // Callback function to handle the response from the native side
    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('uploadFile failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(errorCode, errorMsg.toDartString()));
      } else {
        debugPrint('uploadFile success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close(); // Close the callback to free resources
    }

    // Callback function to handle the progress from the native side
    void onProgress(int type, ffi.Pointer<ffi.Char> data) {
      onProgressListener?.handleListenerEvent(
        ListenerType.fromValue(type),
        data,
      );
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse); // Create a listener for the callback
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
      callback.nativeFunction,
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
    late final ffi.NativeCallable<CBSISSFunc> callback;
    late final ffi.NativeCallable<CBISFunc> progressCallback;

    // Callback function to handle the response from the native side
    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('uploadLogs failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(errorCode, errorMsg.toDartString()));
      } else {
        debugPrint('uploadLogs success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close(); // Close the callback to free resources
    }

    void onProgress(int current, ffi.Pointer<ffi.Char> values) {
      final data = jsonDecode(values.toDartString());
      final current = data['current'] as int;
      final size = data['size'] as int;

      debugPrint('uploadLogs progress: $current, ${current / size}');
      onProgressListener?.onProgress(current, size);
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse); // Create a listener for the callback
    progressCallback = ffi.NativeCallable<CBISFunc>.listener(onProgress);

    // Call the native function with the necessary parameters
    _bindings.upload_logs(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      line,
      ex?.toNativeChar() ?? ''.toNativeChar(),
      progressCallback.nativeFunction,
    );

    return completer.future; // Return the future from the completer
  }

  @override
  Future<bool> logs(
      {int logLevel = 5,
      String? file,
      int line = 0,
      String? msgs,
      String? err,
      List? keyAndValues,
      String? operationID}) {
    final completer = Completer<bool>(); // Create a Completer to handle the asynchronous operation
    late final ffi.NativeCallable<CBSISSFunc> callback;

    // Callback function to handle the response from the native side
    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('logs failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(errorCode, errorMsg.toDartString()));
      } else {
        debugPrint('logs success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close(); // Close the callback to free resources
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse); // Create a listener for the callback

    // Call the native function with the necessary parameters
    _bindings.logs(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      logLevel,
      file?.toNativeChar() ?? ''.toNativeChar(),
      line,
      msgs?.toNativeChar() ?? ''.toNativeChar(),
      err?.toNativeChar() ?? ''.toNativeChar(),
      jsonEncode(keyAndValues).toNativeChar(),
    );

    return completer.future; // Return the future from the completer
  }
}
