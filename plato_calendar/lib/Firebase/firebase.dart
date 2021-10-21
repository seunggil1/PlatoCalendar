import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:plato_calendar/Data/database.dart';
import 'package:plato_calendar/pnu/pnu.dart';

import '../utility.dart';

// 아래 페이지를 따라갈 것.
// https://firebase.flutter.dev/docs/overview

//FirebaseMessaging _message = FirebaseMessaging.instance;

Future<bool> firebaseInit() async{
  try{
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic("all");
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
    if(!await Database.lock())
      return;

    await Firebase.initializeApp();
    await Database.backGroundInit().then((bool result) async {
      if(!result){
        _flag = false;
        return;
      }

      Database.userDataLoad();
      Database.calendarDataLoad();
      Database.googleDataLoad();
      Database.debugInfo.add("background Start : " + DateTime.now().toString());
      if(!message.data.containsKey("func"))
        print("firebase Debug Success.");
      else if(message.data["func"] == "sync"){
        await update(background: true);
        await notifyTodaySchedule();
      }else if(message.data["func"] == "notifiy"){

      }else{
        print("firebase error.");
      }
      Database.debugInfo.add("background End : " + DateTime.now().toString());
      await Database.debug.put("debug", Database.debugInfo.toList());
      print("Handling a background message: ${message.messageId}");
      _flag = false;
    });

  }
  catch(e){
    await notifyDebugInfo(e.toString());
    _flag = false;
  }
  await Database.release();

  return;
}