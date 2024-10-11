import '/enum/enum.dart';
import '/interface/base/base_conversation.dart';
import '/listener/listener.dart';
import '/model/conversation_info.dart';
import '/model/update_req.dart';

class WebConversation implements BaseConversation {
  @override
  Future changeInputStates({required String conversationID, required bool focus, String? operationID}) {
    // TODO: implement changeInputStates
    throw UnimplementedError();
  }

  @override
  Future clearConversationAndDeleteAllMsg({required String conversationID, String? operationID}) {
    // TODO: implement clearConversationAndDeleteAllMsg
    throw UnimplementedError();
  }

  @override
  Future deleteAllConversationFromLocal({String? operationID}) {
    // TODO: implement deleteAllConversationFromLocal
    throw UnimplementedError();
  }

  @override
  Future deleteConversationAndDeleteAllMsg({required String conversationID, String? operationID}) {
    // TODO: implement deleteConversationAndDeleteAllMsg
    throw UnimplementedError();
  }

  @override
  Future<List<ConversationInfo>> getAllConversationList({String? operationID}) {
    // TODO: implement getAllConversationList
    throw UnimplementedError();
  }

  @override
  String getAtAllTag({String? operationID}) {
    // TODO: implement getAtAllTag
    throw UnimplementedError();
  }

  @override
  Future<List<ConversationInfo>> getConversationListSplit({int offset = 0, int count = 20, String? operationID}) {
    // TODO: implement getConversationListSplit
    throw UnimplementedError();
  }

  @override
  Future<List<int>?> getInputStates(String conversationID, String userID, {String? operationID}) {
    // TODO: implement getInputStates
    throw UnimplementedError();
  }

  @override
  Future<List<ConversationInfo>> getMultipleConversation({required List<String> conversationIDs, String? operationID}) {
    // TODO: implement getMultipleConversation
    throw UnimplementedError();
  }

  @override
  Future<ConversationInfo> getOneConversation(
      {required String sourceID, required ConversationType sessionType, String? operationID}) {
    // TODO: implement getOneConversation
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalUnreadMsgCount({String? operationID}) {
    // TODO: implement getTotalUnreadMsgCount
    throw UnimplementedError();
  }

  @override
  Future hideAllConversations({String? operationID}) {
    // TODO: implement hideAllConversations
    throw UnimplementedError();
  }

  @override
  Future hideConversation({required String conversationID, String? operationID}) {
    // TODO: implement hideConversation
    throw UnimplementedError();
  }

  @override
  Future markConversationMessageAsRead({required String conversationID, String? operationID}) {
    // TODO: implement markConversationMessageAsRead
    throw UnimplementedError();
  }

  @override
  Future pinConversation({required String conversationID, required bool isPinned, String? operationID}) {
    // TODO: implement pinConversation
    throw UnimplementedError();
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    // TODO: implement removeListener
  }

  @override
  Future resetConversationGroupAtType({required String conversationID, String? operationID}) {
    // TODO: implement resetConversationGroupAtType
    throw UnimplementedError();
  }

  @override
  Future setConversation(String conversationID, ConversationReq req, {String? operationID}) {
    // TODO: implement setConversation
    throw UnimplementedError();
  }

  @override
  Future setConversationBurnDuration({required String conversationID, int burnDuration = 30, String? operationID}) {
    // TODO: implement setConversationBurnDuration
    throw UnimplementedError();
  }

  @override
  Future setConversationDraft({required String conversationID, required String draftText, String? operationID}) {
    // TODO: implement setConversationDraft
    throw UnimplementedError();
  }

  @override
  Future setConversationEx(String conversationID, {String? ex, String? operationID}) {
    // TODO: implement setConversationEx
    throw UnimplementedError();
  }

  @override
  Future setConversationIsMsgDestruct(
      {required String conversationID, bool isMsgDestruct = true, String? operationID}) {
    // TODO: implement setConversationIsMsgDestruct
    throw UnimplementedError();
  }

  @override
  Future setConversationMsgDestructTime(
      {required String conversationID, int duration = 1 * 24 * 60 * 60, String? operationID}) {
    // TODO: implement setConversationMsgDestructTime
    throw UnimplementedError();
  }

  @override
  Future setConversationPrivateChat({required String conversationID, required bool isPrivate, String? operationID}) {
    // TODO: implement setConversationPrivateChat
    throw UnimplementedError();
  }

  @override
  Future setConversationRecvMessageOpt({required String conversationID, required int status, String? operationID}) {
    // TODO: implement setConversationRecvMessageOpt
    throw UnimplementedError();
  }

  @override
  void setListener<T extends Listener>(T listener) {
    // TODO: implement setListener
  }

  @override
  List<ConversationInfo> simpleSort(List<ConversationInfo> list) {
    // TODO: implement simpleSort
    throw UnimplementedError();
  }
}
