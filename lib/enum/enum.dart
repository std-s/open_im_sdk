import 'dart:io';

import 'package:flutter/foundation.dart';

/// Enum representing supported IM platforms
enum IMPlatform {
  unknown(0),

  /// iOS platform
  ios(1),

  /// Android platform
  android(2),

  /// Windows platform
  windows(3),

  /// XOS platform
  xos(4),

  /// Web platform
  web(5),

  /// MiniWeb platform
  miniWeb(6),

  /// Linux platform
  linux(7),

  /// Android tablet platform
  androidPad(8),

  /// iPad platform
  iPad(9);

  /// The numeric value representing this platform
  final int rawValue;

  /// Constructor that binds the platform to its corresponding raw value
  const IMPlatform(this.rawValue);

  /// Retrieves the IMPlatform enum member from its numeric value
  static IMPlatform fromValue(int rawValue) {
    return IMPlatform.values.firstWhere(
      (platform) => platform.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid platform value: $rawValue'),
    );
  }

  /// Detects and returns the current platform based on runtime environment
  static IMPlatform get current {
    if (kIsWeb) {
      return IMPlatform.web;
    }
    if (Platform.isAndroid) {
      return IMPlatform.android;
    }
    if (Platform.isIOS) {
      return IMPlatform.ios;
    }
    if (Platform.isWindows) {
      return IMPlatform.windows;
    }
    if (Platform.isMacOS) {
      return IMPlatform.xos;
    }
    if (Platform.isLinux) {
      return IMPlatform.linux;
    }
    return IMPlatform.iPad;
  }
}

/// Enum representing login status
enum LoginStatus {
  unknown(0),

  /// User is logged out
  loggedOut(1),

  /// User is in the process of logging in
  loggingIn(2),

  /// User is logged in
  loggedIn(3);

  /// The numeric value representing this login status
  final int rawValue;

  /// Constructor to bind login status to its corresponding raw value
  const LoginStatus(this.rawValue);

  /// Retrieves the LoginStatus enum member from its numeric value
  static LoginStatus fromValue(int rawValue) {
    return LoginStatus.values.firstWhere(
      (status) => status.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid login status value: $rawValue'),
    );
  }
}

/// Enum representing log levels
enum Loglevel {
  /// No logs
  none(0),

  /// Debug level logging
  debug(1),

  /// Informational level logging
  info(2),

  /// Warning level logging
  warning(3),

  /// Error level logging
  error(4),

  /// Fatal level logging
  fatal(5),

  /// Verbose logging
  verbose(6);

  /// The numeric value representing this log level
  final int rawValue;

  /// Constructor to bind log level to its corresponding raw value
  const Loglevel(this.rawValue);

  /// Retrieves the Loglevel enum member from its numeric value
  static Loglevel fromValue(int rawValue) {
    return Loglevel.values.firstWhere(
      (level) => level.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid log level value: $rawValue'),
    );
  }
}

/// Enum representing types of conversations
enum ConversationType {
  unknown(0),

  /// Single person chat
  single(1),

  /// Group chat (Deprecated)
  @Deprecated('Use [superGroup] instead')
  group(2),

  /// Super group chat
  superGroup(3),

  /// Notification chat
  notification(4);

  /// The numeric value representing this conversation type
  final int rawValue;

  /// Constructor to bind conversation type to its corresponding raw value
  const ConversationType(this.rawValue);

  /// Retrieves the ConversationType enum member from its numeric value
  static ConversationType fromValue(int rawValue) {
    return ConversationType.values.firstWhere(
      (type) => type.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid conversation type value: $rawValue'),
    );
  }
}

/// Enum representing group types
enum GroupType {
  unknown(0),

  /// General group (Deprecated)
  @Deprecated('Use [work] instead')
  general(1),

  /// Work group
  work(2);

  /// The numeric value representing this group type
  final int rawValue;

  /// Constructor to bind group type to its corresponding raw value
  const GroupType(this.rawValue);

