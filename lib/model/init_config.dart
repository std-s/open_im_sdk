import '../enum/enum.dart';

class InitConfig {
  String apiAddr;
  String wsAddr;
  String? dataDir;
  Loglevel logLevel;
  bool isLogStandardOutput;
  String? logFilePath;
  IMPlatform? platformID;

  InitConfig({
    required this.apiAddr,
    required this.wsAddr,
    this.dataDir,
    this.logLevel = Loglevel.debug,
    this.isLogStandardOutput = true,
    this.logFilePath,
    this.platformID,
  });

  factory InitConfig.fromJson(Map<String, dynamic> json) {
    return InitConfig(
      platformID: json['platformID'],
      apiAddr: json['apiAddr'],
      wsAddr: json['wsAddr'],
      dataDir: json['dataDir'],
      logLevel: json['logLevel'],
      isLogStandardOutput: json['isLogStandardOutput'],
      logFilePath: json['logFilePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platformID': platformID?.rawValue ?? IMPlatform.current.rawValue,
      'apiAddr': apiAddr,
      'wsAddr': wsAddr,
      'dataDir': dataDir,
      'logLevel': logLevel.rawValue,
      'isLogStandardOutput': isLogStandardOutput,
      'logFilePath': logFilePath,
    };
  }
}
