import '../../enum/enum.dart';
import '../../model/conversation_info.dart';
import '../../model/update_req.dart';
import 'base_listener.dart';

abstract class BaseConversation implements BaseListener {
  /// Retrieves all conversations.
  Future<List<ConversationInfo>> getAllConversationList({
    String? operationID,
  });

  /// Retrieves conversations with pagination.
  /// [offset] Starting index.
  /// [count] Number of items per page.
  Future<List<ConversationInfo>> getConversationListSplit({
    int offset = 0,
    int count = 20,
    String? operationID,
  });

  /// Retrieves a conversation. If the conversation does not exist, it will be created automatically.
  /// [sourceID] If it's a one-on-one conversation, pass userID; if it's a group conversation, pass GroupID.
  /// [sessionType] Reference to [ConversationType].
  Future<ConversationInfo> getOneConversation({
    required String sourceID,
    required ConversationType sessionType,
    String? operationID,
  });

  /// Retrieves multiple conversations by their IDs.
  /// [conversationIDList] List of conversation IDs.
  Future<List<ConversationInfo>> getMultipleConversation({
    required List<String> conversationIDs,
    String? operationID,
  });

  /// Sets the draft for a conversation.
  /// [conversationID] Conversation ID.
  /// [draftText] Draft content.
  Future<bool> setConversationDraft({
    required String conversationID,
    required String draftText,
    String? operationID,
  });

  /// Pins or unpins a conversation.
  /// [conversationID] Conversation ID.
  /// [isPinned] true: pin; false: unpin.
  @Deprecated('use [setConversation] instead')
  Future<bool> pinConversation({
    required String conversationID,
    required bool isPinned,
    String? operationID,
  });

  /// Hides a conversation.
  /// [conversationID] Conversation ID.
  Future<bool> hideConversation({
    required String conversationID,
    String? operationID,
  });

  /// Hides all conversations.
  Future<bool> hideAllConversations({
    String? operationID,
  });

  /// Retrieves the total count of unread messages.
  Future<int> getTotalUnreadMsgCount({
    String? operationID,
  });

  /// Sets message reception options for a conversation.
  /// [conversationID] Conversation ID.
  /// [status] 0: normal; 1: do not accept messages; 2: accept online messages but not offline messages.
  @Deprecated('use [setConversation] instead')
  Future<bool> setConversationRecvMessageOpt({
    required String conversationID,
    required int status,
    String? operationID,
  });

  /// Enables or disables self-destructing messages for a conversation.
  /// [conversationID] Conversation ID.
  /// [isPrivate] true: enable; false: disable.
  @Deprecated('use [setConversation] instead')
  Future<bool> setConversationPrivateChat({
    required String conversationID,
    required bool isPrivate,
    String? operationID,
  });

  /// Deletes the conversation and all messages from both local and server.
  /// [conversationID] Conversation ID.
  Future<bool> deleteConversationAndDeleteAllMsg({
    required String conversationID,
    String? operationID,
  });

  /// Clears all messages from a conversation.
  /// [conversationID] Conversation ID.
  Future<bool> clearConversationAndDeleteAllMsg({
    required String conversationID,
    String? operationID,
  });

  /// Deletes all local conversations.
  @Deprecated('use hideAllConversations instead')
  Future<bool> deleteAllConversationFromLocal({
    String? operationID,
  });

  /// Resets the group mention status.
  /// [conversationID] Conversation ID.
  @Deprecated('use [setConversation] instead')
  Future<bool> resetConversationGroupAtType({
    required String conversationID,
    String? operationID,
  });

  /// Retrieves the "mention all" tag.
  String getAtAllTag({
    String? operationID,
  });

  /// Sets the burn duration for self-destructing messages.
  /// [conversationID] Conversation ID.
  /// [burnDuration] Duration in seconds, default is 30 seconds.
  @Deprecated('use [setConversation] instead')
  Future<bool> setConversationBurnDuration({
    required String conversationID,
    int burnDuration = 30,
    String? operationID,
  });

  /// Marks messages as read.
  /// [conversationID] Conversation ID.
  Future<bool> markConversationMessageAsRead({
    required String conversationID,
    String? operationID,
  });

  /// Enables or disables periodic deletion of messages.
  /// [conversationID] Conversation ID.
  /// [isMsgDestruct] true: enable.
  @Deprecated('use [setConversation] instead')
  Future<bool> setConversationIsMsgDestruct({
    required String conversationID,
    bool isMsgDestruct = true,
    String? operationID,
  });

  /// Sets the message destruct time for periodic deletion.
  /// [conversationID] Conversation ID.
  /// [duration] Duration in seconds.
  @Deprecated('use [setConversation] instead')
  Future<bool> setConversationMsgDestructTime({
    required String conversationID,
    int duration = 1 * 24 * 60 * 60,
    String? operationID,
  });

  /// Sets extended information for a conversation.
  Future<bool> setConversationEx(
    String conversationID, {
    String? ex,
    String? operationID,
  });

  /// Custom sorting for conversation list.
  List<ConversationInfo> simpleSort(List<ConversationInfo> list);

  /// Changes the input state for a conversation.
  Future<bool> changeInputStates({
    required String conversationID,
    required bool focus,
    String? operationID,
  });

  /// Retrieves the input states for a conversation.
  Future<List<int>?> getInputStates(
    String conversationID,
    String userID, {
    String? operationID,
  });

  /// Sets the conversation with a request object.
  Future<bool> setConversation(
    String conversationID,
    ConversationReq req, {
    String? operationID,
  });
}
