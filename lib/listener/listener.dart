import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../model/conversation_info.dart';
import '../model/group_info.dart';
import '../model/input_status_changed_data.dart';
import '../model/message.dart';
import '../model/user_info.dart';

abstract class Listener {
  @protected
  void handleListenerEvent(ListenerType eventType, dynamic data);
}

/// SDK Connection State Listener
class OnConnectListener implements Listener {
  Function(int? code, String? msg)? onConnectFailed;
  VoidCallback? onConnectSuccess;
  VoidCallback? onConnecting;
  VoidCallback? onKickedOffline;
  VoidCallback? onUserTokenExpired;
  Function(String? msg)? onUserTokenInvalid;

  OnConnectListener({
    this.onConnectFailed,
    this.onConnectSuccess,
    this.onConnecting,
    this.onKickedOffline,
    this.onUserTokenExpired,
    this.onUserTokenInvalid,
  });

  @override
  void handleListenerEvent(ListenerType eventType, data) {
    switch (eventType) {
      case ListenerType.connectSuccess:
        onConnectSuccess?.call();
        break;
      case ListenerType.connectFailed:
        final json = jsonDecode(data);
        final code = json['errCode'];
        final msg = json['errMsg'];

        onConnectFailed?.call(code, msg);
        break;
      case ListenerType.connecting:
        onConnecting?.call();
        break;
      case ListenerType.kickedOffline:
        onKickedOffline?.call();
        break;
      case ListenerType.userTokenExpired:
        onUserTokenExpired?.call();
        break;
      case ListenerType.userTokenInvalid:
        onUserTokenInvalid?.call(data);
        break;
      default:
        // Handle other cases or log an error
        break;
    }
  }
}

class OnUserListener implements Listener {
  /// The information of the logged-in user has been updated
  Function(UserInfo info)? onSelfInfoUpdated;
  Function(UserStatusInfo info)? onUserStatusChanged;

  OnUserListener({this.onSelfInfoUpdated, this.onUserStatusChanged});

  @override
  void handleListenerEvent(ListenerType eventType, data) {
    switch (eventType) {
      case ListenerType.selfInfoUpdated:
        final json = jsonDecode(data);
        final userInfo = UserInfo.fromJson(json);
        onSelfInfoUpdated?.call(userInfo);
        break;

      case ListenerType.userStatusChanged:
        final json = jsonDecode(data);
        final userStatusInfo = UserStatusInfo.fromJson(json);
        onUserStatusChanged?.call(userStatusInfo);
        break;

      default:
        // Handle other cases or log an error
        break;
    }
  }
}

/// Conversation Listener
class OnConversationListener implements Listener {
  Function(List<ConversationInfo> list) onConversationChanged;
  Function(List<ConversationInfo> list) onNewConversation;
  Function(int count) onTotalUnreadMessageCountChanged;
  Function(bool? reinstalled)? onSyncServerStart;
  Function(int? progress)? onSyncServerProgress;
  Function(bool? reinstalled)? onSyncServerFinish;
  Function(bool? reinstalled)? onSyncServerFailed;
  ValueChanged<InputStatusChangedData>? onInputStatusChanged;

  OnConversationListener({
    required this.onConversationChanged,
    required this.onNewConversation,
    required this.onTotalUnreadMessageCountChanged,
    this.onSyncServerStart,
    this.onSyncServerProgress,
    this.onSyncServerFinish,
    this.onSyncServerFailed,
    this.onInputStatusChanged,
  });

  @override
  void handleListenerEvent(ListenerType eventType, data) {
    switch (eventType) {
      case ListenerType.conversationChanged:
        final json = jsonDecode(data);
        final conversationList =
            List<ConversationInfo>.from(json.map((item) => ConversationInfo.fromJson(item)).toList());

        onConversationChanged.call(conversationList);
        break;

      case ListenerType.newConversation:
        final json = jsonDecode(data);
        final newConversationList =
            List<ConversationInfo>.from(json.map((item) => ConversationInfo.fromJson(item)).toList());

        onNewConversation.call(newConversationList);
        break;

      case ListenerType.totalUnreadMessageCountChanged:
        final count = int.parse(data);

        onTotalUnreadMessageCountChanged.call(count);
        break;

      case ListenerType.syncServerStart:
        final json = jsonDecode(data);
        final reinstalled = json['reinstalled'] as bool?;

        onSyncServerStart?.call(reinstalled);
        break;

      case ListenerType.syncServerProgress:
        final json = jsonDecode(data);
        final progress = json['progress'] as int?;
        onSyncServerProgress?.call(progress);
        break;

      case ListenerType.syncServerFinish:
        final json = jsonDecode(data);
        final reinstalled = json['reinstalled'] as bool?;

        onSyncServerFinish?.call(reinstalled);
        break;

      case ListenerType.syncServerFailed:
        final json = jsonDecode(data);
        final reinstalled = json['reinstalled'] as bool?;

        onSyncServerFailed?.call(reinstalled);
        break;

      case ListenerType.conversationUserInputStatusChanged:
        final json = jsonDecode(data);
        final inputStatusData = InputStatusChangedData.fromJson(json);
        onInputStatusChanged?.call(inputStatusData);
        break;

      default:
        // Handle other cases or log an error
        break;
    }
  }
}

