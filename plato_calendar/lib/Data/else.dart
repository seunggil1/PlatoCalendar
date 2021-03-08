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

String getTimeLocaleKR(DateTime time) => DateFormat("yyyy년 M월 d일 (","ko_KR").format(time) + weekdayLocaleKR[time.weekday] + DateFormat(")      a h:mm","ko_KR").format(time);

final List<Color> colorCollection =[
  Colors.red,
  Colors.red[200],
  Colors.orange,
  Colors.lightGreen,
  Colors.green,
  Colors.blue,
  Colors.brown[900],
  Colors.purple,
  Colors.grey
];