  /// Retrieves the GroupType enum member from its numeric value
  static GroupType fromValue(int rawValue) {
    return GroupType.values.firstWhere(
      (type) => type.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid group type value: $rawValue'),
    );
  }
}

/// Enum representing group member filters
enum GroupMemberFilter {
  /// All members
  all(0),

  /// Group owner only
  owner(1),

  /// Administrators only
  admin(2),

  /// Regular members only
  member(3),

  /// Administrators and members
  adminAndMember(4),

  /// Super users and administrators
  superAndAdmin(5);

  /// The numeric value representing this member filter
  final int rawValue;

  /// Constructor to bind member filter to its corresponding raw value
  const GroupMemberFilter(this.rawValue);

  /// Retrieves the GroupMemberFilter enum member from its numeric value
  static GroupMemberFilter fromValue(int rawValue) {
    return GroupMemberFilter.values.firstWhere(
      (filter) => filter.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid member filter value: $rawValue'),
    );
  }
}

/// Enum representing group verification types
enum GroupVerificationType {
  /// Apply requires approval, invite directly
  applyNeedVerificationInviteDirectly(0),

  /// Everyone needs approval, except owner and admin invites
  allNeedVerification(1),

  /// Enter the group directly
  directly(2);

  /// The numeric value representing this verification type
  final int rawValue;

  /// Constructor to bind verification type to its corresponding raw value
  const GroupVerificationType(this.rawValue);

  /// Retrieves the GroupVerificationType enum member from its numeric value
  static GroupVerificationType fromValue(int rawValue) {
    return GroupVerificationType.values.firstWhere(
      (type) => type.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid verification type value: $rawValue'),
    );
  }
}

/// Group Status: 0 - Normal, 1 - Blocked, 2 - Dissolved, 3 - Muted
enum GroupStatus {
  /// Normal group status
  normal(0),

  /// Blocked group status
  blocked(1),

  /// Dissolved group status
  dissolved(2),

  /// Muted group status
  muted(3);

  final int rawValue;

  const GroupStatus(this.rawValue);

  /// Converts an integer value to a GroupStatus enum
  static GroupStatus fromValue(int value) {
    return GroupStatus.values.firstWhere(
      (status) => status.rawValue == value,
      orElse: () => throw ArgumentError('Invalid status value: $value'),
    );
  }
}

/// Enum representing join types
enum JoinType {
  /// Joining by invitation
  invited(2),

  /// Joining by search
  search(3),

  /// Joining by QR code
  QRCode(4);

  /// The numeric value representing this join type
  final int rawValue;

  /// Constructor to bind join type to its corresponding raw value
  const JoinType(this.rawValue);

  /// Retrieves the JoinType enum member from its numeric value
  static JoinType fromValue(int rawValue) {
    return JoinType.values.firstWhere(
      (type) => type.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid join type value: $rawValue'),
    );
  }
}

enum MessageType {
  unkonwn(0),
  // Normal messages
  text(101),
  picture(102),
  voice(103),
  video(104),
  file(105),
  atText(106),
  merger(107),
  card(108),
  location(109),
  custom(110),
  typing(113),
  quote(114),
  customFace(115),

  @Deprecated('Use GroupHasReadReceiptNotification instead')
  groupHasReadReceipt(116),

  advancedText(117),
  customMsgNotTriggerConversation(119),
  customMsgOnlineOnly(120),

  // Notification types
  notificationBegin(1000),

  friendNotificationBegin(1200),
  friendApplicationApprovedNotification(1201),
  friendApplicationRejectedNotification(1202),
  friendApplicationNotification(1203),
  friendAddedNotification(1204),
  friendDeletedNotification(1205),
  friendRemarkSetNotification(1206),
  blackAddedNotification(1207),
  blackDeletedNotification(1208),
  friendNotificationEnd(1299),

  conversationChangeNotification(1300),

  userNotificationBegin(1301),
  userInfoUpdatedNotification(1303),
  userNotificationEnd(1399),

  oaNotification(1400),

