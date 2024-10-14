import '../../model/message.dart';
import '../../model/search_info.dart';
import 'base_listener.dart';

abstract class BaseMessage implements BaseListener {
  /// Send a message
  /// [message] Message content
  /// [userID] User ID of the recipient
  /// [groupID] Group ID of the recipient
  /// [offlinePushInfo] Offline message display content
  Future<Message?> sendMessage({
    required Message message,
    required OfflinePushInfo offlinePushInfo,
    String? userID,
    String? groupID,
    bool isOnlineOnly = false,
    String? operationID,
  });

  /// Send a message
  /// [message] Message body [createImageMessageByURL],[createSoundMessageByURL],[createVideoMessageByURL],[createFileMessageByURL]
  /// [userID] User ID to receive the message
  /// [groupID] Group ID to receive the message
  /// [offlinePushInfo] Offline message display content
  Future<Message?> sendMessageNotOss({
    required Message message,
    required OfflinePushInfo offlinePushInfo,
    String? userID,
    String? groupID,
    bool isOnlineOnly = false,
    String? operationID,
  });

  /// Delete a message from local storage
  /// [message] Message to be deleted
  Future<bool> deleteMessageFromLocalStorage({
    required String conversationID,
    required String clientMsgID,
    String? operationID,
  });

  /// Delete a specified message from local and server
  /// [message] Message to be deleted
  Future<bool> deleteMessageFromLocalAndSvr({
    required String conversationID,
    required String clientMsgID,
    String? operationID,
  });

  /// Delete all local chat records
  Future<bool> deleteAllMsgFromLocal({
    String? operationID,
  });

  /// Delete all chat records from local and server
  Future<bool> deleteAllMsgFromLocalAndSvr({
    String? operationID,
  });

  /// Insert a single chat message into local storage
  /// [receiverID] Receiver's ID
  /// [senderID] Sender's ID
  /// [message] Message content
  Future<Message?> insertSingleMessageToLocalStorage({
    required Message message,
    String? receiverID,
    String? senderID,
    String? operationID,
  });

  /// Insert a group chat message into local storage
  /// [groupID] Group ID
  /// [senderID] Sender's ID
  /// [message] Message content
  Future<Message?> insertGroupMessageToLocalStorage({
    required Message message,
    String? groupID,
    String? senderID,
    String? operationID,
  });

  /// Search messages
  /// [conversationID] Query based on conversation, pass null for global search
  /// [keywords] Search keyword list, currently supports searching with a single keyword
  /// [keywordListMatchType] Keyword matching mode, 1 means AND, 2 means OR (currently unused)
  /// [senderUserIDs] List of UIDs for messages sent (currently unused)
  /// [messageTypes] Message type list
  /// [searchTimePosition] Start time point for searching. Defaults to 0, meaning searching from now. UTC timestamp, in seconds
  /// [searchTimePeriod] Time range in the past from the start time point, in seconds. Defaults to 0, meaning no time range limitation. Pass 24x60x60 to represent the past day
  /// [pageIndex] Current page number
  /// [count] Number of messages per page
  Future<SearchResult> searchLocalMessages({
    String? conversationID,
    List<String> keywords = const [],
    int keywordListMatchType = 0,
    List<String> senderUserIDs = const [],
    List<int> messageTypes = const [],
    int searchTimePosition = 0,
    int searchTimePeriod = 0,
    int pageIndex = 1,
    int count = 40,
    String? operationID,
  });

  /// Revoke a message
  /// [message] The message to be revoked
  Future<bool> revokeMessage({
    required String conversationID,
    required String clientMsgID,
    String? operationID,
  });

  /// Get chat history (messages prior to startMsg)
  /// [conversationID] Conversation ID, can be used for querying notifications
  /// [startMsg] Query [count] messages starting from this message. The message at index == length - 1 is the latest message, so to get the next page of history, use startMsg = list.first
  /// [count] Total number of messages to retrieve in one request
  /// [lastMinSeq] Not required for the first page of messages, but necessary for getting the second page of history. Same as [startMsg]
  Future<AdvancedMessage?> getAdvancedHistoryMessageList({
    required String conversationID,
    Message? startMsg,
    int lastMinSeq = 0,
    int count = 40,
    String? operationID,
  });

  /// Get chat history (newly received chat history after startMsg). Used for locating a specific message in global search and then fetching messages received after that message.
  /// [conversationID] Conversation ID, can be used for querying notifications
  /// [startMsg] Query [count] messages starting from this message. The message at index == length - 1 is the latest message, so to get the next page of history, use startMsg = list.last
  /// [count] Total number of messages to retrieve in one request
  Future<AdvancedMessage?> getAdvancedHistoryMessageListReverse({
    required String conversationID,
    Message? startMsg,
    int lastMinSeq = 0,
    int count = 40,
    String? operationID,
  });

