import '/listener/listener.dart';
import '/model/search_info.dart';
import '/model/update_req.dart';
import '/model/user_info.dart';

import '../base/base_friendship.dart';

class WebFriendship implements BaseFriendship {
  @override
  Future<bool> acceptFriendApplication({required String userID, String? handleMsg, String? operationID}) {
    // TODO: implement acceptFriendApplication
    throw UnimplementedError();
  }

  @override
  Future<bool> addBlacklist({required String userID, String? ex, String? operationID}) {
    // TODO: implement addBlacklist
    throw UnimplementedError();
  }

  @override
  Future<bool> addFriend({required String userID, String? reason, String? operationID}) {
    // TODO: implement addFriend
    throw UnimplementedError();
  }

  @override
  Future<List<FriendshipInfo>> checkFriend({required List<String> userIDs, String? operationID}) {
    // TODO: implement checkFriend
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteFriend({required String userID, String? operationID}) {
    // TODO: implement deleteFriend
    throw UnimplementedError();
  }

  @override
  Future<List<BlacklistInfo>> getBlacklist({String? operationID}) {
    // TODO: implement getBlacklist
    throw UnimplementedError();
  }

  @override
  Future<List<FriendApplicationInfo>> getFriendApplicationListAsApplicant({String? operationID}) {
    // TODO: implement getFriendApplicationListAsApplicant
    throw UnimplementedError();
  }

  @override
  Future<List<FriendApplicationInfo>> getFriendApplicationListAsRecipient({String? operationID}) {
    // TODO: implement getFriendApplicationListAsRecipient
    throw UnimplementedError();
  }

  @override
  Future<List<PublicUserInfo>?> getFriendList({String? operationID, bool filterBlack = false}) {
    // TODO: implement getFriendList
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?> getFriendListMap({String? operationID}) {
    // TODO: implement getFriendListMap
    throw UnimplementedError();
  }

  @override
  Future<List<PublicUserInfo>?> getFriendListPage({bool filterBlack = false, int offset = 0, int count = 40, String? operationID}) {
    // TODO: implement getFriendListPage
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?> getFriendListPageMap({bool filterBlack = false, String? operationID, int offset = 0, int count = 40}) {
    // TODO: implement getFriendListPageMap
    throw UnimplementedError();
  }

  @override
  Future<List<PublicUserInfo>> getFriendsInfo({required List<String> userIDs, bool filterBlack = false, String? operationID}) {
    // TODO: implement getFriendsInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> refuseFriendApplication({required String userID, String? handleMsg, String? operationID}) {
    // TODO: implement refuseFriendApplication
    throw UnimplementedError();
  }

  @override
  Future<bool> removeBlacklist({required String userID, String? operationID}) {
    // TODO: implement removeBlacklist
    throw UnimplementedError();
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    // TODO: implement removeListener
  }

  @override
  Future<List<SearchFriendsInfo>> searchFriends({List<String> keywords = const [], bool isSearchUserID = false, bool isSearchNickname = false, bool isSearchRemark = false, String? operationID}) {
    // TODO: implement searchFriends
    throw UnimplementedError();
  }

  @override
  Future setFriendRemark({required String userID, required String remark, String? operationID}) {
    // TODO: implement setFriendRemark
    throw UnimplementedError();
  }

  @override
  Future<bool> setFriendsEx(List<String> friendIDs, {String? ex, String? operationID}) {
    // TODO: implement setFriendsEx
    throw UnimplementedError();
  }

  @override
  void setListener<T extends Listener>(T listener) {
    // TODO: implement setListener
  }

  @override
  Future<bool> updateFriends(UpdateFriendsReq updateFriendsReq, {String? operationID}) {
    // TODO: implement updateFriends
    throw UnimplementedError();
  }
}
