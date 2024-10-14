import 'dart:async';
import 'dart:convert';

import '/listener/listener.dart';
import '/listener/manager.dart';
import '/utils/sdk_bindings.dart';

import '../../model/search_info.dart';
import '../../model/update_req.dart';
import '../../model/user_info.dart';
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    final options = {
      'toUserID': userID,
      'handleMsg': handleMsg,
    };
    _bindings.accept_friend_application(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.add_black(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    final options = {
      'toUserID': userID,
      'reqMsg': reason,
    };

    _bindings.add_friend(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<FriendshipInfo>?> checkFriend({
    required List<String> userIDs,
    String? operationID,
  }) {
    final completer = Completer<List<FriendshipInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map((e) => FriendshipInfo.fromJson(e)).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.check_friend(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.delete_friend(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      userID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<BlacklistInfo>?> getBlacklist({
    String? operationID,
  }) {
    final completer = Completer<List<BlacklistInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map((e) => BlacklistInfo.fromJson(e)).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_black_list(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<FriendApplicationInfo>?> getFriendApplicationListAsApplicant({
    String? operationID,
  }) {
    final completer = Completer<List<FriendApplicationInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map((e) => FriendApplicationInfo.fromJson(e)).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_friend_application_list_as_applicant(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<FriendApplicationInfo>?> getFriendApplicationListAsRecipient({
    String? operationID,
  }) {
    final completer = Completer<List<FriendApplicationInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map((e) => FriendApplicationInfo.fromJson(e)).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_friend_application_list_as_recipient(
      callback,
      Utils.reviseToNativeOperationID(operationID),
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    final options = {
      'toUserID': userID,
      'handleMsg': handleMsg,
    };
    _bindings.refuse_friend_application(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.remove_black(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map((e) => SearchFriendsInfo.fromJson(e)).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    final options = {
      'keywordList': keywords,
      'isSearchUserID': isSearchUserID,
      'isSearchNickname': isSearchNickname,
      'isSearchRemark': isSearchRemark,
    };

    _bindings.search_friends(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setFriendRemark({
    required String userID,
    required String remark,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    final req = UpdateFriendsReq(friendUserIDs: [userID], remark: remark);
    _bindings.update_friends(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    final req = UpdateFriendsReq(friendUserIDs: friendIDs, ex: ex);
    _bindings.update_friends(
      callback,
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.update_friends(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(updateFriendsReq.toJson()).toNativeChar(),
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

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map((e) => PublicUserInfo.fromJson(e)).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_specified_friends_info(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(userIDs).toNativeChar(),
      filterBlack ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<List<FriendInfo>?> getFriendList({
    String? operationID,
    bool filterBlack = false,
  }) {
    return getFriendListMap(operationID: operationID, filterBlack: filterBlack).then((value) {
      return value?.map((e) => FriendInfo.fromJson(e)).toList();
    });
  }

  @override
  Future<List<Map<String, dynamic>>?> getFriendListMap({
    bool filterBlack = false,
    String? operationID,
  }) {
    final completer = Completer<List<Map<String, dynamic>>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map<Map<String, dynamic>>((e) => e as Map<String, dynamic>).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_friend_list(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      filterBlack ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<List<FriendInfo>?> getFriendListPage({
    bool filterBlack = false,
    int offset = 0,
    int count = 40,
    String? operationID,
  }) {
    return getFriendListPageMap(operationID: operationID, filterBlack: filterBlack, offset: offset, count: count)
        .then((value) {
      return value?.map((e) => FriendInfo.fromJson(e)).toList();
    });
  }

  @override
  Future<List<Map<String, dynamic>>?> getFriendListPageMap({
    bool filterBlack = false,
    String? operationID,
    int offset = 0,
    int count = 40,
  }) {
    final completer = Completer<List<Map<String, dynamic>>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final result = (data as List?)?.map<Map<String, dynamic>>((e) => e as Map<String, dynamic>).toList() ?? [];
        completer.complete(result);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_friend_list_page(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      offset,
      count,
      filterBlack ? 1 : 0,
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
