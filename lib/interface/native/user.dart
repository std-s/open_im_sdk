import 'dart:async';
import 'dart:convert';

import '../../listener/listener.dart';
import '../../listener/manager.dart';
import '../../utils/utils.dart';

import '../../model/user_info.dart';
import '../../utils/sdk_bindings.dart';
import '../base/base_user.dart';

class NativeUser extends BaseUser {
  final _bindings = SDKBindings().bindings;

  // Function to get user information based on user IDs
  @override
  Future<List<PublicUserInfo>> getUsersInfo(List<String> userIDs, {String? operationID}) {
    final param = jsonEncode(userIDs);
    final completer = Completer<List<PublicUserInfo>>();

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = (data as List?)?.map((e) => PublicUserInfo.fromJson(e)).toList();
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.get_users_info(
      callbackPointer,
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

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(UserInfo.fromJson(data));
        },
        onError: (error) => completer.completeError(error));

    _bindings.get_self_user_info(
      callbackPointer,
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

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    final options = {
      'nickname': nickname,
      'faceURL': faceURL,
      'globalRecvMsgOpt': globalRecvMsgOpt,
      'ex': ex,
    };

    _bindings.set_self_info(
      callbackPointer,
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

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = (data as List?)?.map<UserStatusInfo>((e) => UserStatusInfo.fromJson(e)).toList() ?? [];
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.subscribe_users_status(
      callbackPointer,
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

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (_) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.unsubscribe_users_status(
      callbackPointer,
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

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = (data as List?)?.map<UserStatusInfo>((e) => UserStatusInfo.fromJson(e)).toList() ?? [];
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.get_subscribe_users_status(
      callbackPointer,
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

    final callbackPointer = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = (data as List?)?.map<UserStatusInfo>((e) => UserStatusInfo.fromJson(e)).toList() ?? [];
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.get_user_status(
      callbackPointer,
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
