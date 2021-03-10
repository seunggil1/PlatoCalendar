import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Data/userData.dart' as userData;
import 'ics.dart';

class Database{
  static Box<CalendarData> calendarBox;
  static Box userDataBox;

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CalendarDataAdapter());
    calendarBox = await Hive.openBox('calendarBox');
    userDataBox = await Hive.openBox('userDataBox');
  }

  static Future clear() async{
    await calendarBox.clear();
    await userDataBox.clear();
  }

  static void calendarDataSave(){
    userDataBox.put('size', userData.data.length);
    
    int i = 0;
    for(var iter in userData.data){
      calendarBox.put(i, iter);
      i++;
    }
  }

  static void calendarDataLoad(){
    int i = 0;
    while(i < (userDataBox.get('size') ?? 0))
      userData.data.add(calendarBox.get(i++));
  }

  static void userDataSave(){
    userDataBox.put('firstDayOfWeek', userData.firstDayOfWeek);
    userDataBox.put('showFinished', userData.showFinished);
    userDataBox.put('id', userData.id);
    userDataBox.put('pw', userData.pw);
    userDataBox.put('lastSyncTime', userData.lastSyncTime);
    userDataBox.put('subjectCodeThisSemester', userData.subjectCodeThisSemester.toList());
    userDataBox.put('defaultColor', userData.defaultColor);
  }

  static void userDataLoad(){
    userData.firstDayOfWeek = userDataBox.get('firstDayOfWeek') ?? 7;
    userData.showFinished = userDataBox.get('showFinished') ?? false;
    userData.id = userDataBox.get('id') ?? "";
    userData.pw = userDataBox.get('pw') ?? "";
    userData.lastSyncTime = userDataBox.get('lastSyncTime') ?? DateTime(1999);
    userData.subjectCodeThisSemester = (userDataBox.get('subjectCodeThisSemester') ?? ["전체"]).toSet();
    userData.defaultColor = userDataBox.get('defaultColor') ?? {};
  }

}