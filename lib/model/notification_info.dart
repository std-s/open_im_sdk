import '../open_im_sdk.dart';

/// Represents a notification from OA (Office Automation).
class OANotification {
  /// The title of the notification.
  String? notificationName;

  /// The URL of the notification's avatar.
  String? notificationFaceURL;

  /// The type of notification.
  int? notificationType;

  /// The text content of the notification.
  String? text;

  /// A URL to redirect when the notification is clicked.
  String? externalUrl;

  /// The type of notification content.
  /// 0: Text-only notification
  /// 1: Text + Image notification
  /// 2: Text + Video notification
  /// 3: Text + File notification
  int? mixType;

  /// Information about an image associated with the notification.
  PictureElem? pictureElem;

  /// Information about sound associated with the notification.
  SoundElem? soundElem;

  /// Information about a video associated with the notification.
  VideoElem? videoElem;

  /// Information about a file associated with the notification.
  FileElem? fileElem;

  /// Additional information for the notification.
  String? ex;

  /// Constructor for [OANotification].
  OANotification({
    this.notificationName,
    this.notificationFaceURL,
    this.notificationType,
    this.text,
    this.externalUrl,
    this.mixType,
    this.pictureElem,
    this.soundElem,
    this.videoElem,
    this.fileElem,
    this.ex,
  });

  /// Creates an instance of [OANotification] from JSON.
  OANotification.fromJson(Map<String, dynamic> json) {
    notificationName = json['notificationName'];
    notificationFaceURL = json['notificationFaceURL'];
    notificationType = json['notificationType'];
    text = json['text'];
    externalUrl = json['externalUrl'];
    mixType = json['mixType'];
    pictureElem = json['pictureElem'] != null ? PictureElem.fromJson(json['pictureElem']) : null;
    soundElem = json['soundElem'] != null ? SoundElem.fromJson(json['soundElem']) : null;
    videoElem = json['videoElem'] != null ? VideoElem.fromJson(json['videoElem']) : null;
    fileElem = json['fileElem'] != null ? FileElem.fromJson(json['fileElem']) : null;
    ex = json['ex'];
  }

  /// Converts the instance of [OANotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['notificationName'] = notificationName;
    data['notificationFaceURL'] = notificationFaceURL;
    data['notificationType'] = notificationType;
    data['text'] = text;
    data['externalUrl'] = externalUrl;
    data['mixType'] = mixType;

    if (pictureElem != null) {
      data['pictureElem'] = pictureElem!.toJson();
    }
    if (soundElem != null) {
      data['soundElem'] = soundElem!.toJson();
    }
    if (videoElem != null) {
      data['videoElem'] = videoElem!.toJson();
    }
    if (fileElem != null) {
      data['fileElem'] = fileElem!.toJson();
    }
    data['ex'] = ex;
    return data;
  }
}

/// Represents a group notification.
class GroupNotification {
  /// Information about the group.
  GroupInfo? group;

  /// Information about the user who performed the action.
  GroupMembersInfo? opUser;

  /// Information about the owner of the group.
  GroupMembersInfo? groupOwnerUser;

  /// List of group members affected by the event.
  List<GroupMembersInfo>? memberList;

  /// Constructor for [GroupNotification].
  GroupNotification({
    this.group,
    this.opUser,
    this.groupOwnerUser,
    this.memberList,
  });

  /// Creates an instance of [GroupNotification] from JSON.
  GroupNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    opUser = json['opUser'] != null ? GroupMembersInfo.fromJson(json['opUser']) : null;
    groupOwnerUser = json['groupOwnerUser'] != null ? GroupMembersInfo.fromJson(json['groupOwnerUser']) : null;
    memberList = (json['memberList'] as List?)?.map((v) => GroupMembersInfo.fromJson(v)).toList();
  }

  /// Converts the instance of [GroupNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (opUser != null) {
      data['opUser'] = opUser!.toJson();
    }
    if (groupOwnerUser != null) {
      data['groupOwnerUser'] = groupOwnerUser!.toJson();
    }

    data['memberList'] = memberList?.map((v) => v.toJson()).toList();

    return data;
  }
}

