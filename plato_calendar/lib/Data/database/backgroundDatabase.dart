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

final options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

class BackgroundDatabase extends Database {
  /// 마지막 DB 접근 시간 기록.
  @override
  Future<void> updateTime() async {
    try {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      await secureStorage.write(
          key: _syncTime, value: DateTime.now().toString(), iOptions: options);
    } catch (e, trace) {
      Notify.notifyDebugInfo("updateTime Error\n ${e.toString()}",
          sendLog: true, trace: trace);
    }
  }

  @override
  Future<DateTime> getTime() async {
    try {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      return DateTime.parse(
          await secureStorage.read(key: _syncTime, iOptions: options) ??
              "1990-01-01");
    } catch (e, trace) {
      Notify.notifyDebugInfo("getTime Error\n ${e.toString()}",
          sendLog: true, trace: trace);
      return DateTime(1990);
    }
  }

  /// backgroundDB 동시 접근을 막기위한 mutex
  ///
  /// backgroundDB 읽거나 쓸 때, 우선 lock을 걸고  마무리되면 release처리를 진행하고,
  Future<void> lock() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (!(await secureStorage.containsKey(key: _lock, iOptions: options)) ||
        (await secureStorage.read(key: _lock, iOptions: options)) == null) {
      await secureStorage.write(key: _lock, value: 'false', iOptions: options);
    }
    int retry = 1;
    while (
        (await secureStorage.read(key: _lock, iOptions: options)) == "true") {
      if (retry <= 8) {
        showToastMessageCenter("데이터 동기화중입니다....(${retry++}/10)");
        await Future.delayed(const Duration(seconds: 2));
      } else if (retry <= 10) {
        Notify.notifyDebugInfo("Force release.");
        await release();
      } else {
        Notify.notifyDebugInfo(
            "Fail to lock Background Database.\n All Database is deleted.",
            sendLog: true);
        await Database.deleteAll();
      }
    }
    await secureStorage.write(key: _lock, value: 'true', iOptions: options);
  }

  Future<void> release() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if ((await secureStorage.read(key: _lock, iOptions: options)) == "true") {
      await secureStorage.write(key: _lock, value: 'false', iOptions: options);
    } else {
      showToastMessageCenter("Database isn't locked.\nPlease report issue.");
      throw HiveError("Database isn't locked");
    }
  }

  @override
  Future<void> loadDatabase() async {
    try {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      if (!(await secureStorage.containsKey(key: 'key', iOptions: options)) ||
          (await secureStorage.read(key: 'key', iOptions: options) == null)) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(
            key: 'key', value: base64UrlEncode(key), iOptions: options);
      }

      var encryptionKey = base64Url
          .decode(await secureStorage.read(key: 'key', iOptions: options));
      calendarBox = await Hive.openBox(_calendar,
          encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox(_userData,
          encryptionCipher: HiveAesCipher(encryptionKey));
    } catch (e, trace) {
      Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
      await Database.deleteAll();
      await loadDatabase();
      return;
    }
  }
}
