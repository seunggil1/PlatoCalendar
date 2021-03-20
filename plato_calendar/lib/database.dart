import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Data/userData.dart';
import 'ics.dart';

class Database{
  static Box calendarBox;
  static Box userDataBox;

  static Set<String> uidSet = {};

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

  static void uidSetSave(){
    calendarBox.put('uidList', Database.uidSet.toList());
  }
  static void calendarDataSave(CalendarData data){
    calendarBox.put(data.uid,data);
  }
  static void calendarDataLoad(){
    uidSet = (calendarBox.get('uidList') ?? <String>[]).toSet();;
    for(var iter in uidSet)
      UserData.data.add(calendarBox.get(iter));
  }

  static void subjectCodeThisSemesterSave(){
    userDataBox.put('subjectCodeThisSemester', UserData.subjectCodeThisSemester.toList());
  }

  static void defaultColorSave(){
    userDataBox.put('defaultColor', UserData.defaultColor);
  }



  static void userDataLoad(){
    UserData.firstDayOfWeek = userDataBox.get('firstDayOfWeek');
    UserData.showFinished = userDataBox.get('showFinished');
    UserData.id = userDataBox.get('id');
    UserData.pw = userDataBox.get('pw');
    UserData.lastSyncTime = userDataBox.get('lastSyncTime');
    UserData.subjectCodeThisSemester = (userDataBox.get('subjectCodeThisSemester') ?? ["전체"]).toSet();
    UserData.defaultColor = userDataBox.get('defaultColor') ?? {};
  }

}