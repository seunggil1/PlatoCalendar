import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plato_calendar/Data/database/database.dart';

import 'package:plato_calendar/utility.dart';

enum BuildType {debug, release}

class Appinfo{
  /// release, debug 여부 표시
  /// debug 모드일때 오류, 백그라운드 동기화를 상단 알림으로 표시함.
  static BuildType buildType = BuildType.debug;

  /// App 버전
  static String appVersion = "3.0.0";

  /// App build 날짜
  static String buildversion = "202201023";

  /// Database 버전
  static String databaseVersion = "3.0";
  
  
  static Future<void> loadAppinfo() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    try{
      if(await secureStorage.containsKey(key: "databaseVersion")){
        final String nowDBVersion = await secureStorage.read(key: "databaseVersion") ?? 2.0;
        if(databaseVersion != nowDBVersion){
          notifyDebugInfo("DB version isn't same. $databaseVersion, $nowDBVersion");
          await Database.deleteAll();
          await secureStorage.write(key: "databaseVersion", value: databaseVersion);
        }
      }else{
        notifyDebugInfo("databaseVersion is not Exist.");
        await Database.deleteAll();
        await secureStorage.write(key: "databaseVersion", value: databaseVersion);
      }
    }catch(e){
      notifyDebugInfo(e);
      await Database.deleteAll();
      await secureStorage.write(key: "databaseVersion", value: databaseVersion);
    }

  }
}