class OnAdvancedMsgListener implements Listener {
  Function(Message msg)? onMsgDeleted;
  Function(RevokedInfo info)? onNewRecvMessageRevoked;
  Function(List<ReadReceiptInfo> list)? onRecvC2CReadReceipt;
  Function(GroupMessageReceipt receipt)? onRecvGroupReadReceipt;
  Function(Message msg) onRecvNewMessage;
  Function(Message msg)? onRecvOfflineNewMessage;
  Function(Message msg)? onRecvOnlineOnlyMessage;

  /// Uniquely identifies
  String id;

  OnAdvancedMsgListener({
    required this.onRecvNewMessage,
    this.onMsgDeleted,
    this.onNewRecvMessageRevoked,
    this.onRecvC2CReadReceipt,
    this.onRecvGroupReadReceipt,
    this.onRecvOfflineNewMessage,
    this.onRecvOnlineOnlyMessage,
  }) : id = "id_${DateTime.now().microsecondsSinceEpoch}";

  @override
  void handleListenerEvent(ListenerType eventType, dynamic data) {
    switch (eventType) {
      case ListenerType.msgDeleted:
        final json = jsonDecode(data);
        final msg = Message.fromJson(json);

        onMsgDeleted?.call(msg);
        break;

      case ListenerType.newRecvMessageRevoked:
        final json = jsonDecode(data);
        final revokedInfo = RevokedInfo.fromJson(json);

        onNewRecvMessageRevoked?.call(revokedInfo);
        break;

      case ListenerType.recvC2CReadReceipt:
        final json = jsonDecode(data);
        final readReceiptList = List<ReadReceiptInfo>.from(json.map((item) => ReadReceiptInfo.fromJson(item)).toList());

        onRecvC2CReadReceipt?.call(readReceiptList);
        break;

      case ListenerType.recvGroupReadReceipt:
        final json = jsonDecode(data);
        final receipt = GroupMessageReceipt.fromJson(json);

        onRecvGroupReadReceipt?.call(receipt);
        break;

      case ListenerType.recvNewMessage:
        final json = jsonDecode(data);
        final msg = Message.fromJson(json);

        onRecvNewMessage.call(msg);
        break;

      case ListenerType.recvOfflineNewMessage:
        final json = jsonDecode(data);
        final msg = Message.fromJson(json);

        onRecvOfflineNewMessage?.call(msg);
        break;

      case ListenerType.recvOnlineOnlyMessage:
        final json = jsonDecode(data);
        final msg = Message.fromJson(json);

        onRecvOnlineOnlyMessage?.call(msg);
        break;

      default:
        // Handle other cases or log an error
        break;
    }
  }
}

/// Message Sending Progress Listener
class OnMsgSendProgressListener implements Listener {
  Function(String clientMsgID, int progress) onProgress;

  OnMsgSendProgressListener({required this.onProgress});

  @override
  void handleListenerEvent(ListenerType eventType, data) {
    // TODO: implement handleListenerEvent
  }
}

/// Friendship Listener
class OnFriendshipListener implements Listener {
  Function(BlacklistInfo info)? onBlackAdded;
  Function(BlacklistInfo info)? onBlackDeleted;
  Function(FriendInfo info)? onFriendAdded;
  Function(FriendApplicationInfo info)? onFriendApplicationAccepted;
  Function(FriendApplicationInfo info)? onFriendApplicationAdded;
  Function(FriendApplicationInfo info)? onFriendApplicationDeleted;
  Function(FriendApplicationInfo info)? onFriendApplicationRejected;
  Function(FriendInfo info)? onFriendDeleted;
  Function(FriendInfo info)? onFriendInfoChanged;

  OnFriendshipListener({
    this.onBlackAdded,
    this.onBlackDeleted,
    this.onFriendAdded,
    this.onFriendApplicationAccepted,
    this.onFriendApplicationAdded,
    this.onFriendApplicationDeleted,
    this.onFriendApplicationRejected,
    this.onFriendDeleted,
    this.onFriendInfoChanged,
  });

