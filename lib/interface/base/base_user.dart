import '../../model/user_info.dart';
import 'base_listener.dart';

abstract class BaseUser implements BaseListener {
  const BaseUser();

  /// Get user information
  /// [userIDs] List of user IDs
  Future<List<PublicUserInfo>> getUsersInfo(
    List<String> userIDs, {
    String? operationID,
  });

  /// Get the information of the currently logged-in user
  Future<UserInfo> getSelfUserInfo({
    String? operationID,
  });

  /// Get user information with cache (Deprecated)
  /// Use [getUsersInfo] instead
  @Deprecated('Use [getUsersInfo] instead')
  Future<List<PublicUserInfo>> getUsersInfoWithCache(
    List<String> userIDs, {
    String? operationID,
  });

  /// Modify the profile of the currently logged-in user
  /// [nickname] Nickname
  /// [faceURL] Profile picture URL
  /// [globalRecvMsgOpt] Global receive message option
  /// [ex] Additional fields
  Future<bool> setSelfInfo({
    String? nickname,
    String? faceURL,
    int? globalRecvMsgOpt,
    String? ex,
    String? operationID,
  });

  /// Set global receive message options (Deprecated)
  /// Use [setSelfInfo] instead
  @Deprecated('use [setSelfInfo] instead')
  Future<bool> setGlobalRecvMessageOpt({
    required int status,
    String? operationID,
  });

  /// Subscribe to user status
  /// [userIDs] List of user IDs to subscribe to
  Future<List<UserStatusInfo>> subscribeUsersStatus(
    List<String> userIDs, {
    String? operationID,
  });

  /// Unsubscribe from user status
  /// [userIDs] List of user IDs to unsubscribe from
  Future<bool> unsubscribeUsersStatus(
    List<String> userIDs, {
    String? operationID,
  });

  /// Get the status of subscribed users
  Future<List<UserStatusInfo>> getSubscribeUsersStatus({
    String? operationID,
  });

  /// Get the status of specific users
  /// [userIDs] List of user IDs to query status
  Future<List<UserStatusInfo>> getUserStatus(
    List<String> userIDs, {
    String? operationID,
  });
}
