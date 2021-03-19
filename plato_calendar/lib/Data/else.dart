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

final List<Color> colorCollection =[
  Colors.red[200],
  Colors.indigo,
  Colors.orange,
  Colors.green,
  Colors.lightGreen,
  Colors.blueGrey,
  Colors.teal[200],
  Colors.pink[300],
  Colors.brown[400],
  Colors.blue,
  Colors.purple[400],
];