  @override
  void handleListenerEvent(ListenerType eventType, dynamic data) {
    switch (eventType) {
      case ListenerType.blackAdded:
        final json = jsonDecode(data);
        final info = BlacklistInfo.fromJson(json);

        onBlackAdded?.call(info);
        break;

      case ListenerType.blackDeleted:
        final json = jsonDecode(data);
        final info = BlacklistInfo.fromJson(json);

        onBlackDeleted?.call(info);
        break;

      case ListenerType.friendAdded:
        final json = jsonDecode(data);
        final info = FriendInfo.fromJson(json);

        onFriendAdded?.call(info);
        break;

      case ListenerType.friendApplicationAccepted:
        final json = jsonDecode(data);
        final info = FriendApplicationInfo.fromJson(json);

        onFriendApplicationAccepted?.call(info);
        break;

      case ListenerType.friendApplicationAdded:
        final json = jsonDecode(data);
        final info = FriendApplicationInfo.fromJson(json);

        onFriendApplicationAdded?.call(info);
        break;

      case ListenerType.friendApplicationDeleted:
        final json = jsonDecode(data);
        final info = FriendApplicationInfo.fromJson(json);

        onFriendApplicationDeleted?.call(info);
        break;

      case ListenerType.friendApplicationRejected:
        final json = jsonDecode(data);
        final info = FriendApplicationInfo.fromJson(json);

        onFriendApplicationRejected?.call(info);
        break;

      case ListenerType.friendDeleted:
        final json = jsonDecode(data);
        final info = FriendInfo.fromJson(json);

        onFriendDeleted?.call(info);
        break;

      case ListenerType.friendInfoChanged:
        final json = jsonDecode(data);
        final info = FriendInfo.fromJson(json);

        onFriendInfoChanged?.call(info);
        break;

      default:
        // Handle other cases or log an error
        break;
    }
  }
}

/// Group Listener
class OnGroupListener implements Listener {
  Function(GroupApplicationInfo info)? onGroupApplicationAccepted;
  Function(GroupApplicationInfo info)? onGroupApplicationAdded;
  Function(GroupApplicationInfo info)? onGroupApplicationDeleted;
  Function(GroupApplicationInfo info)? onGroupApplicationRejected;
  Function(GroupInfo info)? onGroupDismissed;
  Function(GroupInfo info)? onGroupInfoChanged;
  Function(GroupMembersInfo info)? onGroupMemberAdded;
  Function(GroupMembersInfo info)? onGroupMemberDeleted;
  Function(GroupMembersInfo info)? onGroupMemberInfoChanged;
  Function(GroupInfo info)? onJoinedGroupAdded;
  Function(GroupInfo info)? onJoinedGroupDeleted;

  OnGroupListener({
    this.onGroupApplicationAccepted,
    this.onGroupApplicationAdded,
    this.onGroupApplicationDeleted,
    this.onGroupApplicationRejected,
    this.onGroupDismissed,
    this.onGroupInfoChanged,
    this.onGroupMemberAdded,
    this.onGroupMemberDeleted,
    this.onGroupMemberInfoChanged,
    this.onJoinedGroupAdded,
    this.onJoinedGroupDeleted,
  });

  @override
  void handleListenerEvent(ListenerType eventType, dynamic data) {
    switch (eventType) {
      case ListenerType.groupApplicationAccepted:
        final json = jsonDecode(data);
        final info = GroupApplicationInfo.fromJson(json);

        onGroupApplicationAccepted?.call(info);
        break;

      case ListenerType.groupApplicationAdded:
        final json = jsonDecode(data);
        final info = GroupApplicationInfo.fromJson(json);

        onGroupApplicationAdded?.call(info);
        break;

      case ListenerType.groupApplicationDeleted:
        final json = jsonDecode(data);
        final info = GroupApplicationInfo.fromJson(json);

        onGroupApplicationDeleted?.call(info);
        break;

      case ListenerType.groupApplicationRejected:
        final json = jsonDecode(data);
        final info = GroupApplicationInfo.fromJson(json);

        onGroupApplicationRejected?.call(info);
        break;

      case ListenerType.groupDismissed:
        final json = jsonDecode(data);
        final info = GroupInfo.fromJson(json);

        onGroupDismissed?.call(info);
        break;

      case ListenerType.groupInfoChanged:
        final json = jsonDecode(data);
        final info = GroupInfo.fromJson(json);

        onGroupInfoChanged?.call(info);
        break;

      case ListenerType.groupMemberAdded:
        final json = jsonDecode(data);
        final info = GroupMembersInfo.fromJson(json);

        onGroupMemberAdded?.call(info);
        break;

      case ListenerType.groupMemberDeleted:
        final json = jsonDecode(data);
        final info = GroupMembersInfo.fromJson(json);

        onGroupMemberDeleted?.call(info);
        break;

      case ListenerType.groupMemberInfoChanged:
        final json = jsonDecode(data);
        final info = GroupMembersInfo.fromJson(json);

        onGroupMemberInfoChanged?.call(info);
        break;

      case ListenerType.joinedGroupAdded:
        final json = jsonDecode(data);
        final info = GroupInfo.fromJson(json);

        onJoinedGroupAdded?.call(info);
        break;

      case ListenerType.joinedGroupDeleted:
        final json = jsonDecode(data);
        final info = GroupInfo.fromJson(json);

        onJoinedGroupDeleted?.call(info);
        break;

      default:
        // Handle other cases or log an error
        break;
    }
  }
}

