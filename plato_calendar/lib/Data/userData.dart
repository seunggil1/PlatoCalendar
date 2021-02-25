import '../ics.dart';

enum SortMethod {sortByDue, sortByRegister}

SortMethod sortMethod = SortMethod.sortByDue;

String id;
String pw;
Set<CalendarData> data = Set<CalendarData>();