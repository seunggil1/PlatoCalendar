import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Data/userData.dart';
import 'ics.dart';

class Database{
  static Box calendarBox;
  static Box userDataBox;

  static Set<String> uidSet = {};

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CalendarDataAdapter());
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    if (!(await secureStorage.containsKey(key: 'key'))) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));

    calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(encryptionKey));
    userDataBox = await Hive.openBox('userDataBox', encryptionCipher: HiveAesCipher(encryptionKey));
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
    uidSet = (calendarBox.get('uidList') ?? <String>[]).toSet();
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
    UserData.tapIndex = userDataBox.get('tapIndex');
    UserData.firstDayOfWeek = userDataBox.get('firstDayOfWeek');
    UserData.showFinished = userDataBox.get('showFinished');
    UserData.id = userDataBox.get('id');
    UserData.pw = userDataBox.get('pw');
    UserData.lastSyncTime = userDataBox.get('lastSyncTime');
    UserData.lastSyncInfo = userDataBox.get('lastSyncInfo');
    UserData.subjectCodeThisSemester = (userDataBox.get('subjectCodeThisSemester') ?? ["전체"]).toSet();
    UserData.defaultColor = userDataBox.get('defaultColor') ?? {};
  }

}