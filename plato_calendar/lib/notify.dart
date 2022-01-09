import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Data/etc.dart';
import 'Data/userData.dart';
import 'Data/appinfo.dart';
import 'package:flutter/material.dart';
import 'package:plato_calendar/logger.dart';

class Notify{
  static int notificationId = 0;
  static Logger _log;

  // #3 push message
  static Future<void> notificationInit() async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_name');
    final initSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: true,
    );
    final initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
    );
    _log = Logger();
  }

  static Future<void> notifyTodaySchedule() async{
    if(UserData.notificationDay == DateTime.now().day || DateTime.now().hour < 8)
      return;
    
    String body = "";
    int nowMonth = DateTime.now().month;
    int today = DateTime.now().day;
    int count = 1;
    UserData.data.forEach((element){
      if(!element.disable && !element.finished && element.end.month == nowMonth && element.end.day == today){
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
        count++;
      }
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
            color: Colors.blue,
            styleInformation: const BigTextStyleInformation(''));
      const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, '오늘의 일정', body, platformChannelSpecifics, payload: 'item x');
    }
    UserData.notificationDay = DateTime.now().day;
    await UserData.writeDatabase.updateTime();
  }

  /// 오류 메세지 상단 알림으로 표시.(Appinfo.buildType이 Debug Mode 일때만)
  /// 
  /// id가 같은건 동시에 하나만 표시되는 것으로 추정.
  static Future<void> notifyDebugInfo(String e, {bool sendLog = false, StackTrace trace , String additionalInfo = ""}) async{
    if(sendLog){
      _log.sendEmail(e, trace.toString() ?? "", additionalInfo);
    }
    if(Appinfo.buildType == BuildType.release)
      return;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('1', 'Error Info',
          channelDescription: '오류 정보를 표시합니다.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          ticker: 'ticker',
          color: Colors.blue,
          styleInformation: const BigTextStyleInformation(''));
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(notificationId, 'Error', '$notificationId.' + e, platformChannelSpecifics, payload: 'item x');
    notificationId++;
  }
}