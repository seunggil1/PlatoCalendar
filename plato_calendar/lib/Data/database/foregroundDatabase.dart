import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'database.dart';
import '../../utility.dart';

final _syncTime = "foregroundTime";
final _lock = "notUse";
final _calendar = "foregroundCalendarBox";
final _userData = "foregroundUserDataBox";

class ForegroundDatabase extends Database{
  /// db 마지막 접근 시간 기록
  @override
  Future<void> updateTime() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.write(key: _syncTime, value: DateTime.now().toString());
  }

  @override
  Future<DateTime> getTime() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    return DateTime.parse(await secureStorage.read(key: _syncTime));
  }
  /// background와 동시 접근을 막기위한 mutex
  /// 
  /// background는 맨 처음 lock을 걸고 동기화가 마무리되면 release처리를 진행하고,
  /// 
  /// foreground의 경우 앱 처음 켤 때 lock걸고 바로 release처리함.
  @override
  Future<void> lock() async{
    print("this method is not used");
  }
  @override
  Future<void> release() async{
    print("this method is not used");
  }

  @override
  Future<void> loadDatabase() async {
    FlutterSecureStorage secureStorage;
    try{
      secureStorage = const FlutterSecureStorage();
      if (!(await secureStorage.containsKey(key: 'key'))) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(key: 'key', value: base64UrlEncode(key));
      }

      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));
      calendarBox = await Hive.openBox(_calendar, encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox(_userData, encryptionCipher: HiveAesCipher(encryptionKey));
    }
    catch(e){
      notifyDebugInfo(e.toString());
      await Database.deleteAll();
      await loadDatabase();
    }
  }

}