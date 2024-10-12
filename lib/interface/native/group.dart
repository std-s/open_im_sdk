import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:async';

import '/enum/enum.dart';
import '/interface/base/base_group.dart';
import '/listener/listener.dart';
import '/listener/manager.dart';

import '../../model/group_info.dart';
import '../../utils/utils.dart';

import '../../utils/define.dart';
import '../../utils/sdk_bindings.dart';

import 'package:flutter/foundation.dart'; // For debugPrint

class NativeGroup extends BaseGroup {
  NativeGroup();

  final _bindings = SDKBindings().bindings;

  @override
  Future<List<GroupInviteResult>> inviteUserToGroup({
    required String groupID,
    required List<String> userIDs,
    String? reason,
    String? operationID,
  }) {
    final completer = Completer<List<GroupInviteResult>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('inviteUserToGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('inviteUserToGroup success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString()).map((e) => GroupInviteResult.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.invite_user_to_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      reason?.toNativeChar() ?? ''.toNativeChar(),
      jsonEncode(userIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupInviteResult>> kickGroupMember({
    required String groupID,
    required List<String> userIDs,
    String? reason,
    String? operationID,
  }) {
    final completer = Completer<List<GroupInviteResult>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('kickGroupMember failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('kickGroupMember success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString()).map((e) => GroupInviteResult.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.kick_group_member(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      reason?.toNativeChar() ?? ''.toNativeChar(),
      jsonEncode(userIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupMembersInfo>> getGroupMembersInfo({
    required String groupID,
    required List<String> userIDs,
    String? operationID,
  }) {
    final completer = Completer<List<GroupMembersInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getGroupMembersInfo failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getGroupMembersInfo success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString()).map((e) => GroupMembersInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_specified_group_members_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      jsonEncode(userIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupMembersInfo>> getGroupMemberList({
    required String groupID,
    GroupMemberFilter filter = GroupMemberFilter.all,
    int offset = 0,
    int count = 0,
    String? operationID,
  }) async {
    final data = await getGroupMemberListMap(
      groupID: groupID,
      filter: filter,
      offset: offset,
      count: count,
      operationID: operationID,
    );

    final result = data.map((e) => GroupMembersInfo.fromJson(e)).toList();

    return result;
  }

  @override
  Future<List<GroupInfo>?> getJoinedGroupList({String? operationID}) {
    final completer = Completer<List<GroupInfo>?>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getJoinedGroupList failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        final json = jsonDecode(data.toDartString()) as List?;
        final list = json?.map<GroupInfo>((e) => GroupInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_joined_group_list(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<GroupInfo?> createGroup({
    required GroupInfo groupInfo,
    List<String> memberUserIDs = const [],
    List<String> adminUserIDs = const [],
    String? ownerUserID,
    String? operationID,
  }) {
    final completer = Completer<GroupInfo>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('createGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        final result = GroupInfo.fromJson(jsonDecode(data.toDartString()));
        completer.complete(result);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'groupInfo': groupInfo.toJson(),
      'memberUserIDs': memberUserIDs,
      'adminUserIDs': adminUserIDs,
      'ownerUserID': ownerUserID,
    };
    _bindings.create_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setGroupInfo(GroupInfo groupInfo, {String? operationID}) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('setGroupInfo failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.set_group_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(groupInfo.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupApplicationInfo>> getGroupApplicationListAsRecipient({
    String? operationID,
  }) {
    final completer = Completer<List<GroupApplicationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getGroupApplicationListAsRecipient failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        final list =
            jsonDecode(data.toDartString()).map<GroupApplicationInfo>((e) => GroupApplicationInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_group_application_list_as_recipient(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<GroupApplicationInfo>> getGroupApplicationListAsApplicant({
    String? operationID,
  }) {
    final completer = Completer<List<GroupApplicationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getGroupApplicationListAsApplicant failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        final list =
            jsonDecode(data.toDartString()).map<GroupApplicationInfo>((e) => GroupApplicationInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_group_application_list_as_applicant(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<bool> acceptGroupApplication({
    required String groupID,
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
            'acceptGroupApplication failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.accept_group_application(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      userID.toNativeChar(),
      handleMsg?.toNativeChar() ?? ''.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> refuseGroupApplication({
    required String groupID,
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
            'refuseGroupApplication failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.refuse_group_application(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      userID.toNativeChar(),
      handleMsg?.toNativeChar() ?? ''.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> dismissGroup({
    required String groupID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('dismissGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.dismiss_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> changeGroupMute({
    required String groupID,
    required bool mute,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('changeGroupMute failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.change_group_mute(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      mute ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<bool> changeGroupMemberMute({
    required String groupID,
    required String userID,
    int seconds = 0,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'changeGroupMemberMute failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.change_group_member_mute(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      userID.toNativeChar(),
      seconds,
    );

    return completer.future;
  }

  @override
  Future<List<GroupMembersInfo>> getGroupMemberListByJoinTime({
    required String groupID,
    int offset = 0,
    int count = 0,
    int joinTimeBegin = 0,
    int joinTimeEnd = 0,
    List<String> filterUserIDs = const [],
    String? operationID,
  }) {
    final completer = Completer<List<GroupMembersInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getGroupMemberListByJoinTime failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');

        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getGroupMemberListByJoinTime success: ${operationID.toDartString()}, ${data.toDartString()}');

        final list =
            jsonDecode(data.toDartString()).map<GroupMembersInfo>((e) => GroupMembersInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_group_member_list_by_join_time_filter(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      offset,
      count,
      joinTimeBegin,
      joinTimeEnd,
      jsonEncode(filterUserIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<Map<String, dynamic>>> getGroupMemberListMap({
    required String groupID,
    GroupMemberFilter filter = GroupMemberFilter.all,
    int offset = 0,
    int count = 0,
    String? operationID,
  }) {
    final completer = Completer<List<Map<String, dynamic>>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getGroupMemberListMap failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getGroupMemberListMap success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString());
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_group_member_list(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      filter.index,
      offset,
      count,
    );

    return completer.future;
  }

  @override
  Future<List<GroupMembersInfo>> getGroupOwnerAndAdmin({
    required String groupID,
    String? operationID,
  }) {
    final completer = Completer<List<GroupMembersInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getGroupOwnerAndAdmin failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');

        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getGroupOwnerAndAdmin success: ${operationID.toDartString()}, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map((e) => GroupMembersInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_group_member_owner_and_admin(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupInfo>> getGroupsInfo({
    required List<String> groupIDs,
    String? operationID,
  }) {
    final completer = Completer<List<GroupInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getGroupsInfo failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getGroupsInfo success: ${operationID.toDartString()}, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map((e) => GroupInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_specified_groups_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(groupIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List> getJoinedGroupListMap({
    String? operationID,
  }) {
    final completer = Completer<List>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getJoinedGroupListMap failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getJoinedGroupListMap success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString());
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_joined_group_list(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<List<GroupInfo>> getJoinedGroupListPage({
    String? operationID,
    int offset = 0,
    int count = 40,
  }) {
    final completer = Completer<List<GroupInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getJoinedGroupListPage failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getJoinedGroupListPage success: ${operationID.toDartString()}, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map((e) => GroupInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_joined_group_list_page(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      offset,
      count,
    );

    return completer.future;
  }

  @override
  Future<bool> getUsersInGroup(
    String groupID,
    List<String> userIDs, {
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getUsersInGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getUsersInGroup success: ${operationID.toDartString()}, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_users_in_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      jsonEncode(userIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> isJoinedGroup({
    required String groupID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('isJoinedGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('isJoinedGroup success: ${operationID.toDartString()}, ${data.toDartString()}');
        completer.complete(data.toDartString() == 'true');
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.is_join_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> joinGroup({
    required String groupID,
    String? reason,
    String? operationID,
    JoinType joinSource = JoinType.search,
    String? ex,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('joinGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('joinGroup success: ${operationID.toDartString()}, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.join_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      reason?.toNativeChar() ?? ''.toNativeChar(),
      joinSource.rawValue,
      ex?.toNativeChar() ?? ''.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> quitGroup({
    required String groupID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('quitGroup failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('quitGroup success: ${operationID.toDartString()}, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.quit_group(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupMembersInfo>> searchGroupMembers(
      {required String groupID,
      List<String> keywords = const [],
      bool isSearchUserID = false,
      bool isSearchMemberNickname = false,
      int offset = 0,
      int count = 40,
      String? operationID}) async {
    final data = await searchGroupMembersListMap(
        groupID: groupID,
        keywords: keywords,
        isSearchUserID: isSearchUserID,
        isSearchMemberNickname: isSearchMemberNickname,
        offset: offset,
        count: count,
        operationID: operationID);

    return data.map((e) => GroupMembersInfo.fromJson(e)).toList();
  }

  @override
  Future<List> searchGroupMembersListMap({
    required String groupID,
    List<String> keywords = const [],
    bool isSearchUserID = false,
    bool isSearchMemberNickname = false,
    int offset = 0,
    int count = 40,
    String? operationID,
  }) {
    final completer = Completer<List>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('searchGroupMembers failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('searchGroupMembers success: ${operationID.toDartString()}, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString());
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'groupID': groupID,
      'keywordList': keywords,
      'isSearchUserID': isSearchUserID,
      'isSearchMemberNickname': isSearchMemberNickname,
      'offset': offset,
      'count': count,
    };

    _bindings.search_group_members(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<GroupInfo>> searchGroups({
    List<String> keywords = const [],
    bool isSearchGroupID = false,
    bool isSearchGroupName = false,
    String? operationID,
  }) {
    final completer = Completer<List<GroupInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('searchGroups failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('searchGroups success: ${operationID.toDartString()}, ${data.toDartString()}');
        final list = jsonDecode(data.toDartString()).map((e) => GroupInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    final options = {
      'keywordList': keywords,
      'isSearchGroupID': isSearchGroupID,
      'isSearchGroupName': isSearchGroupName,
    };

    _bindings.search_groups(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setGroupApplyMemberFriend({
    required String groupID,
    required int status,
    String? operationID,
  }) {
    final req = GroupInfo(groupID: groupID, applyMemberFriend: status);

    return setGroupInfo(req, operationID: operationID);
  }

  @override
  Future<bool> setGroupLookMemberInfo({required String groupID, required int status, String? operationID}) {
    final req = GroupInfo(groupID: groupID, lookMemberInfo: status);

    return setGroupInfo(req, operationID: operationID);
  }

  @override
  Future<bool> setGroupMemberInfo({
    required GroupMembersInfo groupMembersInfo,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('setGroupMemberInfo failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('setGroupMemberInfo success: ${operationID.toDartString()}, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.set_group_member_info(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(groupMembersInfo.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setGroupMemberNickname(
      {required String groupID, required String userID, String? groupNickname, String? operationID}) {
    final req = GroupMembersInfo(groupID: groupID, userID: userID, nickname: groupNickname);

    return setGroupMemberInfo(groupMembersInfo: req, operationID: operationID);
  }

  @override
  Future<bool> setGroupMemberRoleLevel(
      {required String groupID, required String userID, required int roleLevel, String? operationID}) {
    final req = GroupMembersInfo(groupID: groupID, userID: userID, roleLevel: roleLevel);

    return setGroupMemberInfo(groupMembersInfo: req, operationID: operationID);
  }

  @override
  Future<bool> setGroupVerification(
      {required String groupID, required GroupVerificationType needVerification, String? operationID}) {
    final req = GroupInfo(groupID: groupID, needVerification: needVerification.rawValue);

    return setGroupInfo(req, operationID: operationID);
  }

  @override
  Future<bool> transferGroupOwner({
    required String groupID,
    required String userID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('transferGroupOwner failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('transferGroupOwner success: ${operationID.toDartString()}, ${data.toDartString()}');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.transfer_group_owner(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      groupID.toNativeChar(),
      userID.toNativeChar(),
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
