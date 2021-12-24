import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../google/calendar.dart';

import './database.dart';
import './ics.dart';

part 'userData.g.dart';

enum SortMethod {sortByDue, sortByRegister}
enum CalendarType {split,integrated}
enum BuildType {debug, release}
SortMethod sortMethod = SortMethod.sortByDue;

class UserData{
  /// release, debug 여부 표시
  /// debug 모드일때 오류, 백그라운드 동기화를 상단 알림으로 표시함.
  static BuildType buildType = BuildType.debug;

  /// App build 날짜
  static double version = 2021225;

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

  /// 마지막 notification 날짜
  static int _notificationDay;

  /// toDoList 각 항목 접힘, 열림 여부
  /// 
  /// [지남, 6, 12, 오늘, 내일, 1주일 이하, 1주일 이상, 날짜 없음, 완료]
  static List<bool> _showToDoList;
  
  /// 이전 날짜가 먼저 오는 CalendarData set
  static Set<CalendarData> data = {};

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

  /// 다크모드 설정. (시스템 설정, 라이트 모드, 다크모드)
  static ThemeMode _themeMode;

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
  static int get notificationDay => _notificationDay;
  static bool get googleFirstLogin => _googleFirstLogin;
  static ThemeMode get themeMode => _themeMode;

  static set tapIndex(int newValue){
    _tapIndex = newValue ?? 0;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('tapIndex', _tapIndex);
  }

  static set firstDayOfWeek(int newValue){   
    _firstDayOfWeek = newValue ?? 7;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('firstDayOfWeek', _firstDayOfWeek);
  }

  static set showFinished(bool newValue){ 
    _showFinished = newValue ?? true;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('showFinished', _showFinished);
  }

  static set calendarType(CalendarType newValue){
    _calendarType = newValue ?? CalendarType.split;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('calendarType', _calendarType);
  }

  static set id(String newValue){ 
    _id = newValue ?? "";

    if(Database.mode == Mode.update)
      Database.userDataBox.put('id', _id);
  }

  static set pw(String newValue){
    _pw = newValue ?? "";

    if(Database.mode == Mode.update)
      Database.userDataBox.put('pw', _pw);
  }

  static set lastSyncTime(DateTime newValue){   
    _lastSyncTime = newValue ?? DateTime(1999);

    if(Database.mode == Mode.update)
      Database.userDataBox.put('lastSyncTime', _lastSyncTime);
  }

  static set lastSyncInfo(String newValue){
    _lastSyncInfo = newValue ?? "로그인이 필요합니다";

    if(Database.mode == Mode.update)
      Database.userDataBox.put('lastSyncInfo', _lastSyncInfo);
  }

  static set showToDoList(List<bool> newValue){
    _showToDoList = newValue ?? [true,true,true,true,true,true,true,true,true];

    if(Database.mode == Mode.update)
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
    _oneStopLastSyncDay = newValue ?? -1;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('oneStopLastSyncDay', _oneStopLastSyncDay);
  }

  static set notificationDay(int newValue){
    if(newValue != null)
      _notificationDay = newValue;
    else
      _notificationDay = 0;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('notificationDay', _notificationDay);
  }

  static set googleFirstLogin(bool newValue) {
    _googleFirstLogin = newValue ?? false;

    //if(Database.mode == Mode.update)
    Database.userDataBox.put('googleFirstLogin', _googleFirstLogin);
  }

  static set themeMode(ThemeMode newValue) {
    _themeMode = newValue ?? ThemeMode.system;

    if(Database.mode == Mode.update)
      Database.userDataBox.put('themeMode', newValue);
  }
}