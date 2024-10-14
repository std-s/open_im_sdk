import '../../model/search_info.dart';
import '../../model/update_req.dart';
import '../../model/user_info.dart';
import 'base_listener.dart';

abstract class BaseFriendship implements BaseListener {
  /// Query Friend Information
  /// [userIDs] List of user IDs
  /// [filterBlack] Filter blacklisted users
  Future<List<PublicUserInfo>?> getFriendsInfo({
    required List<String> userIDs,
    bool filterBlack = false,
    String? operationID,
  });

  /// Send a Friend Request, the other party needs to accept the request to become friends.
  /// [userID] User ID to be invited
  /// [reason] Remark description
  Future<bool> addFriend({
    required String userID,
    String? reason,
    String? operationID,
  });

  /// Get Friend Requests Sent to Me
  Future<List<FriendApplicationInfo>?> getFriendApplicationListAsRecipient({
    String? operationID,
  });

  /// Get Friend Requests Sent by Me
  Future<List<FriendApplicationInfo>?> getFriendApplicationListAsApplicant({
    String? operationID,
  });

  /// Get Friend List, including friends who have been put into the blacklist
  Future<List<FriendInfo>?> getFriendList({
    String? operationID,
    bool filterBlack = false,
  });

  Future<List<FriendInfo>?> getFriendListPage({
    bool filterBlack = false,
    int offset = 0,
    int count = 40,
    String? operationID,
  });

  /// Get Friend List, including friends who have been put into the blacklist (returns a map)
  Future<List<Map<String, dynamic>>?> getFriendListMap({
    String? operationID,
  });

  Future<List<Map<String, dynamic>>?> getFriendListPageMap({
    bool filterBlack = false,
    String? operationID,
    int offset = 0,
    int count = 40,
  });

  /// Set Friend's Remark
  /// [userID] Friend's userID
  /// [remark] Friend's remark
  @Deprecated('Use [updateFriends] instead')
  Future<bool> setFriendRemark({
    required String userID,
    required String remark,
    String? operationID,
  });

  /// Add to Blacklist
  /// [userID] Friend's ID to be added to the blacklist
  Future<bool> addBlacklist({
    required String userID,
    String? ex,
    String? operationID,
  });

  /// Get Blacklist
  Future<List<BlacklistInfo>?> getBlacklist({
    String? operationID,
  });

  /// Remove from Blacklist
  /// [userID] User ID
  Future<bool> removeBlacklist({
    required String userID,
    String? operationID,
  });

  /// Check Friendship Status
  /// [userIDs] List of user IDs
  Future<List<FriendshipInfo>?> checkFriend({
    required List<String> userIDs,
    String? operationID,
  });

  /// Delete Friend
  /// [userID] User ID
  Future<bool> deleteFriend({
    required String userID,
    String? operationID,
  });

  /// Accept Friend Request
  /// [userID] User ID
  /// [handleMsg] Remark description
  Future<bool> acceptFriendApplication({
    required String userID,
    String? handleMsg,
    String? operationID,
  });

  /// Reject Friend Request
  /// [userID] User ID
  /// [handleMsg] Remark description
  Future<bool> refuseFriendApplication({
    required String userID,
    String? handleMsg,
    String? operationID,
  });

  /// Search for Friends
  /// [keywords] Search keywords, currently supports only one keyword search, cannot be empty
  /// [isSearchUserID] Whether to search for friend IDs with keywords
  /// [isSearchNickname] Whether to search by nickname with keywords
  /// [isSearchRemark] Whether to search by remark name with keywords
  Future<List<SearchFriendsInfo>?> searchFriends({
    List<String> keywords = const [],
    bool isSearchUserID = false,
    bool isSearchNickname = false,
    bool isSearchRemark = false,
    String? operationID,
  });

  @Deprecated('Use [updateFriends] instead')
  Future<bool> setFriendsEx(
    List<String> friendIDs, {
    String? ex,
    String? operationID,
  });

  Future<bool> updateFriends(
    UpdateFriendsReq updateFriendsReq, {
    String? operationID,
  });
}
