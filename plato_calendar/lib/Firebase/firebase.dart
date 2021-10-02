import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:plato_calendar/Data/database.dart';

// 아래 페이지를 따라갈 것.
// https://firebase.flutter.dev/docs/overview

FirebaseMessaging _message = FirebaseMessaging.instance;

Future<bool> firebaseInit() async{
  try{
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic("all");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    var test = _message.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${msg.data}');
      
      if (msg.notification != null) {
        print('Message also contained a notification: ${msg.notification}');
      }
    });
    return true;
  }
  catch(e){
    return false;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  await Database.saveSyncLog();
  print("Handling a background message: ${message.messageId}");
}