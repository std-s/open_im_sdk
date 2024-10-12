import 'package:flutter/foundation.dart';

import 'interface/base/base_connection.dart';
import 'interface/base/base_conversation.dart';
import 'interface/base/base_friendship.dart';
import 'interface/base/base_group.dart';
import 'interface/base/base_message.dart';
import 'interface/base/base_user.dart';
import 'interface/native/connection.dart';
import 'interface/web/connection.dart';
import 'interface/native/conversation.dart';
import 'interface/native/friendship.dart';
import 'interface/native/group.dart';
import 'interface/native/message.dart';
import 'interface/native/user.dart';
import 'interface/web/conversation.dart';
import 'interface/web/friendship.dart';
import 'interface/web/group.dart';
import 'interface/web/message.dart';
import 'interface/web/user.dart';
// Compatible with old versions of SDK.
class OpenIM {
  static const version = '3.8.1';

  static IMManager iMManager = IMManager();
}

class IMManager {
  static IMManager? _instance;

  factory IMManager() {
    _instance ??= IMManager._();

    return _instance!;
  }

  IMManager._() {
    _initConnection();
    _initUser();
    _initConversation();
    _initMessage();
    _initFriendship();
    _initGroup();
    _initSignaling();
  }

  late final BaseConnection connection;
  late final BaseUser user;
  late final BaseConversation conversation;
  late final BaseMessage message;
  late final BaseFriendship friendship;
  late final BaseGroup group;

  // Compatible with old versions
  BaseConnection get connectionManager => connection;
  BaseUser get userManager => user;
  BaseConversation get conversationManager => conversation;
  BaseMessage get messageManager => message;
  BaseFriendship get friendshipManager => friendship;
  BaseGroup get groupManager => group;

  void _initConnection() {
    if (kIsWeb) {
      connection = WebConnection();
    } else {
      connection = NativeConnection();
    }
  }

  void _initUser() {
    if (kIsWeb) {
      user = WebUser();
    } else {
      user = NativeUser();
    }
  }

  void _initConversation() {
    if (kIsWeb) {
      conversation = WebConversation();
    } else {
      conversation = NativeConversation();
    }
  }

  void _initMessage() {
    if (kIsWeb) {
      message = WebMessage();
    } else {
      message = NativeMessage();
    }
  }

  void _initFriendship() {
    if (kIsWeb) {
      friendship = WebFriendship();
    } else {
      friendship = NativeFriendship();
    }
  }

  void _initGroup() {
    if (kIsWeb) {
      group = WebGroup();
    } else {
      group = NativeGroup();
    }
  }

  void _initSignaling() {}
}
