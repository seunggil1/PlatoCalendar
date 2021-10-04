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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await Database.backGroundInit().then((bool result) {
    Database.userDataLoad();
    Database.calendarDataLoad();
    Database.googleDataLoad();
  });

  if(message.data["func"] == "sync"){
    Random random = new Random();
    await Future.delayed(Duration(seconds: random.nextInt(60))); // from 0 upto 60 사이의 랜덤 숫자 생성
    await update(force: true);
  }else if(message.data["func"] == "notifiy"){

  }else{
    print("firebase Debug Success.");
  }
  
  print("Handling a background message: ${message.messageId}");
}