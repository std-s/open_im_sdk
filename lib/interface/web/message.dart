import '/listener/listener.dart';
import '/model/message.dart';
import '/model/search_info.dart';

import '../base/base_message.dart';

class WebMessage extends BaseMessage {
  @override
  Message createCardMessage({required String userID, required String nickname, String? faceURL, String? ex, String? operationID}) {
    // TODO: implement createCardMessage
    throw UnimplementedError();
  }

  @override
  Message createCustomMessage({required String data, required String extension, required String description, String? operationID}) {
    // TODO: implement createCustomMessage
    throw UnimplementedError();
  }

  @override
  Message createFaceMessage({int index = 0, required String data, String? operationID}) {
    // TODO: implement createFaceMessage
    throw UnimplementedError();
  }

  @override
  Message createFileMessage({required String filePath, required String fileName, String? operationID}) {
    // TODO: implement createFileMessage
    throw UnimplementedError();
  }

  @override
  Message createFileMessageByURL({required FileElem fileElem, String? operationID}) {
    // TODO: implement createFileMessageByURL
    throw UnimplementedError();
  }

  @override
  Message createFileMessageFromFullPath({required String filePath, required String fileName, String? operationID}) {
    // TODO: implement createFileMessageFromFullPath
    throw UnimplementedError();
  }

  @override
  Message createForwardMessage({required Message message, String? operationID}) {
    // TODO: implement createForwardMessage
    throw UnimplementedError();
  }

  @override
  Message createImageMessage({required String imagePath, String? operationID}) {
    // TODO: implement createImageMessage
    throw UnimplementedError();
  }

  @override
  Message createImageMessageByURL({required PictureInfo sourcePicture, required PictureInfo bigPicture, required PictureInfo snapshotPicture, String sourcePath = '', String? operationID}) {
    // TODO: implement createImageMessageByURL
    throw UnimplementedError();
  }

  @override
  Message createImageMessageFromFullPath({required String imagePath, String? operationID}) {
    // TODO: implement createImageMessageFromFullPath
    throw UnimplementedError();
  }

  @override
  Message createLocationMessage({required double latitude, required double longitude, required String description, String? operationID}) {
    // TODO: implement createLocationMessage
    throw UnimplementedError();
  }

  @override
  Message createMergerMessage({required List<Message> messages, required String title, required List<String> summarys, String? operationID}) {
    // TODO: implement createMergerMessage
    throw UnimplementedError();
  }

  @override
  Message createQuoteMessage({required String text, required Message quoteMsg, String? operationID}) {
    // TODO: implement createQuoteMessage
    throw UnimplementedError();
  }

  @override
  Message createSoundMessage({required String soundPath, required int duration, String? operationID}) {
    // TODO: implement createSoundMessage
    throw UnimplementedError();
  }

  @override
  Message createSoundMessageByURL({required SoundElem soundElem, String? operationID}) {
    // TODO: implement createSoundMessageByURL
    throw UnimplementedError();
  }

  @override
  Message createSoundMessageFromFullPath({required String soundPath, required int duration, String? operationID}) {
    // TODO: implement createSoundMessageFromFullPath
    throw UnimplementedError();
  }

  @override
  Message createTextAtMessage({required String text, required List<String> atUserIDs, List<AtUserInfo>? atUserInfos, Message? quoteMessage, String? operationID}) {
    // TODO: implement createTextAtMessage
    throw UnimplementedError();
  }

  @override
  Message createTextMessage({required String text, String? operationID}) {
    // TODO: implement createTextMessage
    throw UnimplementedError();
  }

  @override
  Message createVideoMessage({required String videoPath, required String videoType, required int duration, required String snapshotPath, String? operationID}) {
    // TODO: implement createVideoMessage
    throw UnimplementedError();
  }

  @override
  Message createVideoMessageByURL({required VideoElem videoElem, String? operationID}) {
    // TODO: implement createVideoMessageByURL
    throw UnimplementedError();
  }

  @override
  Message createVideoMessageFromFullPath({required String videoPath, required String videoType, required int duration, required String snapshotPath, String? operationID}) {
    // TODO: implement createVideoMessageFromFullPath
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAllMsgFromLocal({String? operationID}) {
    // TODO: implement deleteAllMsgFromLocal
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAllMsgFromLocalAndSvr({String? operationID}) {
    // TODO: implement deleteAllMsgFromLocalAndSvr
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMessageFromLocalAndSvr({required String conversationID, required String clientMsgID, String? operationID}) {
    // TODO: implement deleteMessageFromLocalAndSvr
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMessageFromLocalStorage({required String conversationID, required String clientMsgID, String? operationID}) {
    // TODO: implement deleteMessageFromLocalStorage
    throw UnimplementedError();
  }

  @override
  Future<SearchResult> findMessageList({required List<SearchParams> searchParams, String? operationID}) {
    // TODO: implement findMessageList
    throw UnimplementedError();
  }

  @override
  Future<AdvancedMessage> getAdvancedHistoryMessageList({required String conversationID, Message? startMsg, int lastMinSeq = 0, int count = 40, String? operationID}) {
    // TODO: implement getAdvancedHistoryMessageList
    throw UnimplementedError();
  }

  @override
  Future<AdvancedMessage> getAdvancedHistoryMessageListReverse({required String conversationID, Message? startMsg, int lastMinSeq = 0, int count = 40, String? operationID}) {
    // TODO: implement getAdvancedHistoryMessageListReverse
    throw UnimplementedError();
  }

  @override
  Future<Message> insertGroupMessageToLocalStorage({required Message message, String? groupID, String? senderID, String? operationID}) {
    // TODO: implement insertGroupMessageToLocalStorage
    throw UnimplementedError();
  }

  @override
  Future<Message?> insertSingleMessageToLocalStorage({required Message message, String? receiverID, String? senderID, String? operationID}) {
    // TODO: implement insertSingleMessageToLocalStorage
    throw UnimplementedError();
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    // TODO: implement removeListener
  }

  @override
  Future<bool> revokeMessage({required String conversationID, required String clientMsgID, String? operationID}) {
    // TODO: implement revokeMessage
    throw UnimplementedError();
  }

  @override
  Future<SearchResult> searchLocalMessages({String? conversationID, List<String> keywords = const [], int keywordListMatchType = 0, List<String> senderUserIDs = const [], List<int> messageTypes = const [], int searchTimePosition = 0, int searchTimePeriod = 0, int pageIndex = 1, int count = 40, String? operationID}) {
    // TODO: implement searchLocalMessages
    throw UnimplementedError();
  }

  @override
  Future<Message?> sendMessage({required Message message, required OfflinePushInfo offlinePushInfo, String? userID, String? groupID, bool isOnlineOnly = false, String? operationID}) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<Message?> sendMessageNotOss({required Message message, required OfflinePushInfo offlinePushInfo, String? userID, String? groupID, bool isOnlineOnly = false, String? operationID}) {
    // TODO: implement sendMessageNotOss
    throw UnimplementedError();
  }

  @override
  Future<bool> setAppBadge(int count, {String? operationID}) {
    // TODO: implement setAppBadge
    throw UnimplementedError();
  }

  @override
  void setListener<T extends Listener>(T listener) {
    // TODO: implement setListener
  }

  @override
  Future<bool> setMessageLocalEx({required String conversationID, required String clientMsgID, required String localEx, String? operationID}) {
    // TODO: implement setMessageLocalEx
    throw UnimplementedError();
  }
}
