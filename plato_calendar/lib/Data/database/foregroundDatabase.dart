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
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      await secureStorage.write(key: _syncTime, value: DateTime.now().toString());
    }catch(e){
      notifyDebugInfo("updateTime Error\n ${e.toString()}",1);
    }
  }

  @override
  Future<DateTime> getTime() async{
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      return DateTime.parse(await secureStorage.read(key: _syncTime));
    }catch(e){
      notifyDebugInfo("getTime Error\n ${e.toString()}",2);
      return DateTime(1990);
    }
  }
  /// backgroundDB 동시 접근을 막기 위한 lock release.
  /// 
  /// foregroundDB에서는 사용하지 않음.
  @override
  Future<void> lock() async{
    print("this method is not used");
  }

  /// backgroundDB 동시 접근을 막기 위한 lock release.
  /// 
  /// foregroundDB에서는 사용하지 않음.
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