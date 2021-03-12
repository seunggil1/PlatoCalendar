import 'dart:collection';

import 'package:flutter/material.dart';

import '../ics.dart';

enum SortMethod {sortByDue, sortByRegister}
SortMethod sortMethod = SortMethod.sortByDue;
/// 한 주의 시작, Default : 7(일요일)
int firstDayOfWeek;
/// 완료된 일정 표시 여부, Default : False
bool showFinished;

String id;
String pw;

String year = "2021";
String semester = "10";

/// 마지막 동기화 시간, Default : DateTime(1999)
DateTime lastSyncTime;

Set<CalendarData> data = {};
/// 이전 날짜가 먼저 오는 CalendarData set
// SplayTreeSet<CalendarData> data = SplayTreeSet<CalendarData>(
//   (CalendarData a, CalendarData b) {
//     int i = a.end.compareTo(b.end);
//     if(i == 0)
//       return a.summary.compareTo(b.summary);
//     else
//       return i;
//   }); 

/// 이번학기 수강하는 subjectCode
Set<String> subjectCodeThisSemester;

/// 과목별 default Color
Map defaultColor; // classCode, colorCollectionIndex