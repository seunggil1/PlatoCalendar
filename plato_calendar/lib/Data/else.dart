import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Map<int, String> weekdayLocaleKR = {
  1 : "월",
  2 : "화",
  3 : "수",
  4 : "목",
  5 : "금",
  6 : "토",
  7 : "일",
};

String getTimeLocaleKR(DateTime time) => DateFormat("yyyy년 M월 d일 (","ko_KR").format(time) + weekdayLocaleKR[time.weekday] + DateFormat(")  a h:mm","ko_KR").format(time);
String toISO8601(DateTime data){
  data = data.toUtc();
  return DateFormat("yyyyMMddThhmmss").format(data) + "Z";
}
final List<Color> colorCollection =[
  Colors.red[200],
  Colors.indigo,
  Colors.orange,
  Colors.pink[300],
  Colors.green,
  Colors.teal[200],
  Colors.brown[400],
  Colors.lightGreen,
  Colors.blueGrey,
  Colors.blue,
  Colors.purple[400],
];

