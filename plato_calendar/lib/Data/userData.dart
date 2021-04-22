import 'dart:collection';

import '../database.dart';
import '../ics.dart';

enum SortMethod {sortByDue, sortByRegister}
SortMethod sortMethod = SortMethod.sortByDue;

class UserData{
  /// 마지막으로 봤던 tapIndex
  static int _tapIndex;
  
  /// 한 주의 시작, Default : 7(일요일)
  static int _firstDayOfWeek;

  /// 완료된 일정 표시 여부
  static bool _showFinished;

  static String _id;
  static String _pw;
 
  static String _year = "2021";
  static String _semester = "10";

  /// 마지막 동기화 시간, Default : DateTime(1999)
  static DateTime _lastSyncTime;
  static String _lastSyncInfo;


/// 이전 날짜가 먼저 오는 CalendarData set
  static SplayTreeSet<CalendarData> data = SplayTreeSet<CalendarData>(
  (CalendarData a, CalendarData b) {
    int i = a.end.compareTo(b.end);
    if(i == 0)
      return a.uid.compareTo(b.uid);
    else
      return i;
  }); 

  /// 이번학기 수강하는 subjectCode
  static Set<String> subjectCodeThisSemester;

  /// 과목별 default Color
  static Map defaultColor; // classCode, colorCollectionIndex

  static int get tapIndex => _tapIndex;
  static int get firstDayOfWeek => _firstDayOfWeek;
  static bool get showFinished => _showFinished;
  static String get id => _id;
  static String get pw => _pw;
  static String get year => _year;
  static String get semester => _semester;
  static DateTime get lastSyncTime => _lastSyncTime;
  static String get lastSyncInfo => _lastSyncInfo;

  static set tapIndex(int newValue){
    bool update = true;
    if(_tapIndex == null)
      update = false;
    
    if(newValue != null)
      _tapIndex = newValue;
    else
      _tapIndex = 0;

    if(update)
      Database.userDataBox.put('tapIndex', _tapIndex);
  }

  static set firstDayOfWeek(int newValue){
    bool update = true;
    if(_firstDayOfWeek == null)
      update = false;
    
    if(newValue != null)
      _firstDayOfWeek = newValue;
    else
      _firstDayOfWeek = 7;

    if(update)
      Database.userDataBox.put('firstDayOfWeek', _firstDayOfWeek);
  }

  static set showFinished(bool newValue){
    bool update = true;
    if(_showFinished == null)
      update = false;
    
    if(newValue != null)
      _showFinished = newValue;
    else
      _showFinished = true;

    if(update)
      Database.userDataBox.put('showFinished', _showFinished);
  }

  static set id(String newValue){
    bool update = true;
    if(_id == null)
      update = false;
    
    if(newValue != null)
      _id = newValue;
    else
      _id = "";

    if(update)
      Database.userDataBox.put('id', _id);
  }

  static set pw(String newValue){
    bool update = true;
    if(_pw == null)
      update = false;
    
    if(newValue != null)
      _pw = newValue;
    else
      _pw = "";

    if(update)
      Database.userDataBox.put('pw', _pw);
  }

  static set lastSyncTime(DateTime newValue){
    bool update = true;
    if(_lastSyncTime == null)
      update = false;
    
    if(newValue != null)
      _lastSyncTime = newValue;
    else
      _lastSyncTime = DateTime(1999);

    if(update)
      Database.userDataBox.put('lastSyncTime', _lastSyncTime);
  }

  static set lastSyncInfo(String newValue){
    bool update = true;
    if(_lastSyncInfo == null)
      update = false;

    if(newValue != null)
      _lastSyncInfo = newValue;
    else
      _lastSyncInfo = "로그인이 필요합니다";

    if(update)
      Database.userDataBox.put('lastSyncInfo', _lastSyncInfo);
  }
}