/// Represents a notification for a user invited to join a group.
class InvitedJoinGroupNotification {
  /// Information about the group.
  GroupInfo? group;

  /// Information about the user who invited the member.
  GroupMembersInfo? opUser;

  /// List of users invited to the group.
  List<GroupMembersInfo>? invitedUserList;

  /// Constructor for [InvitedJoinGroupNotification].
  InvitedJoinGroupNotification({this.group, this.opUser, this.invitedUserList});

  /// Creates an instance of [InvitedJoinGroupNotification] from JSON.
  InvitedJoinGroupNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    opUser = json['opUser'] != null ? GroupMembersInfo.fromJson(json['opUser']) : null;

    invitedUserList = (json['invitedUserList'] as List?)?.map((v) => GroupMembersInfo.fromJson(v)).toList();
  }

  /// Converts the instance of [InvitedJoinGroupNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (opUser != null) {
      data['opUser'] = opUser!.toJson();
    }
    if (invitedUserList != null) {
      data['invitedUserList'] = invitedUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents a notification for a member kicked out of a group.
class KickedGroupMemberNotification {
  /// Information about the group.
  GroupInfo? group;

  /// Information about the user who performed the kick.
  GroupMembersInfo? opUser;

  /// List of users who were kicked from the group.
  List<GroupMembersInfo>? kickedUserList;

  /// Constructor for [KickedGroupMemberNotification].
  KickedGroupMemberNotification({this.group, this.opUser, this.kickedUserList});

  /// Creates an instance of [KickedGroupMemberNotification] from JSON.
  KickedGroupMemberNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    opUser = json['opUser'] != null ? GroupMembersInfo.fromJson(json['opUser']) : null;

    if (json['kickedUserList'] != null) {
      kickedUserList = (json['kickedUserList'] as List).map((v) => GroupMembersInfo.fromJson(v)).toList();
    }
  }

  /// Converts the instance of [KickedGroupMemberNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (opUser != null) {
      data['opUser'] = opUser!.toJson();
    }
    if (kickedUserList != null) {
      data['kickedUserList'] = kickedUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents a notification for a user quitting a group.
class QuitGroupNotification {
  /// Information about the group.
  GroupInfo? group;

  /// Information about the user who quit the group.
  GroupMembersInfo? quitUser;

  /// Constructor for [QuitGroupNotification].
  QuitGroupNotification({this.group, this.quitUser});

  /// Creates an instance of [QuitGroupNotification] from JSON.
  QuitGroupNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    quitUser = json['quitUser'] != null ? GroupMembersInfo.fromJson(json['quitUser']) : null;
  }

  /// Converts the instance of [QuitGroupNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (quitUser != null) {
      data['quitUser'] = quitUser!.toJson();
    }
    return data;
  }
}

/// Notification for a user entering a group.
class EnterGroupNotification {
  /// Group information.
  GroupInfo? group;

  /// Information about the member entering the group.
  GroupMembersInfo? entrantUser;

  /// Constructor for [EnterGroupNotification].
  EnterGroupNotification({this.group, this.entrantUser});

  /// Creates an instance of [EnterGroupNotification] from JSON.
  EnterGroupNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    entrantUser = json['entrantUser'] != null ? GroupMembersInfo.fromJson(json['entrantUser']) : null;
  }

  /// Converts the instance of [EnterGroupNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (entrantUser != null) {
      data['entrantUser'] = entrantUser!.toJson();
    }
    return data;
  }
}

/// Notification for the transfer of group rights.
class GroupRightsTransferNotification {
  /// Group information.
  GroupInfo? group;

  /// Operator's information.
  GroupMembersInfo? opUser;

  /// New group owner's information.
  GroupMembersInfo? newGroupOwner;

