import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../enum/enum.dart';
import '../../listener/listener.dart';
import '../../listener/manager.dart';
import '../../utils/utils.dart';

import '../../model/user_info.dart';
import '../../utils/define.dart';
import '../../utils/sdk_bindings.dart';
import '../base/base_user.dart';

class NativeUser extends BaseUser {
  final _bindings = SDKBindings().bindings;

  // Function to get user information based on user IDs
  @override
  Future<List<PublicUserInfo>> getUsersInfo(List<String> userIDs, {String? operationID}) {
    final completer = Completer<List<PublicUserInfo>>();
    final param = jsonEncode(userIDs);

    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getUsersInfo failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getUsersInfo success: $operationID, $errorCode, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map((e) => PublicUserInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_users_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      param.toNativeChar(),
    );

    return completer.future;
  }

  // Function to get self-user information
  @override
  Future<UserInfo> getSelfUserInfo({
    String? operationID,
  }) {
    final completer = Completer<UserInfo>();

    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getSelfUserInfo failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getSelfUserInfo success: ${operationID.toDartString()}, $errorCode, ${data.toDartString()}');
        final userInfo = UserInfo.fromJson(jsonDecode(data.toDartString()));
        completer.complete(userInfo);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_self_user_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  // Function to modify the profile of the logged-in user
  @override
  Future<bool> setSelfInfo({
    String? nickname,
    String? faceURL,
    int? globalRecvMsgOpt,
    String? ex,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('setSelfInfo failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('setSelfInfo success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'nickname': nickname,
      'faceURL': faceURL,
      'globalRecvMsgOpt': globalRecvMsgOpt,
      'ex': ex,
    };

    _bindings.set_self_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  // Function to subscribe to users' status
  @override
  Future<List<UserStatusInfo>> subscribeUsersStatus(
    List<String> userIDs, {
    String? operationID,
  }) {
    final completer = Completer<List<UserStatusInfo>>();
    final param = jsonEncode(userIDs);

    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('subscribeUsersStatus failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('subscribeUsersStatus success: $operationID, $errorCode, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map<UserStatusInfo>((e) => UserStatusInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.subscribe_users_status(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      param.toNativeChar(),
    );

    return completer.future;
  }

  // Function to unsubscribe users' status
  @override
  Future<bool> unsubscribeUsersStatus(
    List<String> userIDs, {
    String? operationID,
  }) {
    final completer = Completer<bool>();
    final param = jsonEncode(userIDs);

    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('unsubscribeUsersStatus failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('unsubscribeUsersStatus success: $operationID, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.unsubscribe_users_status(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      param.toNativeChar(),
    );

    return completer.future;
  }

  // Function to get the subscribed users' status
  @override
  Future<List<UserStatusInfo>> getSubscribeUsersStatus({
    String? operationID,
  }) {
    final completer = Completer<List<UserStatusInfo>>();

    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getSubscribeUsersStatus failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getSubscribeUsersStatus success: $operationID, $errorCode, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map<UserStatusInfo>((e) => UserStatusInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_subscribe_users_status(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  // Function to get the status of specified users
  @override
  Future<List<UserStatusInfo>> getUserStatus(
    List<String> userIDs, {
    String? operationID,
  }) {
    final completer = Completer<List<UserStatusInfo>>();
    final param = jsonEncode(userIDs);

    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getUserStatus failed: $operationID, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getUserStatus success: $operationID, $errorCode, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map<UserStatusInfo>((e) => UserStatusInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_user_status(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      param.toNativeChar(),
    );

    return completer.future;
  }

  /// Get user information with cache
  /// [userIDs] List of user IDs
  @override
  Future<List<PublicUserInfo>> getUsersInfoWithCache(
    List<String> userIDs, {
    String? operationID,
  }) {
    return getUsersInfo(userIDs, operationID: operationID);
  }

  /// Set global message reception option
  /// [status] 0: Normal; 1: Do not accept messages; 2: Accept online messages but not offline messages;
  @override
  Future<bool> setGlobalRecvMessageOpt({
    required int status,
    String? operationID,
  }) {
    return setSelfInfo(globalRecvMsgOpt: status, operationID: operationID);
  }

  @override
  String getLoginUserID({String? operationID}) {
    return _bindings.get_login_user().toDartString();
  }

  @override
  void setListener<T extends Listener>(T listener) {
    ListenerManager().addListener(listener);
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    ListenerManager().removeListener(listener);
  }
}
