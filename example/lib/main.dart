// import 'dart:io';

import 'package:flutter/material.dart';

import 'package:open_im_sdk/open_im_sdk.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((dic) {
      final params = InitConfig(
        apiAddr: 'http://172.16.8.48:10002',
        wsAddr: 'ws://172.16.8.48:10001',
        dataDir: dic.path,
        logFilePath: '${dic.path}/log',
      );
      OpenIM.manager.connection.initSDK(params);

      OpenIM.manager.connection.setListener(OnConnectListener(onConnecting: () {
        debugPrint('onConnecting');
      }, onConnectSuccess: () {
        debugPrint('onConnectSuccess');
      }, onConnectFailed: (code, msg) {
        debugPrint('onConnectFailed $code $msg');
      }, onKickedOffline: () {
        debugPrint('onKickedOffline');
      }, onUserTokenExpired: () {
        debugPrint('onUserTokenExpired');
      }, onUserTokenInvalid: (msg) {
        debugPrint('onUserTokenInvalid $msg');
      }));

      IMManager().user.setListener<OnUserListener>(OnUserListener(
            onSelfInfoUpdated: (info) {
              print('onSelfInfoUpdated ${info.toJson()}');
            },
            onUserStatusChanged: (info) {
              print('onUserStatusChanged ${info.toJson()}');
            },
          ));

      IMManager().conversation.setListener(OnConversationListener(
            onConversationChanged: (list) {
              debugPrint('onConversationChanged ${list.length}');
              // list.forEach((e) {
              //   print('onConversationChanged ${e.toJson()}');
              // });
            },
            onNewConversation: (list) {
              debugPrint('onNewConversation ${list.length}');
              // list.forEach((e) {
              //   print('onConversationChanged ${e.toJson()}');
              // });
            },
            onTotalUnreadMessageCountChanged: (count) {
              debugPrint('onTotalUnreadMessageCountChanged $count');
            },
            onSyncServerStart: (reinstalled) {
              debugPrint('onSyncServerStart $reinstalled');
            },
            onSyncServerProgress: (progress) {
              debugPrint('onSyncServerProgress $progress');
            },
            onSyncServerFinish: (reinstalled) {
              debugPrint('onSyncServerFinish $reinstalled');
            },
            onSyncServerFailed: (reinstalled) {
              debugPrint('onSyncServerFailed $reinstalled');
            },
          ));

      IMManager().message.setListener(OnAdvancedMsgListener(
            onRecvNewMessage: (msg) {
              print('onRecvNewMessage ${msg.toJson()}');
            },
            onNewRecvMessageRevoked: (info) {
              print('onNewRecvMessageRevoked ${info.toJson()}');
            },
            onRecvC2CReadReceipt: (list) {
              list.forEach((e) {
                print('onRecvC2CReadReceipt ${e.toJson()}');
              });
            },
            onRecvGroupReadReceipt: (receipt) {
              print('onRecvGroupReadReceipt ${receipt.toJson()}');
            },
          ));
      IMManager().group.setListener(OnGroupListener(
            onGroupApplicationAccepted: (info) {
              print('onGroupApplicationAccepted ${info.toJson()}');
            },
            onGroupApplicationAdded: (info) {
              print('onGroupApplicationAdded ${info.toJson()}');
            },
            onGroupApplicationDeleted: (info) {
              print('onGroupApplicationDeleted ${info.toJson()}');
            },
            onGroupApplicationRejected: (info) {
              print('onGroupApplicationRejected ${info.toJson()}');
            },
            onGroupInfoChanged: (info) {
              print('onGroupInfoChanged ${info.toJson()}');
            },
            onGroupMemberAdded: (info) {
              print('onGroupMemberAdded ${info.toJson()}');
            },
            onGroupMemberDeleted: (info) {
              print('onGroupMemberDeleted ${info.toJson()}');
            },
            onGroupMemberInfoChanged: (info) {
              print('onGroupMemberInfoChanged ${info.toJson()}');
            },
            onGroupDismissed: (info) {
              print('onGroupDismissed ${info.toJson()}');
            },
            onJoinedGroupAdded: (info) {
              print('onJoinedGroupAdded ${info.toJson()}');
            },
            onJoinedGroupDeleted: (info) {
              print('onJoinedGroupDeleted ${info.toJson()}');
            },
          ));

      IMManager().friendship.setListener(OnFriendshipListener(
            onBlackAdded: (info) {
              print('onBlackAdded ${info.toJson()}');
            },
            onBlackDeleted: (info) {
              print('onBlackDeleted ${info.toJson()}');
            },
            onFriendAdded: (info) {
              print('onFriendAdded ${info.toJson()}');
            },
            onFriendApplicationAccepted: (info) {
              print('onFriendApplicationAccepted ${info.toJson()}');
            },
            onFriendApplicationAdded: (info) {
              print('onFriendApplicationAdded ${info.toJson()}');
            },
            onFriendApplicationDeleted: (info) {
              print('onFriendApplicationDeleted ${info.toJson()}');
            },
            onFriendApplicationRejected: (info) {
              print('onFriendApplicationRejected ${info.toJson()}');
            },
            onFriendInfoChanged: (info) {
              print('onFriendInfoChanged ${info.toJson()}');
            },
            onFriendDeleted: (info) {
              print('onFriendDeleted ${info.toJson()}');
            },
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: _buildWrapView(),
        ),
      ),
    );
  }

  Widget _buildWrapView() {
    return Wrap(
      children: [
        _buildWrapItem('Login', () {
          IMManager()
              .connection
              .login(
                '7366504584',
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiI3MzY2NTA0NTg0IiwiUGxhdGZvcm1JRCI6MiwiZXhwIjoxNzM2NDA0NjUzLCJuYmYiOjE3Mjg2MjgzNTMsImlhdCI6MTcyODYyODY1M30.wff9CXrYbM5KwiI2UWdZAKNo8MYWFkzBFVQ8QhOsJZA',
              )
              .onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return false;
          });
        }),
        _buildWrapItem('GetSelfUserInfo', () async {
          final usersInfo = await IMManager().user.getSelfUserInfo();
          print(usersInfo.toJson());
        }),
        _buildWrapItem('SetSelfInfo', () async {
          IMManager().user.setSelfInfo(nickname: 'test').onError((error, s) {
            debugPrint(error.toString());

            return false;
          });
        }),
        _buildWrapItem('SendMessage', () async {
          final message = MessageExt.text(text: 'text');

          // final directory = await getApplicationDocumentsDirectory();
          // final data = await rootBundle.load('assets/test_gif.gif');
          // File file = File('${directory.path}/test_gif.gif');
          // await file.writeAsBytes(data.buffer.asUint8List());
          // print('File written to: ${file.path}');
          // final message = MessageExt.image(absolutePath: file.path);

          final res = await IMManager()
              .message
              .sendMessage(
                message: message,
                offlinePushInfo: OfflinePushInfo(title: 'test message', desc: 'test message desc'),
                userID: '3615402097',
              )
              .onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return null;
          });

          //   final json = {
          //     'url':
          //         'https://web.rentsoft.cn/api_enterprise/object/6105455334/msg_picture_a730ff297a9b5fb0af1f6c8a9a99a221.gif'
          //   };
          //   final message = MessageExt.imageByURL(
          //     sourcePicture: PictureInfo.fromJson(json),
          //     bigPicture: PictureInfo.fromJson(json),
          //     snapshotPicture: PictureInfo.fromJson(json),
          //   );
          //   final res = await IMManager().message.sendMessageNotOss(
          //         message: message,
          //         offlinePushInfo: OfflinePushInfo(title: 'test message', desc: 'test message desc'),
          //         groupID: '247428675',
          //       );

          print('sendMessage result: ${res?.toJson()}');
        }),
        _buildWrapItem('InsertMessage', () async {
          final message = MessageExt.text(text: 'text');
          final res = await IMManager()
              .message
              .insertSingleMessageToLocalStorage(
                message: message,
                receiverID: '247428675',
                senderID: '6105455334',
              )
              .onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return null;
          });
          print('insertMessage result: ${res?.toJson()}');
        }),
        _buildWrapItem('getJoinedGroupList', () async {
          final groups = await IMManager().group.getJoinedGroupList().onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return null;
          });
          print('getJoinedGroupList result: ${groups?.length}');
          groups?.forEach((group) {
            print('${group.toJson()}');
          });
        }),
        _buildWrapItem('CreateGroup', () async {
          final groupInfo = GroupInfo(
            groupName: 'testGroup',
            introduction: 'testGroup',
            notification: 'testGroup',
            faceURL:
                'https://web.rentsoft.cn/api_enterprise/object/6105455334/msg_picture_a730ff297a9b5fb0af1f6c8a9a99a221.gif',
            ownerUserID: '6105455334',
          );
          final res = await IMManager().group.createGroup(groupInfo: groupInfo).onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return null;
          });
          print('createGroup result: ${res?.toJson()}');
        }),
        _buildWrapItem('GetFriendList', () async {
          final friends = await IMManager().friendship.getFriendList().onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return null;
          });

          print('getFriendList result: ${friends?.length}');
          friends?.forEach((friend) {
            print('${friend.toJson()}');
          });
        }),
        _buildWrapItem('AddFriend', () async {
          final res = await IMManager().friendship.addFriend(userID: '1531800981').onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return false;
          });
          print('addFriend result: $res');
        }),
        _buildWrapItem('DeleteFriend', () async {
          final res = await IMManager().friendship.deleteFriend(userID: '1531800981').onError((error, s) {
            if (error is IMSDKError) {
              debugPrint(error.message);
            }
            return false;
          });
          print('deleteFriend result: $res');
        }),
      ],
    );
  }

  Widget _buildWrapItem(String title, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