  /// Constructor for [GroupRightsTransferNotification].
  GroupRightsTransferNotification({
    this.group,
    this.opUser,
    this.newGroupOwner,
  });

  /// Creates an instance of [GroupRightsTransferNotification] from JSON.
  GroupRightsTransferNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    opUser = json['opUser'] != null ? GroupMembersInfo.fromJson(json['opUser']) : null;
    newGroupOwner = json['newGroupOwner'] != null ? GroupMembersInfo.fromJson(json['newGroupOwner']) : null;
  }

  /// Converts the instance of [GroupRightsTransferNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (opUser != null) {
      data['opUser'] = opUser!.toJson();
    }
    if (newGroupOwner != null) {
      data['newGroupOwner'] = newGroupOwner!.toJson();
    }
    return data;
  }
}

/// Notification for muting a member.
class MuteMemberNotification {
  /// Group information.
  GroupInfo? group;

  /// Operator's information.
  GroupMembersInfo? opUser;

  /// Information about the muted member.
  GroupMembersInfo? mutedUser;

  /// Duration of the mute in seconds.
  int? mutedSeconds;

  /// Constructor for [MuteMemberNotification].
  MuteMemberNotification({
    this.group,
    this.opUser,
    this.mutedUser,
    this.mutedSeconds,
  });

  /// Creates an instance of [MuteMemberNotification] from JSON.
  MuteMemberNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    opUser = json['opUser'] != null ? GroupMembersInfo.fromJson(json['opUser']) : null;
    mutedUser = json['mutedUser'] != null ? GroupMembersInfo.fromJson(json['mutedUser']) : null;
    mutedSeconds = json['mutedSeconds'];
  }

  /// Converts the instance of [MuteMemberNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (opUser != null) {
      data['opUser'] = opUser!.toJson();
    }
    if (mutedUser != null) {
      data['mutedUser'] = mutedUser!.toJson();
    }
    data['mutedSeconds'] = mutedSeconds;
    return data;
  }
}

/// Notification for a burn-after-reading message setting.
class BurnAfterReadingNotification {
  /// Receiver's ID.
  String? recvID;

  /// Sender's ID.
  String? sendID;

  /// Whether the setting is private.
  bool? isPrivate;

  /// Constructor for [BurnAfterReadingNotification].
  BurnAfterReadingNotification({this.recvID, this.sendID, this.isPrivate});

  /// Creates an instance of [BurnAfterReadingNotification] from JSON.
  BurnAfterReadingNotification.fromJson(Map<String, dynamic> json) {
    recvID = json['recvID'];
    sendID = json['sendID'];
    isPrivate = json['isPrivate'];
  }

  /// Converts the instance of [BurnAfterReadingNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'recvID': recvID,
      'sendID': sendID,
      'isPrivate': isPrivate,
    };
    return data;
  }
}

/// Notification for changes in group member information.
class GroupMemberInfoChangedNotification {
  /// Group information.
  GroupInfo? group;

  /// Operator's information.
  GroupMembersInfo? opUser;

  /// Member whose information has changed.
  GroupMembersInfo? changedUser;

  /// Constructor for [GroupMemberInfoChangedNotification].
  GroupMemberInfoChangedNotification({
    this.group,
    this.opUser,
    this.changedUser,
  });

  /// Creates an instance of [GroupMemberInfoChangedNotification] from JSON.
  GroupMemberInfoChangedNotification.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? GroupInfo.fromJson(json['group']) : null;
    opUser = json['opUser'] != null ? GroupMembersInfo.fromJson(json['opUser']) : null;
    changedUser = json['changedUser'] != null ? GroupMembersInfo.fromJson(json['changedUser']) : null;
  }

  /// Converts the instance of [GroupMemberInfoChangedNotification] to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (opUser != null) {
      data['opUser'] = opUser!.toJson();
    }
    if (changedUser != null) {
      data['changedUser'] = changedUser!.toJson();
    }
    return data;
  }
}
