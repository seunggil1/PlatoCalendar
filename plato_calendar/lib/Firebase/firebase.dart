import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plato_calendar/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:plato_calendar/Data/database/backgroundDatabase.dart';
import 'package:plato_calendar/Data/database/database.dart';
import 'package:plato_calendar/Data/database/foregroundDatabase.dart';
import '../Data/userData.dart';
import 'package:plato_calendar/pnu/pnu.dart';

import '../notify.dart';

// 아래 페이지를 따라갈 것.
// https://firebase.flutter.dev/docs/overview

//FirebaseMessaging _message = FirebaseMessaging.instance;

/// 백그라운드에서 fcm 수신 준비
Future<bool> firebaseInit() async {
  try {
    // await FirebaseMessaging.instance.getToken();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    await FirebaseMessaging.instance.subscribeToTopic("all");
    //await FirebaseMessaging.instance.subscribeToTopic("debug");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    return true;
  } catch (e) {
    return false;
  }
}

/// Background Process에서만 사용
///
/// 초기화된 BackgroundDatabase가 존재할 경우 True.
bool _backgroundInit = false;

/// fcm callback 함수 동시에 실행 막기
bool _flag = false;

/// fcm 수신시 background 동기화 시작
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  await Notify.notificationInit();
  if (_flag) {
    Notify.notifyDebugInfo("firebaseMessagingBackgroundHandler is working.");
    return;
  } else
    _flag = true;
  try {
    if (!_backgroundInit) {
      _backgroundInit = true;
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await initializeDateFormatting('ko_KR', null);
      await Database.init();
    }
    UserData.writeDatabase = BackgroundDatabase();
    UserData.readDatabase = await Database.recentlyUsedDatabase();

    // 충돌 방지를 위해 5분안에 앱 사용한 적이 있을 경우 동기화x
    DateTime recentlyAccess = await UserData.readDatabase.getTime();
    await Notify.notifyDebugInfo(
        "recentlyAccess : ${recentlyAccess.toString()}");
    if (DateTime.now().difference(recentlyAccess).inMinutes <= 5)
      throw HiveError("Database is recently used");
    await Notify.notifyDebugInfo(
        "background Start : ${DateTime.now().toString()}");

    await UserData.writeDatabase.lock();

    await UserData.writeDatabase.loadDatabase();
    await UserData.readDatabase.loadDatabase();

    UserData.readDatabase.userDataLoad();
    UserData.readDatabase.calendarDataLoad();
    UserData.readDatabase.googleDataLoad();

    if (UserData.readDatabase is ForegroundDatabase)
      await UserData.readDatabase.closeDatabase();

    UserData.googleCalendar.openStream();

    // 자동으로 Save 안되는 부분은 수동으로 해주기.
    await Future.wait([
      UserData.writeDatabase.subjectCodeThisSemesterSave(),
      UserData.writeDatabase.defaultColorSave(),
      UserData.writeDatabase.uidSetSave(),
      UserData.writeDatabase.calendarDataFullSave(),
      UserData.writeDatabase.googleDataSave()
    ]);

    await UserData.writeDatabase.updateTime();
    if (!message.data.containsKey("func"))
      print("firebase Debug Success.");
    else if (message.data["func"] == "sync") {
      await update(background: true);
      await Notify.notifyTodaySchedule();
    } else if (message.data["func"] == "notifiy") {
    } else {
      print("firebase error.");
    }
    print("Handling a background message: ${message.messageId}");
    _flag = false;

    //await UserData.googleCalendar.closeStream();
    await Future.delayed(Duration(seconds: 1));
    await UserData.writeDatabase.release();
  } catch (e, trace) {
    if ((e.runtimeType == HiveError) &&
        e.toString().contains("Database is recently used"))
      await Notify.notifyDebugInfo(e.toString());
    else {
      //await UserData.googleCalendar.closeStream();
      await Notify.notifyDebugInfo(e.toString(), sendLog: true, trace: trace);
    }

    _flag = false;
    if (e.runtimeType != HiveError ||
        !(e.toString().contains("Database is locked") ||
            e.toString().contains("Database is recently used")))
      await UserData.writeDatabase.release();
  }
  await Notify.notifyDebugInfo("backgroundSync Finished");
  return;
}
