import '/enum/enum.dart';
import '/listener/listener.dart';
import '/model/init_config.dart';
import '../base/base_connection.dart';

class WebConnection implements BaseConnection {
  @override
  LoginStatus getLoginStatus({String? operationID}) {
    // TODO: implement getLoginStatus
    throw UnimplementedError();
  }

  @override
  Future<bool> initSDK(InitConfig config, {OnConnectListener? listener, String? operationID}) {
    // TODO: implement initSDK
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String userID, String token, {String? operationID}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout({String? operationID}) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> logs(
      {int logLevel = 5,
      String? file,
      int line = 0,
      String? msgs,
      String? err,
      List? keyAndValues,
      String? operationID}) {
    // TODO: implement logs
    throw UnimplementedError();
  }

  @override
  void removeListener<T extends Listener>(T listener) {
    // TODO: implement removeListener
  }

  @override
  void setListener<T extends Listener>(T listener) {
    // TODO: implement setListener
  }

  @override
  Future<bool> updateFcmToken({required String fcmToken, required int expireTime, String? operationID}) {
    // TODO: implement updateFcmToken
    throw UnimplementedError();
  }

  @override
  Future<bool> uploadFile(
      {required String id,
      required String filePath,
      required String fileName,
      String? contentType,
      String? cause,
      OnUploadFileListener? onProgressListener,
      String? operationID}) {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }

  @override
  Future<bool> uploadLogs({String? ex, int line = 0, OnUploadLogsListener? onProgressListener, String? operationID}) {
    // TODO: implement uploadLogs
    throw UnimplementedError();
  }
}
