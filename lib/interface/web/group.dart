import '/enum/enum.dart';
import '/listener/listener.dart';
import '/model/group_info.dart';

import '../base/base_group.dart';

class WebGroup implements BaseGroup {
  @override
  Future<bool> acceptGroupApplication({required String groupID, required String userID, String? handleMsg, String? operationID}) {
    // TODO: implement acceptGroupApplication
    throw UnimplementedError();
  }

  @override
  Future<bool> changeGroupMemberMute({required String groupID, required String userID, int seconds = 0, String? operationID}) {
    // TODO: implement changeGroupMemberMute
    throw UnimplementedError();
  }

  @override
  Future<bool> changeGroupMute({required String groupID, required bool mute, String? operationID}) {
    // TODO: implement changeGroupMute
    throw UnimplementedError();
  }

  @override
  Future<GroupInfo?> createGroup({required GroupInfo groupInfo, List<String> memberUserIDs = const [], List<String> adminUserIDs = const [], String? ownerUserID, String? operationID}) {
    // TODO: implement createGroup
    throw UnimplementedError();
  }

  @override
  Future<bool> dismissGroup({required String groupID, String? operationID}) {
    // TODO: implement dismissGroup
    throw UnimplementedError();
  }

  @override
  Future<List<GroupApplicationInfo>?> getGroupApplicationListAsApplicant({String? operationID}) {
    // TODO: implement getGroupApplicationListAsApplicant
    throw UnimplementedError();
  }

  @override
  Future<List<GroupApplicationInfo>?> getGroupApplicationListAsRecipient({String? operationID}) {
    // TODO: implement getGroupApplicationListAsRecipient
    throw UnimplementedError();
  }

  @override
  Future<List<GroupMembersInfo>?> getGroupMemberList({required String groupID, GroupMemberFilter filter = GroupMemberFilter.all, int offset = 0, int count = 0, String? operationID}) {
    // TODO: implement getGroupMemberList
    throw UnimplementedError();
  }

  @override
  Future<List<GroupMembersInfo>?> getGroupMemberListByJoinTime({required String groupID, int offset = 0, int count = 0, int joinTimeBegin = 0, int joinTimeEnd = 0, List<String> filterUserIDs = const [], String? operationID}) {
    // TODO: implement getGroupMemberListByJoinTime
    throw UnimplementedError();
  }

  @override
  Future<List?> getGroupMemberListMap({required String groupID, GroupMemberFilter filter = GroupMemberFilter.all, int offset = 0, int count = 0, String? operationID}) {
    // TODO: implement getGroupMemberListMap
    throw UnimplementedError();
  }

  @override
  Future<List<GroupMembersInfo>?> getGroupMembersInfo({required String groupID, required List<String> userIDs, String? operationID}) {
    // TODO: implement getGroupMembersInfo
    throw UnimplementedError();
  }

  @override
  Future<List<GroupMembersInfo>?> getGroupOwnerAndAdmin({required String groupID, String? operationID}) {
    // TODO: implement getGroupOwnerAndAdmin
    throw UnimplementedError();
  }

  @override
  Future<List<GroupInfo>?> getGroupsInfo({required List<String> groupIDs, String? operationID}) {
    // TODO: implement getGroupsInfo
    throw UnimplementedError();
  }

  @override
  Future<List<GroupInfo>?> getJoinedGroupList({String? operationID}) {
    // TODO: implement getJoinedGroupList
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?> getJoinedGroupListMap({String? operationID}) {
    // TODO: implement getJoinedGroupListMap
    throw UnimplementedError();
  }

  @override
  Future<List<GroupInfo>?> getJoinedGroupListPage({String? operationID, int offset = 0, int count = 40}) {
    // TODO: implement getJoinedGroupListPage
    throw UnimplementedError();
  }

  @override
  Future<bool> getUsersInGroup(String groupID, List<String> userIDs, {String? operationID}) {
    // TODO: implement getUsersInGroup
    throw UnimplementedError();
  }

  @override
  Future<List<GroupInviteResult>> inviteUserToGroup({required String groupID, required List<String> userIDs, String? reason, String? operationID}) {
    // TODO: implement inviteUserToGroup
    throw UnimplementedError();
  }

  @override
  Future<bool> isJoinedGroup({required String groupID, String? operationID}) {
    // TODO: implement isJoinedGroup
    throw UnimplementedError();
  }

  @override
  Future<bool> joinGroup({required String groupID, String? reason, String? operationID, JoinType joinSource = JoinType.search, String? ex}) {
    // TODO: implement joinGroup
    throw UnimplementedError();
  }

  @override
  Future<List<GroupInviteResult>?> kickGroupMember({required String groupID, required List<String> userIDs, String? reason, String? operationID}) {
    // TODO: implement kickGroupMember
    throw UnimplementedError();
  }

  @override
  Future<bool> quitGroup({required String groupID, String? operationID}) {
    // TODO: implement quitGroup
    throw UnimplementedError();
  }

  @override
  Future<bool> refuseGroupApplication({required String groupID, required String userID, String? handleMsg, String? operationID}) {
    // TODO: implement refuseGroupApplication
    throw UnimplementedError();
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    // TODO: implement removeListener
  }

  @override
  Future<List<GroupMembersInfo>?> searchGroupMembers({required String groupID, List<String> keywords = const [], bool isSearchUserID = false, bool isSearchMemberNickname = false, int offset = 0, int count = 40, String? operationID}) {
    // TODO: implement searchGroupMembers
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?> searchGroupMembersListMap({required String groupID, List<String> keywords = const [], bool isSearchUserID = false, bool isSearchMemberNickname = false, int offset = 0, int count = 40, String? operationID}) {
    // TODO: implement searchGroupMembersListMap
    throw UnimplementedError();
  }

  @override
  Future<List<GroupInfo>?> searchGroups({List<String> keywords = const [], bool isSearchGroupID = false, bool isSearchGroupName = false, String? operationID}) {
    // TODO: implement searchGroups
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupApplyMemberFriend({required String groupID, required int status, String? operationID}) {
    // TODO: implement setGroupApplyMemberFriend
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupInfo(GroupInfo groupInfo, {String? operationID}) {
    // TODO: implement setGroupInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupLookMemberInfo({required String groupID, required int status, String? operationID}) {
    // TODO: implement setGroupLookMemberInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupMemberInfo({required GroupMembersInfo groupMembersInfo, String? operationID}) {
    // TODO: implement setGroupMemberInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupMemberNickname({required String groupID, required String userID, String? groupNickname, String? operationID}) {
    // TODO: implement setGroupMemberNickname
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupMemberRoleLevel({required String groupID, required String userID, required int roleLevel, String? operationID}) {
    // TODO: implement setGroupMemberRoleLevel
    throw UnimplementedError();
  }

  @override
  Future<bool> setGroupVerification({required String groupID, required GroupVerificationType needVerification, String? operationID}) {
    // TODO: implement setGroupVerification
    throw UnimplementedError();
  }

  @override
  void setListener<T extends Listener>(T listener) {
    // TODO: implement setListener
  }

  @override
  Future<bool> transferGroupOwner({required String groupID, required String userID, String? operationID}) {
    // TODO: implement transferGroupOwner
    throw UnimplementedError();
  }
}