  /// Find message details
  /// [conversationID] Conversation ID
  /// [clientMsgIDs] List of message IDs
  Future<SearchResult> findMessageList({
    required List<SearchParams> searchParams,
    String? operationID,
  });

  Future<bool> setMessageLocalEx({
    required String conversationID,
    required String clientMsgID,
    required String localEx,
    String? operationID,
  });

  Future<bool> setAppBadge(
    int count, {
    String? operationID,
  });

  /// Create a text message
  Message createTextMessage({
    required String text,
    String? operationID,
  });

  /// Create an @ message
  /// [text] Input content
  /// [atUserIDs] Collection of userIDs being mentioned
  /// [atUserInfos] Mapping of userID to nickname
  /// [quoteMessage] Quoted message (the message being replied to)
  Message createTextAtMessage({
    required String text,
    required List<String> atUserIDs,
    List<AtUserInfo>? atUserInfos,
    Message? quoteMessage,
    String? operationID,
  });

  /// Create an image message
  /// [imagePath] Path
  Message createImageMessage({
    required String imagePath,
    String? operationID,
  });

  /// Create an image message from a full path
  /// [imagePath] Path
  Message createImageMessageFromFullPath({
    required String imagePath,
    String? operationID,
  });

  /// Create a sound message
  /// [soundPath] Path
  /// [duration] Duration in seconds
  Message createSoundMessage({
    required String soundPath,
    required int duration,
    String? operationID,
  });

  /// Create a sound message from a full path
  /// [soundPath] Path
  /// [duration] Duration in seconds
  Message createSoundMessageFromFullPath({
    required String soundPath,
    required int duration,
    String? operationID,
  });

  /// Create a video message
  /// [videoPath] Path
  /// [videoType] Video MIME type
  /// [duration] Duration in seconds
  /// [snapshotPath] Default snapshot image path
  Message createVideoMessage({
    required String videoPath,
    required String videoType,
    required int duration,
    required String snapshotPath,
    String? operationID,
  });

  /// Create a video message from a full path
  /// [videoPath] Path
  /// [videoType] Video MIME type
  /// [duration] Duration in seconds
  /// [snapshotPath] Default snapshot image path
  Message createVideoMessageFromFullPath({
    required String videoPath,
    required String videoType,
    required int duration,
    required String snapshotPath,
    String? operationID,
  });

  /// Create a file message
  /// [filePath] Path
  /// [fileName] File name
  Message createFileMessage({
    required String filePath,
    required String fileName,
    String? operationID,
  });

  /// Create a file message from a full path
  /// [filePath] Path
  /// [fileName] File name
  Message createFileMessageFromFullPath({
    required String filePath,
    required String fileName,
    String? operationID,
  });

  /// Create a merged message
  /// [messages] Selected messages
  /// [title] Summary title
  /// [summarys] Summary content
  Message createMergerMessage({
    required List<Message> messages,
    required String title,
    required List<String> summarys,
    String? operationID,
  });

  /// Create a forwarded message
  /// [message] Message to be forwarded
  Message createForwardMessage({
    required Message message,
    String? operationID,
  });

  /// Create a location message
  /// [latitude] Latitude
  /// [longitude] Longitude
  /// [description] Custom description
  Message createLocationMessage({
    required double latitude,
    required double longitude,
    required String description,
    String? operationID,
  });

  /// Create a custom message
  /// [data] Custom data
  /// [extension] Custom extension content
  /// [description] Custom description content
  Message createCustomMessage({
    required String data,
    required String extension,
    required String description,
    String? operationID,
  });

  /// Create a quoted message
  /// [text] Reply content
  /// [quoteMsg] Message being replied to
  Message createQuoteMessage({
    required String text,
    required Message quoteMsg,
    String? operationID,
  });

  /// Create a card message
  /// [userID] User ID
  /// [nickname] User nickname
  /// [faceURL] User's profile picture URL
  /// [ex] Extra data
  Message createCardMessage({
    required String userID,
    required String nickname,
    String? faceURL,
    String? ex,
    String? operationID,
  });

  /// Create a custom emoji message
  /// [index] Positional emoji, matched based on index
  /// [data] URL emoji, displayed directly using the URL
  Message createFaceMessage({
    int index = 0,
    required String data,
    String? operationID,
  });

  Message createImageMessageByURL({
    required PictureInfo sourcePicture,
    required PictureInfo bigPicture,
    required PictureInfo snapshotPicture,
    String sourcePath = '',
    String? operationID,
  });

  /// Create a sound message
  Message createSoundMessageByURL({
    required SoundElem soundElem,
    String? operationID,
  });

  /// Create a video message
  Message createVideoMessageByURL({
    required VideoElem videoElem,
    String? operationID,
  });

  /// Create a file message
  Message createFileMessageByURL({
    required FileElem fileElem,
    String? operationID,
  });
}
