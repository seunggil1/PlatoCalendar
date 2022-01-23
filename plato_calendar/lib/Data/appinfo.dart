import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plato_calendar/Data/database/database.dart';

import '../notify.dart';

enum BuildType {debug, release}

class Appinfo{
  /// release, debug 여부 표시
  /// 
  /// debug 모드일때 오류, 백그라운드 동기화를 상단 알림으로 표시함.
  static BuildType buildType = BuildType.release;

  /// App 버전
  static String appVersion = "3.0.1";

  /// App build 날짜
  static String buildversion = "202201220";

  /// Database 버전
  static String databaseVersion = "3.1";
  
  static Future<void> loadAppinfo() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    try{
      if(await secureStorage.containsKey(key: "databaseVersion")){
        final String nowDBVersion = await secureStorage.read(key: "databaseVersion") ?? 2.0;
        if(databaseVersion != nowDBVersion){
          Notify.notifyDebugInfo("DB version isn't same. $databaseVersion, $nowDBVersion");
          await Database.deleteAll();
          await secureStorage.write(key: "databaseVersion", value: databaseVersion);
        }
      }else{
        Notify.notifyDebugInfo("databaseVersion is not Exist.");
        await Database.deleteAll();
        await secureStorage.write(key: "databaseVersion", value: databaseVersion);
      }
    }catch(e, trace){
      Notify.notifyDebugInfo(e,sendLog : true, trace : trace);
      await Database.deleteAll();
      await secureStorage.write(key: "databaseVersion", value: databaseVersion);
    }
  }
}