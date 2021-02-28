import 'dart:collection';

import '../ics.dart';

enum SortMethod {sortByDue, sortByRegister}
int firstDayOfWeek = 7;
SortMethod sortMethod = SortMethod.sortByDue;

String id = "";
String pw = "";

String year = "2021";
String semester = "10";

// 앞의 날짜가 먼저 오는 set
SplayTreeSet<CalendarData> data = SplayTreeSet<CalendarData>((CalendarData a, CalendarData b) => a.end.compareTo(b.end)); 
Set<String> subjectThisSemester = {"전체"};