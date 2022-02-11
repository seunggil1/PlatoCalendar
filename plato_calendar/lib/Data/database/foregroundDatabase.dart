import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../notify.dart';
import 'database.dart';

final _syncTime = "foregroundTime";
final _lock = "notUse";
final _calendar = "foregroundCalendarBox";
final _userData = "foregroundUserDataBox";

final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);

class ForegroundDatabase extends Database{
  /// db 마지막 접근 시간 기록
  @override
  Future<void> updateTime() async{
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      await secureStorage.write(key: _syncTime, value: DateTime.now().toString(), iOptions: options);
    }catch(e, trace){
      Notify.notifyDebugInfo("updateTime Error\n ${e.toString()}", sendLog: true, trace : trace);
    }
  }

  @override
  Future<DateTime> getTime() async{
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      return DateTime.parse(await secureStorage.read(key: _syncTime, iOptions: options));
    }catch(e, trace){
      Notify.notifyDebugInfo("getTime Error\n ${e.toString()}", sendLog: true, trace : trace);
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
      if (!(await secureStorage.containsKey(key: 'key', iOptions: options))) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(key: 'key', value: base64UrlEncode(key), iOptions: options);
      }

      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key', iOptions: options));
      calendarBox = await Hive.openBox(_calendar, encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox(_userData, encryptionCipher: HiveAesCipher(encryptionKey));
    }
    catch(e,trace){
      Notify.notifyDebugInfo(e.toString(), sendLog: true, trace : trace);
      await Database.deleteAll();
      await loadDatabase();
    }
  }

}