  groupNotificationBegin(1500),
  groupCreatedNotification(1501),
  groupInfoSetNotification(1502),
  joinGroupApplicationNotification(1503),
  memberQuitNotification(1504),
  groupApplicationAcceptedNotification(1505),
  groupApplicationRejectedNotification(1506),
  groupOwnerTransferredNotification(1507),
  memberKickedNotification(1508),
  memberInvitedNotification(1509),
  memberEnterNotification(1510),
  dismissGroupNotification(1511),
  groupNotificationEnd(1599),

  groupMemberMutedNotification(1512),
  groupMemberCancelMutedNotification(1513),
  groupMutedNotification(1514),
  groupCancelMutedNotification(1515),
  groupMemberInfoChangedNotification(1516),
  groupMemberSetToAdminNotification(1517),
  groupMemberSetToOrdinaryUserNotification(1518),
  groupInfoSetAnnouncementNotification(1519),
  groupInfoSetNameNotification(1520),

  burnAfterReadingNotification(1701),

  notificationEnd(2000),
  businessNotification(2001),
  revokeMessageNotification(2101),
  signalHasReadReceiptNotification(2150),
  groupHasReadReceiptNotification(2155);

  // Value associated with each message type
  final int rawValue;

  const MessageType(this.rawValue);

  static MessageType fromValue(int value) {
    return MessageType.values.firstWhere(
      (role) => role.rawValue == value,
      orElse: () => throw ArgumentError('Invalid role value: $value'),
    );
  }
}

/// Enum representing the message send status
enum MessageStatus {
  unkonwn(0),

  /// The message is currently being sent
  sending(1),

  /// The message has been successfully sent
  succeeded(2),

  /// The message failed to send
  failed(3),

  /// The message has been deleted
  deleted(4);

  /// The numeric value representing this message status
  final int rawValue;

  /// Constructor to bind message status to its corresponding raw value
  const MessageStatus(this.rawValue);

  /// Retrieves the MessageStatus enum member from its numeric value
  static MessageStatus fromValue(int rawValue) {
    return MessageStatus.values.firstWhere(
      (status) => status.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid message status value: $rawValue'),
    );
  }
}

enum ReceiveMessageOpt {
  receive(0),
  notReceive(1),
  notNotify(2);

  // Value associated with each option
  final int rawValue;

  const ReceiveMessageOpt(this.rawValue);

  static ReceiveMessageOpt fromValue(int value) {
    return ReceiveMessageOpt.values.firstWhere(
      (role) => role.rawValue == value,
      orElse: () => throw ArgumentError('Invalid role value: $value'),
    );
  }
}

enum GroupAtType {
  atNormal(0), // Cancel all hints, equivalent to calling resetConversationGroupAtType
  atMe(1), // @ me hint
  atAll(2), // @ all hint
  atAllAtMe(3), // @ all and @ me hint
  groupNotification(4); // Group notification hint

  // Value associated with each option
  final int rawValue;

  const GroupAtType(this.rawValue);

  static GroupAtType fromValue(int value) {
    return GroupAtType.values.firstWhere(
      (role) => role.rawValue == value,
      orElse: () => throw ArgumentError('Invalid role value: $value'),
    );
  }
}

/// Group Member Roles
enum GroupRoleLevel {
  /// Group owner
  owner(100),

  /// Administrator
  admin(60),

  /// Regular member
  member(20);

  final int rawValue;

  const GroupRoleLevel(this.rawValue);

  static GroupRoleLevel fromValue(int value) {
    return GroupRoleLevel.values.firstWhere(
      (role) => role.rawValue == value,
      orElse: () => throw ArgumentError('Invalid role value: $value'),
    );
  }
}

/// Enum representing SDK error codes
enum SDKErrorCode {
  unknown(0),

  /// Network Request Error
  networkRequestError(10000),

  /// Network Waiting Timeout Error
  networkWaitTimeoutError(10001),

  /// Parameter Error
  parameterError(10002),

  /// Context Timeout Error, usually when the user has already logged out
  contextTimeoutError(10003),

  /// Resources not loaded completely, usually uninitialized or login hasn't completed
  resourceNotLoaded(10004),

