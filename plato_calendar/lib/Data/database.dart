import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './userData.dart';
import 'ics.dart';
import '../google/calendar.dart';
import '../utility.dart';

class Database{
  static Box calendarBox;
  static Box userDataBox;
  static Box debugLogBox;

  static Set<String> uidSet = {};

  static Future init([bool retry = false]) async {
    if(!retry){
      await Hive.initFlutter();
      Hive.registerAdapter(CalendarDataAdapter());
      Hive.registerAdapter(CalendarTypeAdapter());
      Hive.registerAdapter(GoogleCalendarTokenAdapter());
    }
    FlutterSecureStorage secureStorage;
    try{
      secureStorage = const FlutterSecureStorage();
      if (!(await secureStorage.containsKey(key: 'key'))) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(key: 'key', value: base64UrlEncode(key));
      }
      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));
      calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox('userDataBox', encryptionCipher: HiveAesCipher(encryptionKey));
      debugLogBox = await Hive.openBox('debugLogBox');
      UserData.syncLog = debugLogBox.get('syncLog') ?? [];
    }
    catch(e){
      await secureStorage.deleteAll();
      await Hive.deleteBoxFromDisk('calendarBox');
      await Hive.deleteBoxFromDisk('userDataBox');
      showToastMessageCenter("저장된 데이터 복원에 실패했습니다.");
      if(!retry)
        await init(true);
    }
  }

  static Future clear() async{
    await calendarBox.clear();
    await userDataBox.clear();
  }

  static void uidSetSave(){
    calendarBox.put('uidList', Database.uidSet.toList());
  }
  static void calendarDataSave(CalendarData data) async {
    calendarBox.put(data.uid,data);
    if(data.disable || data.finished) // (UserData.showFinished && data.finished)
      await UserData.googleCalendar.deleteCalendar(data.toEvent());
    else
      await UserData.googleCalendar.updateCalendar(data.toEvent());
  }
  static void calendarDataLoad(){
    uidSet = (calendarBox.get('uidList') ?? <String>[]).toSet();
    for(var iter in uidSet)
      UserData.data.add(calendarBox.get(iter));
  }

  static void subjectCodeThisSemesterSave(){
    userDataBox.put('subjectCodeThisSemester', UserData.subjectCodeThisSemester.toList());
  }

  static void defaultColorSave(){
    userDataBox.put('defaultColor', UserData.defaultColor);
  }

  static void userDataLoad(){
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
    UserData.oneStopLastSyncDay = userDataBox.get('oneStopLastSyncDay');
    UserData.semester = userDataBox.get('semester');
    
  }

  static Future<void> googleDataSave() async{
    await userDataBox.put('isSaveGoogleToken', UserData.isSaveGoogleToken);
    if(UserData.isSaveGoogleToken){
      await userDataBox.put('googleToken', UserData.googleCalendar);
    }
    else
      await userDataBox.delete('googleToken');
  }

  static void googleDataLoad(){
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

  /// 백그라운드에서만 호출함, 디버깅을 위한 동기화 시간 기록
  static Future<bool> saveSyncLog() async {
    try{
      await Hive.initFlutter();
      debugLogBox = await Hive.openBox('debugLogBox');
      UserData.syncLog = debugLogBox.get('syncLog') ?? [];
      UserData.syncLog.add(DateTime.now());
      await debugLogBox.put('syncLog', UserData.syncLog);

      return true;
    }catch(e){
      return false;
    }
  }
}