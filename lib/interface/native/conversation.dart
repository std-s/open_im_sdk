import 'dart:convert';
import 'dart:async';

import '/enum/enum.dart';
import '/listener/listener.dart';

import '/model/conversation_info.dart';

import '/model/update_req.dart';
import '../../listener/manager.dart';
import '../../utils/utils.dart';

import '../../utils/sdk_bindings.dart';
import '../base/base_conversation.dart';

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
  Future<bool> clearConversationAndDeleteAllMsg({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.clear_conversation_and_delete_all_msg(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> deleteAllConversationFromLocal({
    String? operationID,
  }) {
    return hideAllConversations(operationID: operationID);
  }

  @override
  Future<bool> deleteConversationAndDeleteAllMsg({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.delete_conversation_and_delete_all_msg(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<List<ConversationInfo>?> getAllConversationList({
    String? operationID,
  }) async {
    final completer = Completer<List<ConversationInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final list = (data as List?)?.map((e) => ConversationInfo.fromJson(e)).toList() ?? [];
        completer.complete(list);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_all_conversation_list(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  String getAtAllTag({
    String? operationID,
  }) {
    final opid = Utils.reviseToNativeOperationID(operationID);
    final tag = _bindings.get_at_all_tag(opid);
    return tag.toDartString();
  }

  @override
  Future<List<ConversationInfo>?> getConversationListSplit({
    int offset = 0,
    int count = 20,
    String? operationID,
  }) async {
    final completer = Completer<List<ConversationInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final list = (data as List?)?.map((e) => ConversationInfo.fromJson(e)).toList() ?? [];
        completer.complete(list);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_conversation_list_split(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      offset,
      count,
    );

    return completer.future;
  }

  @override
  Future<List<int>?> getInputStates(
    String conversationID,
    String userID, {
    String? operationID,
  }) async {
    final completer = Completer<List<int>?>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final states = (data as List?)?.map((e) => e as int).toList() ?? [];
        completer.complete(states);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_input_states(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      userID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> changeInputStates({
    required String conversationID,
    required bool focus,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.change_input_states(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      focus ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<List<ConversationInfo>?> getMultipleConversation({
    required List<String> conversationIDs,
    String? operationID,
  }) async {
    final completer = Completer<List<ConversationInfo>>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) {
        final list = (data as List?)?.map((e) => ConversationInfo.fromJson(e)).toList() ?? [];
        completer.complete(list);
      },
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_multiple_conversation(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(conversationIDs).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<ConversationInfo?> getOneConversation({
    required String sourceID,
    required ConversationType sessionType,
    String? operationID,
  }) async {
    final completer = Completer<ConversationInfo>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) => completer.complete(ConversationInfo.fromJson(data)),
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_one_conversation(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      sessionType.rawValue,
      sourceID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<int> getTotalUnreadMsgCount({
    String? operationID,
  }) async {
    final completer = Completer<int>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (data) => completer.complete(data.address),
      onError: (error) => completer.completeError(error),
    );

    _bindings.get_total_unread_msg_count(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<bool> hideAllConversations({
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.hide_all_conversations(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<bool> hideConversation({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.hide_conversation(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> markConversationMessageAsRead({
    required String conversationID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.mark_conversation_message_as_read(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setConversation(
    String conversationID,
    ConversationReq req, {
    String? operationID,
  }) async {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.set_conversation(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      jsonEncode(req.toJson()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setConversationDraft({
    required String conversationID,
    required String draftText,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
      onSuccess: (_) => completer.complete(true),
      onError: (error) => completer.completeError(error),
    );

    _bindings.set_conversation_draft(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      draftText.toNativeChar(),
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