  /// Unknown Error, check the error message for details
  unknownError(10005),

  /// SDK Internal Error, check the error message for details
  sdkInternalError(10006),

  /// This user has set not to be added
  refuseToAddFriends(10013),

  /// User does not exist or is not registered
  userNotExistOrNotRegistered(10100),

  /// User has already logged out
  userHasLoggedOut(10101),

  /// User is attempting to log in again, check the login status to avoid duplicate logins
  repeatLogin(10102),

  /// The file to upload does not exist
  uploadFileNotExist(10200),

  /// Message decompression failed
  messageDecompressionFailed(10201),

  /// Message decoding failed
  messageDecodingFailed(10202),

  /// Unsupported long connection binary protocol
  unsupportedLongConnection(10203),

  /// Message sent multiple times
  messageRepeated(10204),

  /// Message content type not supported
  messageContentTypeNotSupported(10205),

  /// Unsupported session operation
  unsupportedSessionOperation(10301),

  /// Group ID does not exist
  groupIDNotExist(10400),

  /// Group type is incorrect
  wrongGroupType(10401),

  /// Server Internal Error, usually an internal network error, check if server nodes are running correctly
  serverInternalError(500),

  /// Parameter Error on the server, check if body and header parameters are correct
  serverParameterError(1001),

  /// Insufficient Permissions, typically when the token in the header is incorrect or when trying to perform unauthorized actions
  insufficientPermissions(1002),

  /// Duplicate Database Primary Key
  duplicateDatabasePrimaryKey(1003),

  /// Database Record Not Found
  databaseRecordNotFound(1004),

  /// User ID does not exist
  userIDNotExist(1101),

  /// User is already registered
  userAlreadyRegistered(1102),

  /// Group does not exist
  groupNotExist(1201),

  /// Group already exists
  groupAlreadyExists(1202),

  /// User is not in the group
  userIsNotInGroup(1203),

  /// Group has been disbanded
  groupDisbanded(1204),

  /// Group application has already been processed, no need to process it again
  groupApplicationHasBeenProcessed(1206),

  /// Cannot add yourself as a friend
  notAddMyselfAsAFriend(1301),

  /// You have been blocked by the other party
  hasBeenBlocked(1302),

  /// The other party is not your friend
  notFriend(1303),

  /// Already in a friend relationship, no need to reapply
  alreadyAFriendRelationship(1304),

  /// Message read function is turned off
  messageReadFunctionIsTurnedOff(1401),

  /// You have been banned from speaking in the group
  youHaveBeenBanned(1402),

  /// The group has been banned from posting
  groupHasBeenBanned(1403),

  /// This message has been retracted
  messageHasBeenRetracted(1404),

  /// Authorization has expired
  licenseExpired(1405),

  /// Token has expired
  tokenHasExpired(1501),

  /// Invalid token
  tokenInvalid(1502),

  /// Token format error
  tokenFormatError(1503),

  /// Token has not yet taken effect
  tokenHasNotYetTakenEffect(1504),

  /// Unknown token error
  unknownTokenError(1505),

  /// The kicked-out token is invalid
  kickedOutTokenIsInvalid(1506),

  /// Token does not exist
  tokenNotExist(1507),

  /// Number of Connections Exceeds Gateway's Maximum Limit
  connectionsExceedsMaximumLimit(1601),

  /// Handshake Parameter Error
  handshakeParameterError(1602),

  /// File Upload Expired
  fileUploadExpired(1701),

  /// Calling inviter is busy
  callingInviterIsBusy(35001);

  /// The numeric value representing this SDK error code
  final int rawValue;

  /// Constructor to bind SDK error code to its corresponding raw value
  const SDKErrorCode(this.rawValue);

  /// Retrieves the SDKErrorCode enum member from its numeric value
  static SDKErrorCode fromValue(int rawValue) {
    return SDKErrorCode.values.firstWhere(
      (code) => code.rawValue == rawValue,
      orElse: () => throw ArgumentError('Invalid SDK error code value: $rawValue'),
    );
  }
}
