import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'database.dart';
import '../../notify.dart';
import '../../utility.dart';

final _syncTime = "backgroundTime";
final _lock = "backgroundLock";
final _calendar = "backgroundCalendarBox";
final _userData = "backgroundUserDataBox";
class BackgroundDatabase extends Database{
  /// 마지막 DB 접근 시간 기록.
  @override
  Future<void> updateTime() async {
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      await secureStorage.write(key: _syncTime, value: DateTime.now().toString());
    }catch(e){
      Notify.notifyDebugInfo("updateTime Error\n ${e.toString()}");
    }
  }

  @override
  Future<DateTime> getTime() async{
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      return DateTime.parse(await secureStorage.read(key: _syncTime));
    }catch(e){
      Notify.notifyDebugInfo("getTime Error\n ${e.toString()}");
      return DateTime(1990);
    }
  }

  /// backgroundDB 동시 접근을 막기위한 mutex
  /// 
  /// backgroundDB 읽거나 쓸 때, 우선 lock을 걸고  마무리되면 release처리를 진행하고,
  Future<void> lock() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (!(await secureStorage.containsKey(key: _lock)))
      await secureStorage.write(key: _lock, value: 'false');

    int retry = 1;
    while((await secureStorage.read(key: _lock)) == "true"){
      if(retry <= 8){
        showToastMessageCenter("데이터 동기화중입니다....(${retry++}/10)");
        await Future.delayed(const Duration(seconds: 2));
      }else if(retry <= 10){
        Notify.notifyDebugInfo("Force release.");
        await release();
      }else{
        Notify.notifyDebugInfo("Fail to lock Background Database.\n All Database is deleted.");
        await Database.deleteAll();      
      }
    }
    await secureStorage.write(key: _lock, value: 'true');

  }
  Future<void> release() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if((await secureStorage.read(key: _lock)) == "true"){
      await secureStorage.write(key: _lock, value: 'false');
    }else{
      showToastMessageCenter("Database isn't locked.\nPlease report issue.");
      throw HiveError("Database isn't locked");
    }
  }
  
  @override
  Future<void> loadDatabase() async {
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      if (!(await secureStorage.containsKey(key: 'key'))) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(key: 'key', value: base64UrlEncode(key));
      }

      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));
      calendarBox = await Hive.openBox(_calendar, encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox(_userData, encryptionCipher: HiveAesCipher(encryptionKey));

    }catch(e){
      Notify.notifyDebugInfo(e.toString());
      await Database.deleteAll();
      await loadDatabase();
      return;
    }
  }

}