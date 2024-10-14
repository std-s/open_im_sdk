import '/listener/listener.dart';
import '/model/user_info.dart';

import '../base/base_user.dart';

class WebUser extends BaseUser {
  @override
  Future<UserInfo?> getSelfUserInfo({String? operationID}) {
    // TODO: implement getSelfUserInfo
    throw UnimplementedError();
  }

  @override
  Future<List<UserStatusInfo>> getSubscribeUsersStatus({String? operationID}) {
    // TODO: implement getSubscribeUsersStatus
    throw UnimplementedError();
  }

  @override
  Future<List<UserStatusInfo>> getUserStatus(List<String> userIDs,
      {String? operationID}) {
    // TODO: implement getUserStatus
    throw UnimplementedError();
  }

  @override
  Future<List<PublicUserInfo>> getUsersInfo(List<String> userIDs,
      {String? operationID}) {
    // TODO: implement getUsersInfo
    throw UnimplementedError();
  }

  @override
  Future<List<PublicUserInfo>> getUsersInfoWithCache(List<String> userIDs,
      {String? operationID}) {
    // TODO: implement getUsersInfoWithCache
    throw UnimplementedError();
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    // TODO: implement removeListener
  }

  @override
  Future<bool> setGlobalRecvMessageOpt(
      {required int status, String? operationID}) {
    // TODO: implement setGlobalRecvMessageOpt
    throw UnimplementedError();
  }

  @override
  void setListener<T extends Listener>(T listener) {
    // TODO: implement setListener
  }

  @override
  Future<bool> setSelfInfo(
      {String? nickname,
      String? faceURL,
      int? globalRecvMsgOpt,
      String? ex,
      String? operationID}) {
    // TODO: implement setSelfInfo
    throw UnimplementedError();
  }

  @override
  Future<List<UserStatusInfo>> subscribeUsersStatus(List<String> userIDs,
      {String? operationID}) {
    // TODO: implement subscribeUsersStatus
    throw UnimplementedError();
  }

  @override
  Future<bool> unsubscribeUsersStatus(List<String> userIDs,
      {String? operationID}) {
    // TODO: implement unsubscribeUsersStatus
    throw UnimplementedError();
  }
  
  @override
  String getLoginUserID({String? operationID}) {
    // TODO: implement getLoginUserID
    throw UnimplementedError();
  }
}
