import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plato_calendar/Data/database/database.dart';

import '../notify.dart';

final options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

enum BuildType { debug, release }

class Appinfo {
  /// release, debug 여부 표시
  ///
  /// debug 모드일때 오류, 백그라운드 동기화를 상단 알림으로 표시함.
  static BuildType buildType = BuildType.release;

  /// App 버전
  static String appVersion = "3.4.1";

  /// App build 날짜
  static String buildversion = "202403210";

  /// Database 버전
  static String databaseVersion = "3.1";

  static Future<void> loadAppinfo() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    try {
      if (await secureStorage.containsKey(
          key: "databaseVersion", iOptions: options)) {
        final String nowDBVersion = await secureStorage.read(
                key: "databaseVersion", iOptions: options) ??
            "2.0";
        if (databaseVersion != nowDBVersion) {
          Notify.notifyDebugInfo(
              "DB version isn't same. $databaseVersion, $nowDBVersion");
          await Database.deleteAll();
          await secureStorage.write(
              key: "databaseVersion",
              value: databaseVersion,
              iOptions: options);
        }
      } else {
        Notify.notifyDebugInfo("databaseVersion is not Exist.");
        await Database.deleteAll();
        await secureStorage.write(
            key: "databaseVersion", value: databaseVersion, iOptions: options);
      }
    } catch (e, trace) {
      Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
      await Database.deleteAll();
      await secureStorage.write(
          key: "databaseVersion", value: databaseVersion, iOptions: options);
    }
  }
}
