import 'dart:async';
import 'dart:convert';
import '/listener/listener.dart';
import '/model/search_info.dart';
import '/utils/utils.dart';

import '../../listener/manager.dart';
import '../../model/message.dart';
import '../../utils/sdk_bindings.dart';
import '../base/base_message.dart';

class NativeMessage extends BaseMessage {
  final _bindings = SDKBindings().bindings;

  @override
  Message createCardMessage(
      {required String userID, required String nickname, String? faceURL, String? ex, String? operationID}) {
    return MessageExt.card(
      userID: userID,
      nickname: nickname,
      faceURL: faceURL,
      ex: ex,
      operationID: operationID,
    );
  }

  @override
  Message createCustomMessage(
      {required String data, required String extension, required String description, String? operationID}) {
    return MessageExt.custom(
      data: data,
      extension: extension,
      description: description,
      operationID: operationID,
    );
  }

  @override
  Message createFaceMessage({int index = 0, required String data, String? operationID}) {
    return MessageExt.face(
      index: index,
      data: data,
      operationID: operationID,
    );
  }

  @override
  Message createFileMessage({required String filePath, required String fileName, String? operationID}) {
    return MessageExt.file(
      relativePath: filePath,
      fileName: fileName,
      operationID: operationID,
    );
  }

  @override
  Message createFileMessageFromFullPath({required String filePath, required String fileName, String? operationID}) {
    return MessageExt.file(
      absolutePath: filePath,
      fileName: fileName,
      operationID: operationID,
    );
  }

  @override
  Message createForwardMessage({required Message message, String? operationID}) {
    return MessageExt.forward(
      message: message,
      operationID: operationID,
    );
  }

  @override
  Message createImageMessage({required String imagePath, String? operationID}) {
    return MessageExt.image(
      relativePath: imagePath,
      operationID: operationID,
    );
  }

  @override
  Message createImageMessageFromFullPath({required String imagePath, String? operationID}) {
    return MessageExt.image(
      absolutePath: imagePath,
      operationID: operationID,
    );
  }

  @override
  Message createLocationMessage(
      {required double latitude, required double longitude, required String description, String? operationID}) {
    return MessageExt.location(
      latitude: latitude,
      longitude: longitude,
      description: description,
      operationID: operationID,
    );
  }

  @override
  Message createMergerMessage(
      {required List<Message> messages, required String title, required List<String> summarys, String? operationID}) {
    return MessageExt.merger(
      messages: messages,
      title: title,
      summarys: summarys,
      operationID: operationID,
    );
  }

  @override
  Message createQuoteMessage({required String text, required Message quoteMsg, String? operationID}) {
    return MessageExt.quote(
      text: text,
      quoteMsg: quoteMsg,
      operationID: operationID,
    );
  }

  @override
  Message createSoundMessage({required String soundPath, required int duration, String? operationID}) {
    return MessageExt.sound(
      relativePath: soundPath,
      duration: duration,
      operationID: operationID,
    );
  }

  @override
  Message createSoundMessageFromFullPath({required String soundPath, required int duration, String? operationID}) {
    return MessageExt.sound(
      absolutePath: soundPath,
      duration: duration,
      operationID: operationID,
    );
  }

  @override
  Message createTextAtMessage(
      {required String text,
      required List<String> atUserIDs,
      List<AtUserInfo>? atUserInfos,
      Message? quoteMessage,
      String? operationID}) {
    return MessageExt.mention(
      text: text,
      atUserIDs: atUserIDs,
      atUserInfos: atUserInfos,
      quoteMessage: quoteMessage,
      operationID: operationID,
    );
  }

  @override
  Message createTextMessage({required String text, String? operationID}) {
    return MessageExt.text(
      text: text,
      operationID: operationID,
    );
  }

  @override
  Message createVideoMessage(
      {required String videoPath,
      required String videoType,
      required int duration,
      required String snapshotPath,
      String? operationID}) {
    return MessageExt.video(
      relativePath: videoPath,
      videoType: videoType,
      duration: duration,
      snapshotPath: snapshotPath,
      operationID: operationID,
    );
  }

