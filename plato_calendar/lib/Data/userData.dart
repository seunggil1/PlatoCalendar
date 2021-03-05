import 'dart:collection';

import 'package:flutter/material.dart';

import '../ics.dart';

enum SortMethod {sortByDue, sortByRegister}
int firstDayOfWeek = 7;
SortMethod sortMethod = SortMethod.sortByDue;
bool showFinished = false;

String id = "";
String pw = "";

String year = "2021";
String semester = "10";

DateTime lastSyncTime = DateTime(1999);

// 앞의 날짜가 먼저 오는 set
SplayTreeSet<CalendarData> data = SplayTreeSet<CalendarData>((CalendarData a, CalendarData b) => a.end.compareTo(b.end)); 
Set<String> subjectCodeThisSemester = {"전체"};
Map<String,int> defaultColor = {}; // classCode, colorCollectionIndex