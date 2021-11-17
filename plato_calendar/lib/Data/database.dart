import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import './userData.dart';
import 'ics.dart';
import '../google/calendar.dart';
import '../utility.dart';

class Database{
  static Box calendarBox;
  static Box userDataBox;
  static Set<String> uidSet = {};

  /// db 마지막 접근 시간 기록
  static Future<void> updateTime() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.write(key: 'time', value: DateTime.now().toString());
  }
  /// background와 동시 접근을 막기위한 mutex
  /// 
  /// background는 맨 처음 lock을 걸고 동기화가 마무리되면 release처리를 진행하고,
  /// 
  /// foreground의 경우 앱 처음 켤 때 lock걸고 바로 release처리함.
  static Future<void> lock([int retry = 1]) async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (!(await secureStorage.containsKey(key: 'lock')))
      await secureStorage.write(key: 'lock', value: 'false');

    if((await secureStorage.read(key: 'lock')) == "true"){
      throw HiveError("Database is locked"); 
    }else
      await secureStorage.write(key: 'lock', value: 'true');

  }
  static Future<void> release() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if((await secureStorage.read(key: 'lock')) == "true"){
      await secureStorage.write(key: 'lock', value: 'false');
    }else{
      showToastMessageCenter("Database isn't locked.\nPlease report issue.");
      throw HiveError("Database isn't locked");
    }
  }
  static Future init([int retry = 1]) async {
    try{
      // background와 동시 접근을 막기위한 mutex
      // 앱의 경우 언제 종료되는지 알 수 없으므로 lock으로 권한 획득만 진행하고 즉시 release처리한다.
      await lock();
      await release();
    }catch(e){
      if(retry <= 8){
        showToastMessageCenter("${e.toString()}\nTrying again..($retry/10)");
        await Future.delayed(const Duration(seconds: 2));
      }else if(retry <= 10)
        await release();
      else
        await deleteAll();
      await init(retry+1);
    }
    try{
      await Hive.initFlutter();
      Hive.registerAdapter(CalendarDataAdapter());
      Hive.registerAdapter(CalendarTypeAdapter());
      Hive.registerAdapter(ThemeModeAdapter());
      Hive.registerAdapter(GoogleCalendarTokenAdapter());
    }catch(e){
      if(!e.message.toString().contains("There is already a TypeAdapter"))
        throw HiveError("register Adapter failed : "+ e.message.toString());
    }
  }
  static Future<void> loadDatabase([int retry = 1]) async {
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
    }
    catch(e){
      if(retry <= 3){
        showToastMessageCenter("${e.toString()}\nTrying again..($retry/3)");
        await Future.delayed(const Duration(seconds: 2));
      }else
        await deleteAll();
      await init(retry+1);
    }
  }
  /// Background Process에서만 사용
  /// 
  /// backGroundInit()을 이미 호출했을 경우 True.
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
        throw Exception("No encryptionKey");
      }
      var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));
      calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(encryptionKey));
      userDataBox = await Hive.openBox('userDataBox', encryptionCipher: HiveAesCipher(encryptionKey));
    }catch(e){
      return false;
    }
    return true;
  }

  static Future<void> deleteAll() async{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.deleteAll();
    await Hive.deleteBoxFromDisk('calendarBox');
    await Hive.deleteBoxFromDisk('userDataBox');
    showToastMessageCenter("저장된 데이터 복원에 실패했습니다.");
  }

  static Future<void> uidSetSave() async {
    await calendarBox.put('uidList', Database.uidSet.toList());
  }
  static Future<void> calendarDataSave(CalendarData data) async {
    await calendarBox.put(data.uid,data);
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

  static Future<void> subjectCodeThisSemesterSave() async {
    await userDataBox.put('subjectCodeThisSemester', UserData.subjectCodeThisSemester.toList());
  }

  static Future<void> defaultColorSave() async {
    await userDataBox.put('defaultColor', UserData.defaultColor);
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
    UserData.themeMode = userDataBox.get('themeMode');
    
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