  @override
  Message createVideoMessageFromFullPath(
      {required String videoPath,
      required String videoType,
      required int duration,
      required String snapshotPath,
      String? operationID}) {
    return MessageExt.video(
      absolutePath: videoPath,
      videoType: videoType,
      duration: duration,
      snapshotPath: snapshotPath,
      operationID: operationID,
    );
  }

  @override
  Message createFileMessageByURL({
    required FileElem fileElem,
    String? operationID,
  }) {
    return MessageExt.fileByURL(fileElem: fileElem, operationID: operationID);
  }

  @override
  Message createImageMessageByURL({
    required PictureInfo sourcePicture,
    required PictureInfo bigPicture,
    required PictureInfo snapshotPicture,
    String sourcePath = '',
    String? operationID,
  }) {
    return MessageExt.imageByURL(
      sourcePicture: sourcePicture,
      bigPicture: bigPicture,
      snapshotPicture: snapshotPicture,
      sourcePath: sourcePath,
      operationID: operationID,
    );
  }

  @override
  Message createSoundMessageByURL({
    required SoundElem soundElem,
    String? operationID,
  }) {
    return MessageExt.soundByURL(soundElem: soundElem, operationID: operationID);
  }

  @override
  Message createVideoMessageByURL({
    required VideoElem videoElem,
    String? operationID,
  }) {
    return MessageExt.videoByURL(videoElem: videoElem, operationID: operationID);
  }

