import '/enum/enum.dart';

import '../../model/group_info.dart';
import 'base_listener.dart';

abstract class BaseGroup implements BaseListener {
  /// Invite users to a group, allowing them to join without approval.
  /// [groupID] Group ID
  /// [userIDs] List of user IDs
  Future<List<GroupInviteResult>> inviteUserToGroup({
    required String groupID,
    required List<String> userIDs,
    String? reason,
    String? operationID,
  });

  /// Remove group members
  /// [groupID] Group ID
  /// [userIDs] List of user IDs
  /// [reason] Reason for removal
  Future<List<GroupInviteResult>> kickGroupMember({
    required String groupID,
    required List<String> userIDs,
    String? reason,
    String? operationID,
  });

  /// Query group member information
  /// [groupID] Group ID
  /// [userIDs] List of user IDs
  Future<List<GroupMembersInfo>> getGroupMembersInfo({
    required String groupID,
    required List<String> userIDs,
    String? operationID,
  });

  /// Paginate and retrieve the group member list
  Future<List<GroupMembersInfo>> getGroupMemberList({
    required String groupID,
    GroupMemberFilter filter = GroupMemberFilter.all,
    int offset = 0,
    int count = 0,
    String? operationID,
  });

  /// Paginate and retrieve the group member list as a map
  Future<List<dynamic>> getGroupMemberListMap({
    required String groupID,
    GroupMemberFilter filter = GroupMemberFilter.all,
    int offset = 0,
    int count = 0,
    String? operationID,
  });

  /// Query the list of joined groups
  Future<List<GroupInfo>?> getJoinedGroupList({
    String? operationID,
  });

  Future<List<GroupInfo>> getJoinedGroupListPage({
    String? operationID,
    int offset = 0,
    int count = 40,
  });

  /// Query the list of joined groups as a map
  Future<List<dynamic>> getJoinedGroupListMap({
    String? operationID,
  });

  /// Check if the user has joined a group
  Future<bool> isJoinedGroup({
    required String groupID,
    String? operationID,
  });

  /// Create a new group
  Future<GroupInfo?> createGroup({
    required GroupInfo groupInfo,
    List<String> memberUserIDs = const [],
    List<String> adminUserIDs = const [],
    String? ownerUserID,
    String? operationID,
  });

  /// Edit group information
  Future<bool> setGroupInfo(
    GroupInfo groupInfo, {
    String? operationID,
  });

  /// Query group information
  Future<List<GroupInfo>> getGroupsInfo({
    required List<String> groupIDs,
    String? operationID,
  });

  /// Apply to join a group
  Future<bool> joinGroup({
    required String groupID,
    String? reason,
    String? operationID,
    JoinType joinSource = JoinType.search,
    String? ex,
  });

  /// Exit a group
  Future<bool> quitGroup({
    required String groupID,
    String? operationID,
  });

  /// Transfer group ownership
  Future<bool> transferGroupOwner({
    required String groupID,
    required String userID,
    String? operationID,
  });

  /// Handle group membership applications received as a group owner or administrator
  Future<List<GroupApplicationInfo>> getGroupApplicationListAsRecipient({
    String? operationID,
  });

  /// Get the list of group membership applications sent by the user
  Future<List<GroupApplicationInfo>> getGroupApplicationListAsApplicant({
    String? operationID,
  });

  /// Accept a group membership application as an administrator or group owner
  Future<bool> acceptGroupApplication({
    required String groupID,
    required String userID,
    String? handleMsg,
    String? operationID,
  });

  /// Refuse a group membership application as an administrator or group owner
  Future<bool> refuseGroupApplication({
    required String groupID,
    required String userID,
    String? handleMsg,
    String? operationID,
  });

  /// Dissolve a group
  Future<bool> dismissGroup({
    required String groupID,
    String? operationID,
  });

  /// Enable or disable group mute
  Future<bool> changeGroupMute({
    required String groupID,
    required bool mute,
    String? operationID,
  });

  /// Mute a group member
  Future<bool> changeGroupMemberMute({
    required String groupID,
    required String userID,
    int seconds = 0,
    String? operationID,
  });

  /// Set the nickname of a group member
  @Deprecated('Use [setGroupMemberInfo] instead')
  Future<bool> setGroupMemberNickname({
    required String groupID,
    required String userID,
    String? groupNickname,
    String? operationID,
  });

  /// Search for groups
  Future<List<GroupInfo>> searchGroups({
    List<String> keywords = const [],
    bool isSearchGroupID = false,
    bool isSearchGroupName = false,
    String? operationID,
  });

  /// Set group member role
  @Deprecated('Use [setGroupMemberInfo] instead')
  Future<bool> setGroupMemberRoleLevel({
    required String groupID,
    required String userID,
    required int roleLevel,
    String? operationID,
  });

  /// Get a group member list based on join time
  Future<List<GroupMembersInfo>> getGroupMemberListByJoinTime({
    required String groupID,
    int offset = 0,
    int count = 0,
    int joinTimeBegin = 0,
    int joinTimeEnd = 0,
    List<String> filterUserIDs = const [],
    String? operationID,
  });

  /// Set group verification
  @Deprecated('Use [setGroupInfo] instead')
  Future<bool> setGroupVerification({
    required String groupID,
    required GroupVerificationType needVerification,
    String? operationID,
  });

  /// Allow/disallow members to add friends through the group
  @Deprecated('Use [setGroupInfo] instead')
  Future<bool> setGroupLookMemberInfo({
    required String groupID,
    required int status,
    String? operationID,
  });

  /// Allow/disallow members to add friends through the group
  @Deprecated('Use [setGroupInfo] instead')
  Future<bool> setGroupApplyMemberFriend({
    required String groupID,
    required int status,
    String? operationID,
  });

  /// Get group owners and administrators
  Future<List<GroupMembersInfo>> getGroupOwnerAndAdmin({
    required String groupID,
    String? operationID,
  });

  /// Search for group members
  Future<List<GroupMembersInfo>> searchGroupMembers({
    required String groupID,
    List<String> keywords = const [],
    bool isSearchUserID = false,
    bool isSearchMemberNickname = false,
    int offset = 0,
    int count = 40,
    String? operationID,
  });

  /// Search for group members as a map
  Future<List<dynamic>> searchGroupMembersListMap({
    required String groupID,
    List<String> keywords = const [],
    bool isSearchUserID = false,
    bool isSearchMemberNickname = false,
    int offset = 0,
    int count = 40,
    String? operationID,
  });

  /// Modify the GroupMemberInfo ex field
  Future<bool> setGroupMemberInfo({
    required GroupMembersInfo groupMembersInfo,
    String? operationID,
  });

  /// Get users in the group
  Future<bool> getUsersInGroup(
    String groupID,
    List<String> userIDs, {
    String? operationID,
  });
}
