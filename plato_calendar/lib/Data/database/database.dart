import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:plato_calendar/Data/database/backgroundDatabase.dart';
import 'package:plato_calendar/Data/database/foregroundDatabase.dart';

import '../userData.dart';
import '../ics.dart';
import '../../google/calendar.dart';
import '../../utility.dart';

abstract class Database{
  Box calendarBox;
  Box userDataBox;
  Set<String> uidSet = {};

  /// Database 사용전 한번 호출.
  static Future<void> init() async {
  try{
      await Hive.initFlutter();
      try{
        Hive.registerAdapter(CalendarDataAdapter());
        Hive.registerAdapter(CalendarTypeAdapter());
        Hive.registerAdapter(ThemeModeAdapter());
        Hive.registerAdapter(GoogleCalendarTokenAdapter());
      }catch(e){
        if(!e.message.toString().contains("There is already a TypeAdapter"))
          throw HiveError("register Adapter failed : "+ e.message.toString());
      }
    }catch(e){
      if(e.runtimeType != HiveError){
        notifyDebugInfo(e.toString());
        throw Exception(e.toString());
      }
      if(!(e.message.contains("There is already a TypeAdapter") && e.message != "Instance has already been initialized.")){
            notifyDebugInfo(e.toString());
            throw HiveError(e.toString());
      }
    }
  }

  /// foreground, background중 최근에 사용한 DB를 반환
  static Future<Database> recentlyUsedDatabase() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    DateTime foregroundTime;
    DateTime backgroundTime;

    if (await secureStorage.containsKey(key: "foregroundTime"))
      foregroundTime = DateTime.parse(await (secureStorage.read(key: "foregroundTime")));
    else
      foregroundTime = DateTime(1990);

    if (await secureStorage.containsKey(key: "backgroundTime"))
      backgroundTime = DateTime.parse(await (secureStorage.read(key: "backgroundTime")));
    else
      backgroundTime = DateTime(1990);

    if(foregroundTime.difference(backgroundTime).inSeconds >= 0)
      return ForegroundDatabase();
    else
      return BackgroundDatabase();
  }

  /// db 마지막 접근 시간 기록
  Future<void> updateTime();
  Future<DateTime> getTime();
  Future<void> lock();
  Future<void> release();

  Future<void> loadDatabase();

  Future<void> closeDatabase() async{
    await calendarBox.close();
    await userDataBox.close();
  }
  Future<void> deleteAll() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.deleteAll();
    await Hive.deleteBoxFromDisk('backgroundCalendarBox');
    await Hive.deleteBoxFromDisk('backgroundUserDataBox');
    await Hive.deleteBoxFromDisk('foregroundCalendarBox');
    await Hive.deleteBoxFromDisk('foregroundUserDataBox');
    showToastMessageCenter("저장된 데이터 복원에 실패했습니다.");
  }


  Future<void> uidSetSave() async {
    await calendarBox.put('uidList', uidSet.toList());
  }
  Future<void> calendarDataSave(CalendarData data) async {
    await calendarBox.put(data.uid,data);
    if(data.disable || data.finished) // (UserData.showFinished && data.finished)
      await UserData.googleCalendar.deleteCalendar(data.toEvent());
    else
      await UserData.googleCalendar.updateCalendar(data.toEvent());
  }
  void calendarDataLoad() {
    uidSet = (calendarBox.get('uidList') ?? <String>[]).toSet();
    for(var iter in uidSet)
      UserData.data.add(calendarBox.get(iter));
  }

  Future<void> subjectCodeThisSemesterSave() async {
    await userDataBox.put('subjectCodeThisSemester', UserData.subjectCodeThisSemester.toList());
  }

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
    UserData.subjectCodeThisSemester = (userDataBox.get('subjectCodeThisSemester') ?? ["전체"]).toSet();
    UserData.defaultColor = userDataBox.get('defaultColor') ?? {};
    UserData.showToDoList = userDataBox.get('showToDoList');
    UserData.notificationDay = userDataBox.get('notificationDay');
    UserData.oneStopLastSyncDay = userDataBox.get('oneStopLastSyncDay');
    UserData.semester = userDataBox.get('semester');
    UserData.themeMode = userDataBox.get('themeMode');
    
  }

  Future<void> googleDataSave() async{
    await userDataBox.put('isSaveGoogleToken', UserData.isSaveGoogleToken);
    if(UserData.isSaveGoogleToken){
      await userDataBox.put('googleToken', UserData.googleCalendar);
    }
    else
      await userDataBox.delete('googleToken');
  }

  void googleDataLoad() {
    UserData.isSaveGoogleToken = userDataBox.get('isSaveGoogleToken') ?? false;
    UserData.googleFirstLogin = userDataBox.get('googleFirstLogin');
    if(UserData.isSaveGoogleToken){
      UserData.googleCalendar = userDataBox.get('googleToken');
      UserData.isSaveGoogleToken = UserData.googleCalendar.restoreAutoRefreshingAuthClient();
      if(UserData.isSaveGoogleToken && UserData.googleFirstLogin)
        UserData.googleCalendar.updateCalendarFull();
    }else
      UserData.googleCalendar = GoogleCalendarToken("","",DateTime(1990),"",[]);
  }
}