  @override
  Future<Message?> sendMessageNotOss({
    required Message message,
    required OfflinePushInfo offlinePushInfo,
    String? userID,
    String? groupID,
    bool isOnlineOnly = false,
    String? operationID,
    OnMsgSendProgressListener? onMsgSendProgressListener,
  }) {
    if (groupID == null && userID == null) {
      throw ArgumentError('Either groupID or userID must be provided');
    }

    final completer = Completer<Message>();

    final callback = Utils.createCBSISSIFuncNativeCallable(
        onProgress: (progress) {
          onMsgSendProgressListener?.onProgress(message.clientMsgID!, progress);
        },
        onSuccess: (data) {
          final result = Message.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.send_message_not_oss(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(message.toJson()).toNativeChar(),
      userID?.toNativeChar() ?? ''.toNativeChar(),
      groupID?.toNativeChar() ?? ''.toNativeChar(),
      jsonEncode(offlinePushInfo.toJson()).toNativeChar(),
      isOnlineOnly ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<Message?> sendMessage({
    required Message message,
    required OfflinePushInfo offlinePushInfo,
    String? userID,
    String? groupID,
    bool isOnlineOnly = false,
    String? operationID,
    OnMsgSendProgressListener? onMsgSendProgressListener,
  }) {
    if (groupID == null && userID == null) {
      throw ArgumentError('Either groupID or userID must be provided');
    }

    final completer = Completer<Message>();

    final callback = Utils.createCBSISSIFuncNativeCallable(
        onProgress: (progress) {
          onMsgSendProgressListener?.onProgress(message.clientMsgID!, progress);
        },
        onSuccess: (data) {
          final result = Message.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.send_message(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(message.toJson()).toNativeChar(),
      userID?.toNativeChar() ?? ''.toNativeChar(),
      groupID?.toNativeChar() ?? ''.toNativeChar(),
      jsonEncode(offlinePushInfo.toJson()).toNativeChar(),
      isOnlineOnly ? 1 : 0,
    );

    return completer.future;
  }

  @override
  Future<bool> deleteMessageFromLocalStorage({
    required String conversationID,
    required String clientMsgID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.delete_message_from_local_storage(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      clientMsgID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> deleteMessageFromLocalAndSvr({
    required String conversationID,
    required String clientMsgID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.delete_message(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      conversationID.toNativeChar(),
      clientMsgID.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> deleteAllMsgFromLocal({
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.delete_all_msg_from_local(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<bool> deleteAllMsgFromLocalAndSvr({
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.delete_all_msg_from_local_and_svr(
      callback,
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<Message?> insertGroupMessageToLocalStorage({
    required Message message,
    String? groupID,
    String? senderID,
    String? operationID,
  }) {
    if (groupID == null && senderID == null) {
      throw ArgumentError('Either groupID or senderID must be provided');
    }

    final completer = Completer<Message>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = Message.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.insert_group_message_to_local_storage(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(message.toJson()).toNativeChar(),
      groupID?.toNativeChar() ?? ''.toNativeChar(),
      senderID?.toNativeChar() ?? ''.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<Message?> insertSingleMessageToLocalStorage({
    required Message message,
    String? receiverID,
    String? senderID,
    String? operationID,
  }) {
    final completer = Completer<Message?>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = Message.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.insert_single_message_to_local_storage(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(message.toJson()).toNativeChar(),
      receiverID?.toNativeChar() ?? ''.toNativeChar(),
      senderID?.toNativeChar() ?? ''.toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<SearchResult> findMessageList({
    required List<SearchParams> searchParams,
    String? operationID,
  }) {
    final completer = Completer<SearchResult>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = SearchResult.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    _bindings.find_message_list(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(searchParams.map((e) => e.toJson()).toList()).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<AdvancedMessage?> getAdvancedHistoryMessageList({
    required String conversationID,
    Message? startMsg,
    int lastMinSeq = 0,
    int count = 40,
    String? operationID,
  }) {
    final completer = Completer<AdvancedMessage>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = AdvancedMessage.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    final options = {
      'conversationID': conversationID,
      'startClientMsgID': startMsg?.clientMsgID,
      'count': count,
      'lastMinSeq': lastMinSeq,
      'operationID': Utils.reviseOperationID(operationID),
    };

    _bindings.get_advanced_history_message_list(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<AdvancedMessage?> getAdvancedHistoryMessageListReverse({
    String? conversationID,
    Message? startMsg,
    int? lastMinSeq,
    int? count,
    String? operationID,
  }) {
    final completer = Completer<AdvancedMessage>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = AdvancedMessage.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    final options = {
      'conversationID': conversationID,
      'startClientMsgID': startMsg?.clientMsgID,
      'count': count,
      'lastMinSeq': lastMinSeq,
      'operationID': Utils.reviseOperationID(operationID),
    };

    _bindings.get_advanced_history_message_list_reverse(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> revokeMessage({
    required String conversationID,
    required String clientMsgID,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.revoke_message(
      callback,
      conversationID.toNativeChar(),
      clientMsgID.toNativeChar(),
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
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
  }) {
    final completer = Completer<SearchResult>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          final result = SearchResult.fromJson(data);
          completer.complete(result);
        },
        onError: (error) => completer.completeError(error));

    final options = {
      'conversationID': conversationID,
      'keywordList': keywords,
      'keywordListMatchType': keywordListMatchType,
      'senderUserIDList': senderUserIDs,
      'messageTypeList': messageTypes,
      'searchTimePosition': searchTimePosition,
      'searchTimePeriod': searchTimePeriod,
      'pageIndex': pageIndex,
      'count': count,
    };
    _bindings.search_local_messages(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      jsonEncode(options).toNativeChar(),
    );

    return completer.future;
  }

  @override
  Future<bool> setMessageLocalEx({
    required String conversationID,
    required String clientMsgID,
    required String localEx,
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.set_message_local_ex(
      callback,
      conversationID.toNativeChar(),
      clientMsgID.toNativeChar(),
      localEx.toNativeChar(),
      Utils.reviseToNativeOperationID(operationID),
    );

    return completer.future;
  }

  @override
  Future<bool> setAppBadge(
    int count, {
    String? operationID,
  }) {
    final completer = Completer<bool>();

    final callback = Utils.createCBSISSFuncNativeCallable(
        onSuccess: (data) {
          completer.complete(true);
        },
        onError: (error) => completer.completeError(error));

    _bindings.set_app_Badge(
      callback,
      Utils.reviseToNativeOperationID(operationID),
      count,
    );

    return completer.future; // Return the future from the completer
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

extension MessageExt on Message {
  static Message card({
    required String userID,
    required String nickname,
    String? faceURL,
    String? ex,
    String? operationID,
  }) {
    final cardInfo = CardElem(userID: userID, nickname: nickname, faceURL: faceURL);

    final nativeMsg = SDKBindings().bindings.create_card_message(
          Utils.reviseToNativeOperationID(operationID),
          jsonEncode(cardInfo.toJson()).toNativeChar(),
        );
    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message custom({
    required String data,
    required String extension,
    required String description,
    String? operationID,
  }) {
    final nativeMsg = SDKBindings().bindings.create_custom_message(
          Utils.reviseToNativeOperationID(operationID),
          data.toNativeChar(),
          extension.toNativeChar(),
          description.toNativeChar(),
        );
    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message face({
    int index = 0,
    required String data,
    String? operationID,
  }) {
    final nativeMsg = SDKBindings().bindings.create_face_message(
          Utils.reviseToNativeOperationID(operationID),
          index,
          data.toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message file({
    String? relativePath,
    String? absolutePath,
    required String fileName,
    String? operationID,
  }) {
    if (relativePath == null && absolutePath == null) {
      throw ArgumentError('Either relativefilePath or absoluteFilePath must be provided');
    }

    if (fileName.isEmpty) {
      throw ArgumentError('fileName cannot be empty');
    }

    if (absolutePath != null) {
      final nativeMsg = SDKBindings().bindings.create_file_message_from_full_path(
            Utils.reviseToNativeOperationID(operationID),
            absolutePath.toNativeChar(),
            fileName.toNativeChar(),
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    } else {
      final nativeMsg = SDKBindings().bindings.create_file_message(
            Utils.reviseToNativeOperationID(operationID),
            relativePath!.toNativeChar(),
            fileName.toNativeChar(),
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    }
  }

  static Message fileByURL({
    required FileElem fileElem,
    String? operationID,
  }) {
    final fileBaseInfo = jsonEncode(fileElem).toNativeChar();
    final nativeMsg = SDKBindings().bindings.create_file_message_by_url(
          Utils.reviseToNativeOperationID(operationID),
          fileBaseInfo,
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message forward({
    required Message message,
    String? operationID,
  }) {
    final nativeMsg = SDKBindings().bindings.create_forward_message(
          Utils.reviseToNativeOperationID(operationID),
          jsonEncode(message.toJson()).toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message image({
    String? relativePath,
    String? absolutePath,
    String? operationID,
  }) {
    if (relativePath == null && absolutePath == null) {
      throw ArgumentError('Either relativefilePath or absoluteFilePath must be provided');
    }

    if (absolutePath != null) {
      final nativeMsg = SDKBindings().bindings.create_image_message_from_full_path(
            Utils.reviseToNativeOperationID(operationID),
            absolutePath.toNativeChar(),
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    } else {
      final nativeMsg = SDKBindings().bindings.create_image_message(
            Utils.reviseToNativeOperationID(operationID),
            relativePath!.toNativeChar(),
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    }
  }

  static Message imageByURL({
    required PictureInfo sourcePicture,
    required PictureInfo bigPicture,
    required PictureInfo snapshotPicture,
    String sourcePath = '',
    String? operationID,
  }) {
    final nativeMsg = SDKBindings().bindings.create_image_message_by_url(
          Utils.reviseToNativeOperationID(operationID),
          sourcePath.toNativeChar(),
          jsonEncode(sourcePicture.toJson()).toNativeChar(),
          jsonEncode(bigPicture.toJson()).toNativeChar(),
          jsonEncode(snapshotPicture.toJson()).toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message location({
    required double latitude,
    required double longitude,
    required String description,
    String? operationID,
  }) {
    final nativeMsg = SDKBindings().bindings.create_location_message(
          Utils.reviseToNativeOperationID(operationID),
          description.toNativeChar(),
          latitude,
          longitude,
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message merger(
      {required List<Message> messages, required String title, required List<String> summarys, String? operationID}) {
    final nativeMsg = SDKBindings().bindings.create_merger_message(
          Utils.reviseToNativeOperationID(operationID),
          jsonEncode(messages.map((e) => e.toJson()).toList()).toNativeChar(),
          title.toNativeChar(),
          jsonEncode(summarys).toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message quote({required String text, required Message quoteMsg, String? operationID}) {
    final nativeMsg = SDKBindings().bindings.create_quote_message(
          Utils.reviseToNativeOperationID(operationID),
          text.toNativeChar(),
          jsonEncode(quoteMsg.toJson()).toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message sound({String? relativePath, String? absolutePath, required int duration, String? operationID}) {
    if (relativePath == null && absolutePath == null) {
      throw ArgumentError('Either relativefilePath or absoluteFilePath must be provided');
    }

    if (absolutePath != null) {
      final nativeMsg = SDKBindings().bindings.create_sound_message_from_full_path(
            Utils.reviseToNativeOperationID(operationID),
            absolutePath.toNativeChar(),
            duration,
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    } else {
      final nativeMsg = SDKBindings().bindings.create_sound_message(
            Utils.reviseToNativeOperationID(operationID),
            relativePath!.toNativeChar(),
            duration,
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    }
  }

  static Message soundByURL({
    required SoundElem soundElem,
    String? operationID,
  }) {
    final soundBaseInfo = jsonEncode(soundElem.toJson()).toNativeChar();

    final nativeMsg = SDKBindings().bindings.create_sound_message_by_url(
          Utils.reviseToNativeOperationID(operationID),
          soundBaseInfo,
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message mention(
      {required String text,
      required List<String> atUserIDs,
      List<AtUserInfo>? atUserInfos,
      Message? quoteMessage,
      String? operationID}) {
    final nativeMsg = SDKBindings().bindings.create_text_at_message(
          Utils.reviseToNativeOperationID(operationID),
          text.toNativeChar(),
          jsonEncode(atUserIDs).toNativeChar(),
          jsonEncode(atUserInfos?.map((e) => e.toJson()).toList()).toNativeChar(),
          jsonEncode(quoteMessage?.toJson()).toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message text({required String text, String? operationID}) {
    final nativeMsg = SDKBindings().bindings.create_text_message(
          Utils.reviseToNativeOperationID(operationID),
          text.toNativeChar(),
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }

  static Message video(
      {String? relativePath,
      String? absolutePath,
      required String videoType,
      required int duration,
      required String snapshotPath,
      String? operationID}) {
    if (relativePath == null && absolutePath == null) {
      throw ArgumentError('Either relativefilePath or absoluteFilePath must be provided');
    }

    if (absolutePath != null) {
      final nativeMsg = SDKBindings().bindings.create_video_message_from_full_path(
            Utils.reviseToNativeOperationID(operationID),
            absolutePath.toNativeChar(),
            videoType.toNativeChar(),
            duration,
            snapshotPath.toNativeChar(),
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    } else {
      final nativeMsg = SDKBindings().bindings.create_video_message(
            Utils.reviseToNativeOperationID(operationID),
            relativePath!.toNativeChar(),
            videoType.toNativeChar(),
            duration,
            snapshotPath.toNativeChar(),
          );

      final nativeMap = jsonDecode(nativeMsg.toDartString());

      return Message.fromJson(nativeMap);
    }
  }

  static Message videoByURL({
    required VideoElem videoElem,
    String? operationID,
  }) {
    final videoBaseInfo = jsonEncode(videoElem.toJson()).toNativeChar();

    final nativeMsg = SDKBindings().bindings.create_video_message_by_url(
          Utils.reviseToNativeOperationID(operationID),
          videoBaseInfo,
        );

    final nativeMap = jsonDecode(nativeMsg.toDartString());

    return Message.fromJson(nativeMap);
  }
}
