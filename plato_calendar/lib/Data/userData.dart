import 'dart:collection';

import 'package:hive/hive.dart';

import './database.dart';
import './ics.dart';

part 'userData.g.dart';

enum SortMethod {sortByDue, sortByRegister}
enum CalendarType {split,integrated}
SortMethod sortMethod = SortMethod.sortByDue;

class UserData{
  /// 마지막으로 봤던 tapIndex
  static int _tapIndex;
  
  /// 한 주의 시작, Default : 7(일요일)
  static int _firstDayOfWeek;

  /// 완료된 일정 표시 여부
  static bool _showFinished;

  /// CalendarType : split(달력, 스케줄 분리 표시), integrated(한 페이지에 표시)
  static CalendarType _calendarType;

  static String _id;
  static String _pw;
 
  static int _year = DateTime.now().year;
  static int _semester = (2 < DateTime.now().month && DateTime.now().month < 9) ? 10 : 20;

  /// 마지막 동기화 시간, Default : DateTime(1999)
  static DateTime _lastSyncTime;
  static String _lastSyncInfo;

  /// 학생지원 시스템 마지막 동기화 날짜
  static int _oneStopLastSyncDay = 0;

  /// toDoList 각 항목 접힘, 열림 여부
  /// 
  /// [지남, 6, 12, 오늘, 내일, 1주일 이하, 1주일 이상, 날짜 없음, 완료]
  static List<bool> _showToDoList;

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
  static CalendarType get calendarType => _calendarType;
  static String get id => _id;
  static String get pw => _pw;
  static int get year => _year;
  static int get semester => _semester;
  static DateTime get lastSyncTime => _lastSyncTime;
  static String get lastSyncInfo => _lastSyncInfo;
  static List<bool> get showToDoList => _showToDoList;
  static int get oneStopLastSyncDay => _oneStopLastSyncDay;

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

  static set calendarType(CalendarType newValue){
    bool update = true;
    if(_calendarType == null)
      update = false;
    
    if(newValue != null)
      _calendarType = newValue;
    else
      _calendarType = CalendarType.split;

    if(update)
      Database.userDataBox.put('calendarType', _calendarType);
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

  static set showToDoList(List<bool> newValue){
    bool update = true;
    if(_showToDoList == null)
      update = false;

    if(newValue != null)
      _showToDoList = newValue;
    else
      _showToDoList = [true,true,true,true,true,true,true,true,true];

    if(update)
      Database.userDataBox.put('showToDoList', _showToDoList);
  }

  static void showToDoListByIndex(int index, bool newvalue){
    _showToDoList[index] = newvalue;
    Database.userDataBox.put('showToDoList', _showToDoList);
  }

  static set oneStopLastSyncDay(int newValue){
    bool update = true;
    if(_oneStopLastSyncDay == null)
      update = false;

    if(newValue != null)
      _oneStopLastSyncDay = newValue;
    else
      _oneStopLastSyncDay = -1;

    if(update)
      Database.userDataBox.put('oneStopLastSyncDay', _oneStopLastSyncDay);
  }
}