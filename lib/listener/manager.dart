import 'dart:ffi' as ffi;
import 'package:flutter/foundation.dart';
import 'package:ffi/ffi.dart';

import '../utils/utils.dart';
import '../utils/define.dart';
import '../utils/sdk_bindings.dart';
import 'listener.dart';

class ListenerManager {
  static final ListenerManager _manager = ListenerManager._();
  final _bindings = SDKBindings().bindings;

  factory ListenerManager() {
    return _manager;
  }

  ListenerManager._();

  final List<OnConnectListener> _connectListeners = [];
  final List<OnUserListener> _userListeners = [];
  final List<OnConversationListener> _conversationListeners = [];
  final List<OnAdvancedMsgListener> _advancedMsgListeners = [];
  final List<OnFriendshipListener> _friendshipListeners = [];
  final List<OnGroupListener> _groupListeners = [];

  void addListener<T extends Listener>(T listener) {
    if (listener is OnConnectListener) {
      if (!_connectListeners.contains(listener)) {
        _connectListeners.add(listener);
      }
    } else if (listener is OnUserListener) {
      if (!_userListeners.contains(listener)) {
        _userListeners.add(listener);
      }
    } else if (listener is OnConversationListener) {
      if (!_conversationListeners.contains(listener)) {
        _conversationListeners.add(listener);
      }
    } else if (listener is OnAdvancedMsgListener) {
      if (!_advancedMsgListeners.contains(listener)) {
        _advancedMsgListeners.add(listener);
      }
    } else if (listener is OnFriendshipListener) {
      if (!_friendshipListeners.contains(listener)) {
        _friendshipListeners.add(listener);
      }
    } else if (listener is OnGroupListener) {
      if (!_groupListeners.contains(listener)) {
        _groupListeners.add(listener);
      }
    }
  }

  void removeListener<T extends Listener>(T listener) {
    if (listener is OnConnectListener) {
      _connectListeners.remove(listener);
    } else if (listener is OnUserListener) {
      _userListeners.remove(listener);
    } else if (listener is OnConversationListener) {
      _conversationListeners.remove(listener);
    } else if (listener is OnAdvancedMsgListener) {
      _advancedMsgListeners.remove(listener);
    } else if (listener is OnFriendshipListener) {
      _friendshipListeners.remove(listener);
    } else if (listener is OnGroupListener) {
      _groupListeners.remove(listener);
    }
  }

  T? _emit<T extends Listener>() {
    if (T == OnConnectListener) {
      for (var listener in _connectListeners) {
        return listener as T;
      }
    } else if (T == OnUserListener) {
      for (var listener in _userListeners) {
        return listener as T;
      }
    } else if (T == OnConversationListener) {
      for (var listener in _conversationListeners) {
        return listener as T;
      }
    } else if (T == OnAdvancedMsgListener) {
      for (var listener in _advancedMsgListeners) {
        return listener as T;
      }
    } else if (T == OnFriendshipListener) {
      for (var listener in _friendshipListeners) {
        return listener as T;
      }
    } else if (T == OnGroupListener) {
      for (var listener in _groupListeners) {
        return listener as T;
      }
    }

    return null;
  }

  void setSDKListener() {
    _setSDKUserListener();
    _setSDKConversationListener();
    _setSDKAdvancedMsgListener();
    _setSDKFriendshipListener();
    _setSDKGroupListener();
  }

  void _setSDKUserListener() {
    late final ffi.NativeCallable<CBISFunc> callback;

    void onResponse(int type, ffi.Pointer<ffi.Char> data) {
      debugPrint('setSDKUserListener onResponse: $type, ${data == ffi.nullptr ? 'data is null' : data.toDartString()}');

      if (data == ffi.nullptr) {
        return;
      }

      ListenerManager().emitEvent(type, data: data.toDartString());
      calloc.free(data);
    }

    callback = ffi.NativeCallable<CBISFunc>.listener(onResponse);

    _bindings.set_user_listener(callback.nativeFunction);
  }

