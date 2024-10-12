import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:flutter/foundation.dart';
import '../../enum/enum.dart';
import '/listener/listener.dart';
import '/listener/manager.dart';
import '/utils/sdk_bindings.dart';

import '../../model/search_info.dart';
import '../../model/update_req.dart';
import '../../model/user_info.dart';
import '../../utils/define.dart';
import '../../utils/utils.dart';
import '../base/base_friendship.dart';

class NativeFriendship extends BaseFriendship {
  final _bindings = SDKBindings().bindings;

  @override
  Future<bool> acceptFriendApplication({
    required String userID,
    String? handleMsg,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'acceptFriendApplication failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('acceptFriendApplication success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);
    final options = {
      'toUserID': userID,
      'handleMsg': handleMsg,
    };
    _bindings.accept_friend_application(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> addBlacklist({
    required String userID,
    String? ex,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'addBlacklist failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('addBlacklist success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.add_black(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      userID.toNativeChar(),
      ex?.toNativeChar() ?? ''.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> addFriend({
    required String userID,
    String? reason,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'addFriend failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('addFriend success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'toUserID': userID,
      'reqMsg': reason,
    };

    _bindings.add_friend(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<FriendshipInfo>> checkFriend({
    required List<String> userIDs,
    String? operationID,
  }) {
    final completer = Completer<List<FriendshipInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'checkFriend failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('checkFriend success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString()).map((e) => FriendshipInfo.fromJson(e)).toList();
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.check_friend(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(userIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> deleteFriend({
    required String userID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'deleteFriend failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('deleteFriend success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.delete_friend(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      userID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<BlacklistInfo>> getBlacklist({
    String? operationID,
  }) {
    final completer = Completer<List<BlacklistInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'getBlacklist failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getBlacklist success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString()).map((e) => BlacklistInfo.fromJson(e)).toList();
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_black_list(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<FriendApplicationInfo>> getFriendApplicationListAsApplicant({
    String? operationID,
  }) {
    final completer = Completer<List<FriendApplicationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'getFriendApplicationListAsApplicant failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getFriendApplicationListAsApplicant success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString()).map((e) => FriendApplicationInfo.fromJson(e)).toList();
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_friend_application_list_as_applicant(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<FriendApplicationInfo>> getFriendApplicationListAsRecipient({
    String? operationID,
  }) {
    final completer = Completer<List<FriendApplicationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'getFriendApplicationListAsRecipient failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getFriendApplicationListAsRecipient success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString()).map((e) => FriendApplicationInfo.fromJson(e)).toList();
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_friend_application_list_as_recipient(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<PublicUserInfo>?> getFriendList({
    String? operationID,
    bool filterBlack = false,
  }) async {
    final data = await getFriendListMap(operationID: operationID, filterBlack: filterBlack);
    final result = data?.map((e) => PublicUserInfo.fromJson(e)).toList();

    return result;
  }

  @override
  Future<List<Map<String, dynamic>>?> getFriendListMap({
    bool filterBlack = false,
    String? operationID,
  }) {
    final completer = Completer<List<Map<String, dynamic>>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'getFriendListMap failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getFriendListMap success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString());
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_friend_list(
        callback.nativeFunction, Utils.reviseToNativeOperationID(operationID), filterBlack ? 1 : 0);

    return completer.future;
  }

  @override
  Future<List<PublicUserInfo>?> getFriendListPage({
    bool filterBlack = false,
    int offset = 0,
    int count = 40,
    String? operationID,
  }) async {
    final data =
        await getFriendListPageMap(operationID: operationID, filterBlack: filterBlack, offset: offset, count: count);
    final result = data?.map((e) => PublicUserInfo.fromJson(e)).toList();

    return result;
  }

  @override
  Future<List<Map<String, dynamic>>?> getFriendListPageMap({
    bool filterBlack = false,
    String? operationID,
    int offset = 0,
    int count = 40,
  }) {
    final completer = Completer<List<Map<String, dynamic>>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'getFriendListPageMap failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getFriendListPageMap success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString());
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_friend_list_page(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      offset,
      count,
      filterBlack ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<List<PublicUserInfo>> getFriendsInfo({
    required List<String> userIDs,
    bool filterBlack = false,
    String? operationID,
  }) {
    final completer = Completer<List<PublicUserInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'getFriendsInfo failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getFriendsInfo success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString()).map((e) => PublicUserInfo.fromJson(e)).toList();
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_specified_friends_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(userIDs).toNativeChar(),
      filterBlack ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<bool> refuseFriendApplication({
    required String userID,
    String? handleMsg,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'refuseFriendApplication failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('refuseFriendApplication success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'toUserID': userID,
      'handleMsg': handleMsg,
    };
    _bindings.refuse_friend_application(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> removeBlacklist({
    required String userID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'removeBlacklist failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('removeBlacklist success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.remove_black(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      userID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<SearchFriendsInfo>> searchFriends({
    List<String> keywords = const [],
    bool isSearchUserID = false,
    bool isSearchNickname = false,
    bool isSearchRemark = false,
    String? operationID,
  }) {
    final completer = Completer<List<SearchFriendsInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'searchFriends failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('searchFriends success: ${operationID.toDartString()}');
        final result = jsonDecode(data.toDartString()).map((e) => SearchFriendsInfo.fromJson(e)).toList();
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'keywordList': keywords,
      'isSearchUserID': isSearchUserID,
      'isSearchNickname': isSearchNickname,
      'isSearchRemark': isSearchRemark,
    };

    _bindings.search_friends(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<void> setFriendRemark({
    required String userID,
    required String remark,
    String? operationID,
  }) {
    final completer = Completer<void>();
    final req = UpdateFriendsReq(friendUserIDs: [userID], remark: remark);
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'setFriendRemark failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('setFriendRemark success: ${operationID.toDartString()}');
        completer.complete();
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.update_friends(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(req.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setFriendsEx(
    List<String> friendIDs, {
    String? ex,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    final req = UpdateFriendsReq(friendUserIDs: friendIDs, ex: ex);
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'setFriendsEx failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('setFriendsEx success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.update_friends(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(req.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> updateFriends(
    UpdateFriendsReq updateFriendsReq, {
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
          'updateFriends failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}',
        );
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('updateFriends success: ${operationID.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.update_friends(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(updateFriendsReq.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    ListenerManager().removeListener(listener);
  }

  @override
  void setListener<T extends Listener>(T listener) {
    ListenerManager().addListener(listener);
  }
}
