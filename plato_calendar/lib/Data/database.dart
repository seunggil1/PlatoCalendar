import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './userData.dart';
import 'ics.dart';
import '../google/calendar.dart';
import '../utility.dart';

class Database{
  static Box calendarBox;
  static Box userDataBox;
  static Set<String> uidSet = {};

  static Future<bool> lock() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (!(await secureStorage.containsKey(key: 'lock')))
      await secureStorage.write(key: 'lock', value: 'false');

    if((await secureStorage.read(key: 'lock')) == "true"){
      return false;
    }
    await secureStorage.write(key: 'lock', value: 'true');
    return true;
  }
  static Future<bool> release() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (!(await secureStorage.containsKey(key: 'lock')))
      await secureStorage.write(key: 'lock', value: 'false');
    if((await secureStorage.read(key: 'lock')) == "true"){
      await secureStorage.write(key: 'lock', value: 'false');
      return false;
    }
    return true;

  }
  static Future init([int retry = 1]) async {
    await Hive.initFlutter();
    try{
      Hive.registerAdapter(CalendarDataAdapter());
      Hive.registerAdapter(CalendarTypeAdapter());
      Hive.registerAdapter(GoogleCalendarTokenAdapter());
    }catch(e){
      if(!e.message.toString().contains("There is already a TypeAdapter"))
        throw HiveError("register Adapter failed : "+ e.message.toString());
    }
    FlutterSecureStorage secureStorage;
    try{
      secureStorage = const FlutterSecureStorage();
      if(!(await lock()))
        throw HiveError("database lock"); 
      await release();
      
      if (!(await secureStorage.containsKey(key: 'key'))) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(key: 'key', value: base64UrlEncode(key));
      }

      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));
      calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(encryptionKey));
      calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox('userDataBox', encryptionCipher: HiveAesCipher(encryptionKey));
    }
    catch(e){
      if(retry < 10){
        showToastMessageCenter("데이터를 불러오고 있습니다..($retry/10)");
        await Future.delayed(const Duration(seconds: 2));
      }else{
        await secureStorage.deleteAll();
        await Hive.deleteBoxFromDisk('calendarBox');
        await Hive.deleteBoxFromDisk('userDataBox');
        showToastMessageCenter("저장된 데이터 복원에 실패했습니다.");
      }
      await init(retry+1);
    }
  }

  /// Background Process에서 Database 준비가 되었으면 True.
  static bool _backgroundInit = false;
  /// 백그라운드에서 init함수 대신 사용
  /// 
  /// 이전에 호출했던 쓰레드가 살아있으면
  /// 
  /// initFlutter, registerAdapter 중복호출로 에러가 발생하여 예외 처리 추가,
  /// 
  /// 디버깅을 위한 동기화 시간 기록이 추가.
  static Future<bool> backGroundInit() async {
    try{
      if(!_backgroundInit){
        _backgroundInit = true;
        WidgetsFlutterBinding.ensureInitialized();
        await initializeDateFormatting('ko_KR', null);
        await notificationInit();
        await Hive.initFlutter();
        try{
          Hive.registerAdapter(CalendarDataAdapter());
          Hive.registerAdapter(CalendarTypeAdapter());
          Hive.registerAdapter(GoogleCalendarTokenAdapter());
        }catch(e){
          if(!e.message.toString().contains("There is already a TypeAdapter"))
            throw HiveError("register Adapter failed : "+ e.message.toString());
        }
      }
    }catch(e){
      if(e.runtimeType != HiveError){
        return false;
      }
      if(!(e.message.contains("There is already a TypeAdapter") 
          && e.message != "Instance has already been initialized."))
        return false;
    }
    try{
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      if (!(await secureStorage.containsKey(key: 'key'))) {
        throw Exception();
      }
      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));
      calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox('userDataBox', encryptionCipher: HiveAesCipher(encryptionKey));
    }catch(e){
      return false;
    }
    return true;
  }

  static Future clear() async{
    await calendarBox.clear();
    await userDataBox.clear();
  }

  static void uidSetSave(){
    calendarBox.put('uidList', Database.uidSet.toList());
  }
  static Future<void> calendarDataSave(CalendarData data) async {
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
    UserData.notificationDay = userDataBox.get('notificationDay');
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
}