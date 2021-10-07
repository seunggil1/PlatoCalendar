import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:plato_calendar/Data/database.dart';
import 'package:plato_calendar/pnu/pnu.dart';

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
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(_flag)
    return;
  else
    _flag = true;
  await Firebase.initializeApp();
  await Database.backGroundInit().then((bool result) async {
    Database.userDataLoad();
    Database.calendarDataLoad();
    Database.googleDataLoad();
    Database.debugInfo.add("background" + DateTime.now().toString());
    if(!message.data.containsKey("func"))
      print("firebase Debug Success.");
    else if(message.data["func"] == "sync"){
      await update(background: true);
    }else if(message.data["func"] == "notifiy"){

    }else{
      print("firebase error.");
    }
  });

  await Database.debug.put("debug", Database.debugInfo.toList());
  print("Handling a background message: ${message.messageId}");
  _flag = false;
  return;
}