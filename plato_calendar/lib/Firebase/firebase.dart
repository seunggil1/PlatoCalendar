import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:plato_calendar/Data/database.dart';
import 'package:plato_calendar/pnu/pnu.dart';

import '../utility.dart';

// 아래 페이지를 따라갈 것.
// https://firebase.flutter.dev/docs/overview

//FirebaseMessaging _message = FirebaseMessaging.instance;

/// 백그라운드에서 fcm 수신 준비
Future<bool> firebaseInit() async{
  try{
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic("all");
    //await FirebaseMessaging.instance.subscribeToTopic("debug");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    return true;
  }
  catch(e){
    return false;
  }
}

bool _flag = false;
/// fcm 수신시 background 동기화 시작
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(_flag)
    return;
  else
    _flag = true;
  try{
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    DateTime recentlyAccess = DateTime.parse(await secureStorage.read(key: 'time'));
    await notificationInit();
    if(DateTime.now().difference(recentlyAccess).inMinutes <= 3)
      throw Exception("Database is recently used");
    await Database.lock();
    await Firebase.initializeApp();
    await Database.backGroundInit().then((bool result) async {
      if(!result){
        _flag = false;
        return;
      }
      Database.setLoadMode();
      await Database.userDataLoad();
      await Database.calendarDataLoad();
      await Database.googleDataLoad();
      Database.setUpdateMode();
      if(!message.data.containsKey("func"))
        print("firebase Debug Success.");
      else if(message.data["func"] == "sync"){
        await update(background: true);
        await notifyTodaySchedule();
      }else if(message.data["func"] == "notifiy"){

      }else{
        print("firebase error.");
      }
      print("Handling a background message: ${message.messageId}");
      _flag = false;
    });
    await Future.delayed(Duration(seconds: 1));
    await Database.release();
  }
  catch(e){
    _flag = false;
    if(!(e.runtimeType == HiveError && e.toString().contains("Database is locked")))
      await Database.release();
  }
  return;
}