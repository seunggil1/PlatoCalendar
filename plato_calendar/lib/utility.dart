import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Data/else.dart';
import 'Data/userData.dart';

// #1 하단에 잠시 텍스트 뜨게 하는 코드
void showMessage(BuildContext context, String msg) {
    final snackbar = SnackBar(content: Text(msg));

    ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
}

// #2 원하는 위치에 toast 메세지
void showToastMessageCenter(String message){
  Fluttertoast.cancel().then((value) => {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG)
  });
}

void showToastMessageTop(String message){
  Fluttertoast.cancel().then((value) => {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_LONG)
  });
}

// #3 push message
Future<void> notificationInit() async{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initSettingsAndroid = AndroidInitializationSettings('@mipmap/calender_icon');
  final initSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  final initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );

}

Future<void> notifyTodaySchedule() async{
  if(UserData.notificationDay == DateTime.now().day)
    return;
  
  String body = "";
  int today = DateTime.now().day;
  int count = 1;
  UserData.data.forEach((element){
    //if(!element.disable && !element.finished && element.end.day == today){
      String className = element.className != "" ? element.className : element.classCode;
      String contents = element.summary;

      if(contents.length >= 25){
        contents = contents.substring(0, 24);
        contents += "..";
      }

      if(element.start == element.end || element.start.day != element.end.day){
        body += "\n$count. $className (~ ${getTimeLocaleKR(element.end)})";
        body += "\n   -  $contents";
      }else{
        body += "\n$count. $className (${getTimeLocaleKR(element.start)} ~ ${getTimeLocaleKR(element.end)})";
        body += "\n   -  $contents";
      }
    //}
    count++;
  });
  body = body.trim();

  if(body.length != 0){
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('0', '오늘의 일정',
          channelDescription: '오늘 마감인 일정을 표시합니다.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          ticker: 'ticker',
          styleInformation: const BigTextStyleInformation(''));
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, '오늘의 일정', body, platformChannelSpecifics, payload: 'item x');
  }
  UserData.notificationDay = DateTime.now().day;
}
