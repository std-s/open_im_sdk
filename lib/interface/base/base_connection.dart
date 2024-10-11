import 'dart:async';

import 'package:open_im_sdk/interface/base/base_listener.dart';

import '../../enum/enum.dart';
import '../../listener/listener.dart';
import '../../model/init_config.dart';

abstract class BaseConnection implements BaseListener {
  const BaseConnection();

  Future<bool> initSDK(
    InitConfig config, {
    OnConnectListener? listener,
    String? operationID,
  });
  Future<bool> login(
    String userID,
    String token, {
    String? operationID,
  });

  Future<bool> logout({
    String? operationID,
  });

  LoginStatus getLoginStatus({
    String? operationID,
  });

  Future<bool> uploadFile({
    required String id,
    required String filePath,
    required String fileName,
    String? contentType,
    String? cause,
    OnUploadFileListener? onProgressListener,
    String? operationID,
  });

  Future<bool> updateFcmToken({
    required String fcmToken,
    required int expireTime,
    String? operationID,
  });

  Future<bool> uploadLogs({
    String? ex,
    int line = 0,
    OnUploadLogsListener? onProgressListener,
    String? operationID,
  });

  Future<bool> logs({
    int logLevel = 5,
    String? file,
    int line = 0,
    String? msgs,
    String? err,
    List<dynamic>? keyAndValues,
    String? operationID,
  });
}