class OnCustomBusinessListener implements Listener {
  Function(String s)? onRecvCustomBusinessMessage;

  OnCustomBusinessListener({this.onRecvCustomBusinessMessage});

  @override
  void handleListenerEvent(ListenerType eventType, data) {
    // TODO: implement handleListenerEvent
  }
}

class OnUploadLogsListener implements Listener {
  Function(int current, int size) onProgress;
  OnUploadLogsListener({required this.onProgress});

  @override
  void handleListenerEvent(ListenerType eventType, data) {
    // TODO: implement handleListenerEvent
  }
}

class OnUploadFileListener implements Listener {
  Function(String id, int size, String url, int type)? onComplete;
  Function(String id, String partHash, String fileHash)? onHashPartComplete;
  Function(String id, int index, int size, String partHash)? onHashPartProgress;
  Function(String id, int size)? onOpen;
  Function(String id, int partSize, int num)? onPartSize;
  Function(String id, int fileSize, int streamSize, int storageSize)? onUploadProgress;
  Function(String id, String uploadID)? onUploadID;
  Function(String id, int index, int partSize, String partHash)? onUploadPartComplete;

  OnUploadFileListener({
    this.onComplete,
    this.onHashPartComplete,
    this.onHashPartProgress,
    this.onOpen,
    this.onPartSize,
    this.onUploadProgress,
    this.onUploadID,
    this.onUploadPartComplete,
  });

  @override
  void handleListenerEvent(ListenerType eventType, dynamic data) {
    switch (eventType) {
      case ListenerType.complete:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final int size = args['size'];
        final String url = args['url'];
        final int type = args['type'];
        onComplete?.call(id, size, url, type);
        break;

      case ListenerType.hashPartComplete:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final String partHash = args['partHash'];
        final String fileHash = args['fileHash'];
        onHashPartComplete?.call(id, partHash, fileHash);
        break;

      case ListenerType.hashPartProgress:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final int index = args['index'];
        final int size = args['size'];
        final String partHash = args['partHash'];
        onHashPartProgress?.call(id, index, size, partHash);
        break;

      case ListenerType.open:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final int size = args['size'];
        onOpen?.call(id, size);
        break;

      case ListenerType.partSize:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final int partSize = args['partSize'];
        final int num = args['num'];
        onPartSize?.call(id, partSize, num);
        break;

      case ListenerType.onProgress:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final int fileSize = args['fileSize'];
        final int streamSize = args['streamSize'];
        final int storageSize = args['storageSize'];
        onUploadProgress?.call(id, fileSize, streamSize, storageSize);
        break;

      case ListenerType.uploadId:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final String uploadID = args['uploadID'];
        onUploadID?.call(id, uploadID);
        break;

      case ListenerType.uploadPartComplete:
        final args = data as Map<String, dynamic>;
        final String id = args['id'];
        final int index = args['index'];
        final int partSize = args['partSize'];
        final String partHash = args['partHash'];
        onUploadPartComplete?.call(id, index, partSize, partHash);
        break;

      default:
        // Handle unhandled event types or log an error
        break;
    }
  }
}

/// Enum representing various listener types.
enum ListenerType {
  /// Connecting to the server.
  connecting(0),

  /// Successfully connected to the server.
  connectSuccess(1),

  /// Connection to the server failed.
  connectFailed(2),

  /// User has been kicked offline.
  kickedOffline(3),

  /// User token has expired.
  userTokenExpired(4),

  /// Group has been added.
  joinedGroupAdded(5),

  /// Group has been deleted.
  joinedGroupDeleted(6),

  /// A member has been added to the group.
  groupMemberAdded(7),

