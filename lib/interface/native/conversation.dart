import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:async';

import '/enum/enum.dart';
import '/listener/listener.dart';

import '/model/conversation_info.dart';

import '/model/update_req.dart';
import '../../listener/manager.dart';
import '../../utils/utils.dart';

import '../../utils/define.dart';
import '../../utils/sdk_bindings.dart';
import '../base/base_conversation.dart';

import 'package:flutter/foundation.dart'; // For debugPrint

class NativeConversation extends BaseConversation {
  final _bindings = SDKBindings().bindings;

  // Function to set burn duration for a conversation
  @override
  Future<bool> setConversationBurnDuration({
    required String conversationID,
    int burnDuration = 30,
    String? operationID,
  }) {
    final req = ConversationReq(burnDuration: burnDuration);

    return setConversation(conversationID, req, operationID: operationID);
  }

  // Function to change input states
  @override
  Future<bool> changeInputStates({
    required String conversationID,
    required bool focus,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('changeInputStates failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('changeInputStates success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    // _bindings.change_input_states(
    //   callback.nativeFunction,
    //   Utils.reviseToNativeOperationID(operationID),
    //   conversationID.toNativeUtf8(),
    //   focus ? 1 : 0, // Assuming native expects an int for boolean
    // );

    return completer.future;
  }

  // Function to clear conversation and delete all messages
  @override
  Future<bool> clearConversationAndDeleteAllMsg({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'clearConversationAndDeleteAllMsg failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('clearConversationAndDeleteAllMsg success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.clear_conversation_and_delete_all_msg(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  // Function to delete all conversations from local storage
  @override
  Future<bool> deleteAllConversationFromLocal({
    String? operationID,
  }) {
    return hideAllConversations(operationID: operationID);
  }

  // Function to delete a conversation and all its messages
  @override
  Future<bool> deleteConversationAndDeleteAllMsg({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'deleteConversationAndDeleteAllMsg failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('deleteConversationAndDeleteAllMsg success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.delete_conversation_and_delete_all_msg(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  // Function to get all conversation lists
  @override
  Future<List<ConversationInfo>> getAllConversationList({
    String? operationID,
  }) async {
    final completer = Completer<List<ConversationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getAllConversationList failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getAllConversationList success: ${operationID.toDartString()}, $errorCode');
        // Convert the received data into List<ConversationInfo>
        final list = jsonDecode(data.toDartString()).map((e) => ConversationInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_all_conversation_list(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  // Function to get 'At All' tag
  @override
  String getAtAllTag({
    String? operationID,
  }) {
    final opid = Utils.reviseToNativeOperationID(operationID);
    final tag = _bindings.get_at_all_tag(opid);

    return tag.toDartString();
  }

  // Function to get conversation list with pagination
  @override
  Future<List<ConversationInfo>> getConversationListSplit({
    int offset = 0,
    int count = 20,
    String? operationID,
  }) async {
    final completer = Completer<List<ConversationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getConversationListSplit failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getConversationListSplit success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString()).map((e) => ConversationInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_conversation_list_split(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      offset,
      count,
    );

    return completer.future;
  }

  // Function to get input states of a conversation
  @override
  Future<List<int>?> getInputStates(
    String conversationID,
    String userID, {
    String? operationID,
  }) async {
    final completer = Completer<List<int>?>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getInputStates failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getInputStates success: ${operationID.toDartString()}, $errorCode');
        final states = jsonDecode(data.toDartString()).map((e) => e as int).toList();
        completer.complete(states);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_input_states(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      userID.toNativeChar(),
    );

    return completer.future;
  }

  // Function to get multiple conversations
  @override
  Future<List<ConversationInfo>> getMultipleConversation({
    required List<String> conversationIDs,
    String? operationID,
  }) async {
    final completer = Completer<List<ConversationInfo>>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getMultipleConversation failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getMultipleConversation success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString()).map((e) => ConversationInfo.fromJson(e)).toList();
        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_multiple_conversation(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(conversationIDs).toNativeChar(),
    );

    return completer.future;
  }

  // Function to get one conversation
  @override
  Future<ConversationInfo> getOneConversation({
    required String sourceID,
    required ConversationType sessionType,
    String? operationID,
  }) async {
    final completer = Completer<ConversationInfo>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('getOneConversation failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getOneConversation success: ${operationID.toDartString()}, $errorCode');
        final list = jsonDecode(data.toDartString()).map((e) => ConversationInfo.fromJson(e)).toList();

        completer.complete(list);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_one_conversation(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      sessionType.rawValue,
      sourceID.toNativeChar(),
    );

    return completer.future;
  }

  // Function to get total unread message count
  @override
  Future<int> getTotalUnreadMsgCount({
    String? operationID,
  }) async {
    final completer = Completer<int>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'getTotalUnreadMsgCount failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('getTotalUnreadMsgCount success: ${operationID.toDartString()}, $errorCode');
        completer.complete(data.address); // Assuming data contains the count as an integer
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.get_total_unread_msg_count(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  // Function to hide all conversations
  @override
  Future<bool> hideAllConversations({
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'hideAllConversations failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('hideAllConversations success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.hide_all_conversations(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  // Function to hide a specific conversation
  @override
  Future<bool> hideConversation({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('hideConversation failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('hideConversation success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.hide_conversation(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  // Function to mark a conversation's messages as read
  @override
  Future<bool> markConversationMessageAsRead({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'markConversationMessageAsRead failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('markConversationMessageAsRead success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.mark_conversation_message_as_read(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  // Function to pin a conversation
  @override
  Future<bool> pinConversation({
    required String conversationID,
    required bool isPinned,
    String? operationID,
  }) {
    final req = ConversationReq(isPinned: isPinned);

    return setConversation(conversationID, req, operationID: operationID);
  }

  // Function to reset conversation group AT type
  @override
  Future<bool> resetConversationGroupAtType({
    required String conversationID,
    String? operationID,
  }) {
    final req = ConversationReq(groupAtType: 0);

    return setConversation(conversationID, req, operationID: operationID);
  }

  // Function to set conversation settings
  @override
  Future<bool> setConversation(
    String conversationID,
    ConversationReq req, {
    String? operationID,
  }) async {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint('setConversation failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('setConversation success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.set_conversation(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      jsonEncode(req.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  // Function to set conversation draft
  @override
  Future<bool> setConversationDraft({
    required String conversationID,
    required String draftText,
    String? operationID,
  }) {
    final completer = Completer<bool>();
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
        ffi.Pointer<ffi.Char> operationID, int errorCode, ffi.Pointer<ffi.Char> errorMsg, ffi.Pointer<ffi.Char> data) {
      if (errorCode > 0) {
        debugPrint(
            'setConversationDraft failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        completer.completeError(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));
      } else {
        debugPrint('setConversationDraft success: ${operationID.toDartString()}, $errorCode');
        completer.complete(true);
      }

      callback.close();
    }

    callback = ffi.NativeCallable<CBSISSFunc>.listener(onResponse);

    _bindings.set_conversation_draft(
      callback.nativeFunction,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      draftText.toNativeChar(),
    );

    return completer.future;
  }

  // Function to set conversation extension data
  @override
  Future<bool> setConversationEx(
    String conversationID, {
    String? ex,
    String? operationID,
  }) {
    final req = ConversationReq(ex: ex);

    return setConversation(conversationID, req, operationID: operationID);
  }

  // Function to set whether the conversation messages are destructed
  @override
  Future<bool> setConversationIsMsgDestruct({
    required String conversationID,
    bool isMsgDestruct = true,
    String? operationID,
  }) {
    final req = ConversationReq(isMsgDestruct: isMsgDestruct);

    return setConversation(conversationID, req, operationID: operationID);
  }

  @override
  Future<bool> setConversationMsgDestructTime({
    required String conversationID,
    int duration = 1 * 24 * 60 * 60,
    String? operationID,
  }) {
    final req = ConversationReq(msgDestructTime: duration);

    return setConversation(conversationID, req, operationID: operationID);
  }

  @override
  Future<bool> setConversationPrivateChat({
    required String conversationID,
    required bool isPrivate,
    String? operationID,
  }) {
    final req = ConversationReq(isPrivateChat: isPrivate);

    return setConversation(conversationID, req, operationID: operationID);
  }

  @override
  Future<bool> setConversationRecvMessageOpt({
    required String conversationID,
    required int status,
    String? operationID,
  }) {
    final req = ConversationReq(recvMsgOpt: status);

    return setConversation(conversationID, req, operationID: operationID);
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    ListenerManager().removeListener(listener);
  }

  @override
  void setListener<T extends Listener>(T listener) {
    ListenerManager().addListener(listener);
  }

  @override
  List<ConversationInfo> simpleSort(List<ConversationInfo> list) => list
    ..sort((a, b) {
      if ((a.isPinned == true && b.isPinned == true) || (a.isPinned != true && b.isPinned != true)) {
        int aCompare = a.draftTextTime! > a.latestMsgSendTime! ? a.draftTextTime! : a.latestMsgSendTime!;
        int bCompare = b.draftTextTime! > b.latestMsgSendTime! ? b.draftTextTime! : b.latestMsgSendTime!;
        if (aCompare > bCompare) {
          return -1;
        } else if (aCompare < bCompare) {
          return 1;
        } else {
          return 0;
        }
      } else if (a.isPinned == true && b.isPinned != true) {
        return -1;
      } else {
        return 1;
      }
    });
}
