import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:plato_calendar/Data/appinfo.dart';
import '../google/calendar.dart';

import 'database/database.dart';
import './ics.dart';

part 'userData.g.dart';

enum SortMethod { sortByDue, sortByRegister }

enum CalendarType { split, integrated }

SortMethod sortMethod = SortMethod.sortByDue;

class UserData {
  /// read Only Database.
  ///
  /// 다른 프로세스에서 작정한 데이터베이스랑 연결됨.
  static Database readDatabase;

  /// 변경 사항을 기록할 Database.
  static Database writeDatabase;

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
  static int _semester =
      (2 < DateTime.now().month && DateTime.now().month < 9) ? 10 : 20;

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
  ///
  /// 변경사항이 있을 경우 showToDoListByIndex 함수를 통해 변경필요.
  static List<bool> _showToDoList;

  /// CalendarData set에 있는 Uid 목록
  ///
  /// Database.uidSetSave함수를 통해 수동으로 DB에 저장 필요.
  static Set<String> uidSet = {};

  /// CalendarData set
  static Set<CalendarData> data = {};

  /// 이번학기 수강하는 subjectCode
  ///
  ///  Database.subjectCodeThisSemesterSave 함수를 통해 수동으로 DB에 저장 필요.
  static Set<String> subjectCodeThisSemester;

  /// 과목별 default Color
  ///
  /// Database.defaultColorSave 함수를 통해 수동으로 DB에 저장 필요.
  static Map defaultColor; // classCode, colorCollectionIndex

  /// Google Token 저장 여부.
  static bool isSaveGoogleToken;

  /// Google Login 직후 최초 앱실행.
  ///
  /// True일 경우 Google Calendar 전체 동기화 필요.
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

  static set tapIndex(int newValue) {
    _tapIndex = newValue ?? 0;
    writeDatabase.userDataBox.put('tapIndex', _tapIndex);
  }

  static set firstDayOfWeek(int newValue) {
    _firstDayOfWeek = newValue ?? 7;
    writeDatabase.userDataBox.put('firstDayOfWeek', _firstDayOfWeek);
  }

  static set showFinished(bool newValue) {
    _showFinished = newValue ?? true;
    writeDatabase.userDataBox.put('showFinished', _showFinished);
  }

  static set calendarType(CalendarType newValue) {
    _calendarType = newValue ?? CalendarType.split;
    writeDatabase.userDataBox.put('calendarType', _calendarType);
  }

  static set id(String newValue) {
    _id = newValue ?? "";
    writeDatabase.userDataBox.put('id', _id);
  }

  static set pw(String newValue) {
    _pw = newValue ?? "";
    writeDatabase.userDataBox.put('pw', _pw);
  }

  static set lastSyncTime(DateTime newValue) {
    _lastSyncTime = newValue ?? DateTime(1999);
    writeDatabase.userDataBox.put('lastSyncTime', _lastSyncTime);
  }

  static set lastSyncInfo(String newValue) {
    _lastSyncInfo = newValue ?? "로그인이 필요합니다";
    writeDatabase.userDataBox.put('lastSyncInfo', _lastSyncInfo);
  }

  static set showToDoList(List<bool> newValue) {
    _showToDoList =
        newValue ?? [true, true, true, true, true, true, true, true, true];
    writeDatabase.userDataBox.put('showToDoList', _showToDoList);
  }

  static set semester(int newValue) {
    if ((newValue == null || newValue != semester) &&
        readDatabase.runtimeType == writeDatabase.runtimeType) {
      subjectCodeThisSemester.clear();
      subjectCodeThisSemester.add("전체");
      writeDatabase.subjectCodeThisSemesterSave();
      writeDatabase.userDataBox.put('semester', semester);
    }
  }

  static void showToDoListByIndex(int index, bool newvalue) {
    _showToDoList[index] = newvalue;
    writeDatabase.userDataBox.put('showToDoList', _showToDoList);
  }

  static set oneStopLastSyncDay(int newValue) {
    _oneStopLastSyncDay = newValue ?? -1;
    writeDatabase.userDataBox.put('oneStopLastSyncDay', _oneStopLastSyncDay);
  }

  static set notificationDay(int newValue) {
    if (newValue != null)
      _notificationDay = newValue;
    else
      _notificationDay = 0;

    writeDatabase.userDataBox.put('notificationDay', _notificationDay);
  }

  static set googleFirstLogin(bool newValue) {
    _googleFirstLogin = newValue ?? false;

    //if(Database.mode == Mode.update)
    writeDatabase.userDataBox.put('googleFirstLogin', _googleFirstLogin);
  }

  static set themeMode(ThemeMode newValue) {
    _themeMode = newValue ?? ThemeMode.system;

    writeDatabase.userDataBox.put('themeMode', newValue);
  }

  /// 디버깅용 코드
  ///
  /// Database의 모든 data 추출해서 반환.
  static String getAllData() {
    // release 버전에서 사용되면 안됨.
    if (Appinfo.buildType == BuildType.release) return "";

    String result = DateTime.now().toString() + '\n';

    result += "readDatabase : " + readDatabase.runtimeType.toString() + '\n';
    result += "writeDatabase : " + writeDatabase.runtimeType.toString() + '\n';
    result += "tapIndex : " + _tapIndex.toString() + '\n';
    result += "firstDayOfWeek : " + _firstDayOfWeek.toString() + '\n';
    result += "showFinished : " + _showFinished.toString() + '\n';
    result += "calendarType : " + _calendarType.toString() + '\n';
    result += "year : " + _year.toString() + '\n';
    result += "semester : " + _semester.toString() + '\n';
    result += "lastSyncTime : " + _lastSyncTime.toString() + '\n';
    result += "lastSyncInfo : " + _lastSyncInfo.toString() + '\n';
    result += "oneStopLastSyncDay : " + _oneStopLastSyncDay.toString() + '\n';
    result += "notificationDay : " + _notificationDay.toString() + '\n';
    result += "showToDoList : " + _showToDoList.toString() + '\n';
    result += "uidSet : " + uidSet.toString() + '\n';
    result += "subjectCodeThisSemester : " +
        subjectCodeThisSemester.toString() +
        '\n';
    result += "isSaveGoogleToken : " + isSaveGoogleToken.toString() + '\n';
    result += "themeMode : " + _themeMode.toString() + '\n';

    result += "Calendar" + '\n\n';
    int i = 1;
    for (CalendarData d in data) {
      result += '${i.toString()}. ' + d.summary + '\n';
      result += d.classCode + ' ';
      result += d.className + '\n';
      result += d.description + '\n';
      result += 'finished : ' + d.finished.toString() + '\n';
      result += 'disabled : ' + d.disable.toString() + '\n\n\n\n';
      i++;
    }

    return result;
  }
}
