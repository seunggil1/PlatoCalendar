import 'dart:collection';

import 'package:hive/hive.dart';
import '../google/calendar.dart';

import './database.dart';
import './ics.dart';
import 'package:ordered_set/ordered_set.dart';
import 'package:ordered_set/comparing.dart';

part 'userData.g.dart';

enum SortMethod {sortByDue, sortByRegister}
enum CalendarType {split,integrated}
SortMethod sortMethod = SortMethod.sortByDue;

class UserData{
  /// App build 날짜
  static double version = 20211003;

  /// background 동기화 시간
  static List syncLog = [];

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
  static OrderedSet<CalendarData> data = OrderedSet<CalendarData>(Comparing.on((CalendarData a) => a.end));

  /// 이번학기 수강하는 subjectCode
  static Set<String> subjectCodeThisSemester;

  /// 과목별 default Color
  static Map defaultColor; // classCode, colorCollectionIndex

  /// Google Token 저장 여부.
  static bool isSaveGoogleToken;

  /// Google Login 직후 최초 앱실행. Calendar 동기화 필요.
  static bool _googleFirstLogin;

  /// Google Calendar 연동을 위한 Token 정보.
  static GoogleCalendarToken googleCalendar; 

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
  static bool get googleFirstLogin => _googleFirstLogin;

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

  static set semester(int newValue){
    if(newValue == null || newValue != semester){
      subjectCodeThisSemester.clear();
      subjectCodeThisSemester.add("전체");
      Database.subjectCodeThisSemesterSave();
      Database.userDataBox.put('semester', semester);
    }
    
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

  static set googleFirstLogin(bool newValue) {
    bool update = true;
    if(_googleFirstLogin == null)
      update = false;

    if(newValue != null)
      _googleFirstLogin = newValue;
    else
      _googleFirstLogin = false;

    if(update)
      Database.userDataBox.put('googleFirstLogin', _googleFirstLogin);
  }
}