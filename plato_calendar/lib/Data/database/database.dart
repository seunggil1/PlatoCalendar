import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:plato_calendar/Data/database/backgroundDatabase.dart';
import 'package:plato_calendar/Data/database/foregroundDatabase.dart';

import '../../notify.dart';
import '../userData.dart';
import '../ics.dart';
import '../../google/calendar.dart';
import '../../utility.dart';

final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);

abstract class Database {
  Box calendarBox;
  Box userDataBox;

  /// Database 사용전 한번 호출.
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      try {
        Hive.registerAdapter(CalendarDataAdapter());
        Hive.registerAdapter(CalendarTypeAdapter());
        Hive.registerAdapter(ThemeModeAdapter());
        Hive.registerAdapter(GoogleCalendarTokenAdapter());
      } catch (e) {
        if (!e.message.toString().contains("There is already a TypeAdapter"))
          throw HiveError("register Adapter failed : " + e.message.toString());
      }
    } catch (e, trace) {
      if (e.runtimeType != HiveError) {
        Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
        throw Exception(e.toString());
      }
      if (!(e.message.contains("There is already a TypeAdapter") &&
          e.message != "Instance has already been initialized.")) {
        Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
        throw HiveError(e.toString());
      }
    }
  }

  /// foreground, background중 최근에 사용한 DB를 반환
  static Future<Database> recentlyUsedDatabase() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    DateTime foregroundTime;
    DateTime backgroundTime;

    if ((!await secureStorage.containsKey(
            key: "foregroundTime", iOptions: options)) ||
        (await secureStorage.read(key: "foregroundTime", iOptions: options) ==
            null)) {
      foregroundTime = DateTime(1990);
      await (secureStorage.write(
          key: "foregroundTime", value: "1990-01-01", iOptions: options));
    } else {
      foregroundTime = DateTime.parse(
          await secureStorage.read(key: "foregroundTime", iOptions: options));
    }

    if ((!await secureStorage.containsKey(
            key: "backgroundTime", iOptions: options)) ||
        (await secureStorage.read(key: "backgroundTime", iOptions: options) ==
            null)) {
      backgroundTime = DateTime(1990);
      await (secureStorage.write(
          key: "backgroundTime", value: "1990-01-01", iOptions: options));
    } else {
      backgroundTime = DateTime.parse(
          await secureStorage.read(key: "backgroundTime", iOptions: options));
    }

    if (foregroundTime.difference(backgroundTime).inSeconds >= 0) {
      Notify.notifyDebugInfo("Loading foregroundDB..");
      return ForegroundDatabase();
    } else {
      Notify.notifyDebugInfo("Loading backgroundDB..");
      return BackgroundDatabase();
    }
  }

  static Future<void> deleteAll() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.deleteAll();
    try {
      await Hive.deleteBoxFromDisk('foregroundCalendarBox');
      await Hive.deleteBoxFromDisk('foregroundUserDataBox');
    } catch (e, trace) {
      Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
      if (!(e is ArgumentError)) throw e;
    }
    try {
      await Hive.deleteBoxFromDisk('backgroundCalendarBox');
      await Hive.deleteBoxFromDisk('backgroundUserDataBox');
    } catch (e, trace) {
      Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
      if (!(e is ArgumentError)) throw e;
    }
    showToastMessageCenter("저장된 데이터 복원에 실패했습니다.");
  }

  /// db 마지막 접근 시간 기록
  Future<void> updateTime();
  Future<DateTime> getTime();
  Future<void> lock();
  Future<void> release();

  Future<void> loadDatabase();

  Future<void> closeDatabase() async {
    await calendarBox.close();
    await userDataBox.close();
  }

  Future<void> uidSetSave() async {
    await calendarBox.put('uidList', UserData.uidSet.toList());
  }

  /// 모든 일정 DB에 저장
  ///
  /// google calendar와 동기화를 하지 않음.
  ///
  /// 데이터베이스 동기화를 위해 사용
  Future<void> calendarDataFullSave() async {
    for (CalendarData data in UserData.data)
      await calendarBox.put(data.uid, data);
  }

  /// 해당 일정을 DB에 저장.
  ///
  /// google calendar에도 해당 내용 update
  ///
  /// (google calendar 연동이 되어 있을때)
  Future<void> calendarDataSave(CalendarData data) async {
    await calendarBox.put(data.uid, data);
    UserData.googleCalendar.googleAsyncQueue.add(data);
    UserData.googleCalendar.asyncQueueSize++;
  }

  /// 데이터베이스에서 모든 일정 불러옴.
  void calendarDataLoad() {
    UserData.uidSet = (calendarBox.get('uidList') ?? <String>[]).toSet();
    for (var iter in UserData.uidSet) UserData.data.add(calendarBox.get(iter));
  }

  /// 과목 목록 DB에 저장.
  ///
  /// 해당 Data는 변경사항 있을때마다 DB에 수동으로 저장해야 됨.
  ///
  /// DB에서 Load할때는 Database.userDataLoad()에서 일괄적으로 불러옴.
  Future<void> subjectCodeThisSemesterSave() async {
    await userDataBox.put(
        'subjectCodeThisSemester', UserData.subjectCodeThisSemester.toList());
  }

  /// 과목 별 기본 색상 지정
  ///
  /// 해당 Data는 변경사항 있을때마다 DB에 수동으로 저장해야 됨.
  ///
  /// DB에서 Load할때는 Database.userDataLoad()에서 일괄적으로 불러옴.
  Future<void> defaultColorSave() async {
    await userDataBox.put('defaultColor', UserData.defaultColor);
  }

  void userDataLoad() {
    UserData.tapIndex = userDataBox.get('tapIndex');
    UserData.firstDayOfWeek = userDataBox.get('firstDayOfWeek');
    UserData.calendarType = userDataBox.get('calendarType');
    UserData.showFinished = userDataBox.get('showFinished');
    UserData.id = userDataBox.get('id');
    UserData.pw = userDataBox.get('pw');
    UserData.lastSyncTime = userDataBox.get('lastSyncTime');
    UserData.lastSyncInfo = userDataBox.get('lastSyncInfo');
    UserData.subjectCodeThisSemester =
        (userDataBox.get('subjectCodeThisSemester') ?? ["전체"]).toSet();
    UserData.defaultColor = userDataBox.get('defaultColor') ?? {};
    UserData.showToDoList = userDataBox.get('showToDoList');
    UserData.notificationDay = userDataBox.get('notificationDay');
    UserData.oneStopLastSyncDay = userDataBox.get('oneStopLastSyncDay');
    UserData.semester = userDataBox.get('semester');
    UserData.themeMode = userDataBox.get('themeMode');
  }

  /// Google 정보를 DB에 저장.
  ///
  /// 해당 Data는 변경사항 있을때마다 DB에 수동으로 저장해야 됨.
  Future<void> googleDataSave() async {
    await userDataBox.put('isSaveGoogleToken', UserData.isSaveGoogleToken);
    if (UserData.isSaveGoogleToken) {
      await userDataBox.put('googleToken', UserData.googleCalendar);
    } else {
      await userDataBox.delete('googleToken');
    }
  }

  void googleDataLoad() {
    UserData.isSaveGoogleToken = userDataBox.get('isSaveGoogleToken') ?? false;
    UserData.googleFirstLogin = userDataBox.get('googleFirstLogin');
    if (UserData.isSaveGoogleToken) {
      UserData.googleCalendar = userDataBox.get('googleToken');
      UserData.isSaveGoogleToken =
          UserData.googleCalendar.restoreAutoRefreshingAuthClient();
    } else
      UserData.googleCalendar =
          GoogleCalendarToken("", "", DateTime(1990), "", []);
  }
}