  /// A member has been removed from the group.
  groupMemberDeleted(8),

  /// A group application has been added.
  groupApplicationAdded(9),

  /// A group application has been deleted.
  groupApplicationDeleted(10),

  /// Group information has changed.
  groupInfoChanged(11),

  /// Group has been dismissed.
  groupDismissed(12),

  /// Group member information has changed.
  groupMemberInfoChanged(13),

  /// Group application has been accepted.
  groupApplicationAccepted(14),

  /// Group application has been rejected.
  groupApplicationRejected(15),

  /// Friend application has been added.
  friendApplicationAdded(16),

  /// Friend application has been deleted.
  friendApplicationDeleted(17),

  /// Friend application has been accepted.
  friendApplicationAccepted(18),

  /// Friend application has been rejected.
  friendApplicationRejected(19),

  /// A friend has been added.
  friendAdded(20),

  /// A friend has been deleted.
  friendDeleted(21),

  /// Friend information has changed.
  friendInfoChanged(22),

  /// A user has been added to the blacklist.
  blackAdded(23),

  /// A user has been removed from the blacklist.
  blackDeleted(24),

  /// Synchronization server has started.
  syncServerStart(25),

  /// Synchronization server has finished.
  syncServerFinish(26),

  /// Progress of the synchronization server.
  syncServerProgress(27),

  /// Synchronization server has failed.
  syncServerFailed(28),

  /// A new conversation has started.
  newConversation(29),

  /// A conversation has changed.
  conversationChanged(30),

  /// Total unread message count has changed.
  totalUnreadMessageCountChanged(31),

  /// A new message has been received.
  recvNewMessage(32),

  /// A C2C read receipt has been received.
  recvC2CReadReceipt(33),

  /// A group read receipt has been received.
  recvGroupReadReceipt(34),

  /// A newly received message has been revoked.
  newRecvMessageRevoked(35),

  /// Message extensions have changed.
  recvMessageExtensionsChanged(36),

  /// Message extensions have been deleted.
  recvMessageExtensionsDeleted(37),

  /// Message extensions have been added.
  recvMessageExtensionsAdded(38),

  /// An offline new message has been received.
  recvOfflineNewMessage(39),

  /// A message has been deleted.
  msgDeleted(40),

  /// New messages have been received.
  recvNewMessages(41),

  /// Offline new messages have been received.
  recvOfflineNewMessages(42),

  /// User information has been updated.
  selfInfoUpdated(43),

  /// User status has changed.
  userStatusChanged(44),

  /// A custom business message has been received.
  recvCustomBusinessMessage(45),

  /// Message KV information has changed.
  messageKvInfoChanged(46),

  /// The connection is open.
  open(47),

  /// The size of the part being transferred.
  partSize(48),

  /// Progress of the hash part.
  hashPartProgress(49),

  /// The hash part has been completed.
  hashPartComplete(50),

  /// Upload ID.
  uploadId(51),

  /// A part of the upload has been completed.
  uploadPartComplete(52),

  /// The upload has been completed.
  uploadComplete(53),

  /// The process is complete.
  complete(54),

  /// User input status in the conversation has changed.
  conversationUserInputStatusChanged(55),

  /// An online-only message has been received.
  recvOnlineOnlyMessage(56),

  /// User token is invalid.
  userTokenInvalid(57),

  /// A new invitation has been received.
  recvNewInvitation(58),

  /// An invitee has accepted the invitation.
  inviteeAccepted(59),

  /// An invitee has accepted the invitation on another device.
  inviteeAcceptedByOtherDevice(60),

  /// An invitee has rejected the invitation.
  inviteeRejected(61),

  /// An invitee has rejected the invitation on another device.
  inviteeRejectedByOtherDevice(62),

  /// An invitation has been cancelled.
  invitationCancelled(63),

  /// An invitation has timed out.
  invitationTimeout(64),

  /// The call has ended.
  hangUp(65),

  /// A participant has connected to the room.
  roomParticipantConnected(66),

  /// A participant has disconnected from the room.
  roomParticipantDisconnected(67),

  /// The stream has changed.
  streamChange(68),

  /// A custom signal has been received.
  receiveCustomSignal(69),

  /// Progress of an ongoing operation.
  onProgress(70);

  /// The numeric value representing this listener type.
  final int rawValue;

  /// Constructor to bind listener type to its corresponding raw value.
  const ListenerType(this.rawValue);

  /// Retrieves the ListenerType enum member from its numeric value.
  static ListenerType fromValue(int rawValue) {
    return ListenerType.values.firstWhere(
      (type) => type.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid listener type value: $rawValue'),
    );
  }
}