  void _setSDKConversationListener() {
    late final ffi.NativeCallable<CBISFunc> callback;

    void onResponse(int type, ffi.Pointer<ffi.Char> data) {
      debugPrint(
          'setSDKConversationListener onResponse: $type, ${data == ffi.nullptr ? 'data is null' : data.toDartString()}');

      if (data == ffi.nullptr) {
        return;
      }

      ListenerManager().emitEvent(type, data: data.toDartString());
      calloc.free(data);
    }

    callback = ffi.NativeCallable<CBISFunc>.listener(onResponse);

    _bindings.set_conversation_listener(callback.nativeFunction);
  }

  void _setSDKAdvancedMsgListener() {
    late final ffi.NativeCallable<CBISFunc> callback;

    void onResponse(int type, ffi.Pointer<ffi.Char> data) {
      debugPrint(
          'setSDKAdvancedMsgListener onResponse: $type, ${data == ffi.nullptr ? 'data is null' : data.toDartString()}');

      if (data == ffi.nullptr) {
        return;
      }
      ListenerManager().emitEvent(type, data: data.toDartString());
      calloc.free(data);
    }

    callback = ffi.NativeCallable<CBISFunc>.listener(onResponse);

    _bindings.set_advanced_msg_listener(callback.nativeFunction);
  }

  void _setSDKFriendshipListener() {
    late final ffi.NativeCallable<CBISFunc> callback;

    void onResponse(int type, ffi.Pointer<ffi.Char> data) {
      debugPrint(
          'setSDKFriendshipListener onResponse: $type, ${data == ffi.nullptr ? 'data is null' : data.toDartString()}');
      if (data == ffi.nullptr) {
        return;
      }

      ListenerManager().emitEvent(type, data: data.toDartString());
      calloc.free(data);
    }

    callback = ffi.NativeCallable<CBISFunc>.listener(onResponse);

    _bindings.set_friend_listener(callback.nativeFunction);
  }

  void _setSDKGroupListener() {
    late final ffi.NativeCallable<CBISFunc> callback;

    void onResponse(int type, ffi.Pointer<ffi.Char> data) {
      debugPrint(
          'setSDKGroupListener onResponse: $type, ${data == ffi.nullptr ? 'data is null' : data.toDartString()}');

      if (data == ffi.nullptr) {
        return;
      }
      ListenerManager().emitEvent(type, data: data.toDartString());
      calloc.free(data);
    }

    callback = ffi.NativeCallable<CBISFunc>.listener(onResponse);

    _bindings.set_group_listener(callback.nativeFunction);
  }

  void emitEvent(int type, {dynamic data}) {
    final eventType = ListenerType.fromValue(type);

    debugPrint('handleListenerEvent $eventType $data[${data.runtimeType}]');

    if (data is String && data.trim().isEmpty) {
      debugPrint('data is empty, return');
      return;
    }

    _handleOnConnectListenerEvent(eventType, data);
    _handleOnUserListenerEvent(eventType, data);
    _handleOnConversationListenerEvent(eventType, data);
    _handleOnAdvancedMsgListenerEvent(eventType, data);
    _handleOnFriendshipListenerEvent(eventType, data);
    _handleOnGroupListenerEvent(eventType, data);
  }

  void _handleOnConnectListenerEvent(ListenerType eventType, dynamic data) {
    return _emit<OnConnectListener>()?.handleListenerEvent(eventType, data);
  }

  void _handleOnUserListenerEvent(ListenerType eventType, dynamic data) {
    return _emit<OnUserListener>()?.handleListenerEvent(eventType, data);
  }

  void _handleOnConversationListenerEvent(ListenerType eventType, dynamic data) {
    return _emit<OnConversationListener>()?.handleListenerEvent(eventType, data);
  }

  void _handleOnAdvancedMsgListenerEvent(ListenerType eventType, dynamic data) {
    return _emit<OnAdvancedMsgListener>()?.handleListenerEvent(eventType, data);
  }

  void _handleOnFriendshipListenerEvent(ListenerType eventType, dynamic data) {
    return _emit<OnFriendshipListener>()?.handleListenerEvent(eventType, data);
  }

  void _handleOnGroupListenerEvent(ListenerType eventType, dynamic data) {
    return _emit<OnGroupListener>()?.handleListenerEvent(eventType, data);
  }
}
