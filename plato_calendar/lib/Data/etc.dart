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

/// 한글 날짜 형식으로 변경
String getDateTimeLocaleKR(DateTime time) => DateFormat("yyyy년 M월 d일 (","ko_KR").format(time) + weekdayLocaleKR[time.weekday] + DateFormat(")  a h:mm","ko_KR").format(time);
String getTimeLocaleKR(DateTime time) => DateFormat("HH:mm").format(time);
String toISO8601(DateTime data){
  data = data.toUtc();
  return DateFormat("yyyyMMddTHHmmss").format(data) + "Z";
}
final List<Color> colorCollection =[
  // Google Calendar에서 제공하는 색상명 사용.
  Color.fromRGBO(121, 134, 203, 1.0), // 라벤더
  Color.fromRGBO(51, 182, 121, 1.0),  // 세이지
  Color.fromRGBO(142, 36, 170, 1.0),  // 포도
  Color.fromRGBO(230, 124, 115, 1.0), // 홍학
  Color.fromRGBO(246, 191, 38, 1.0),  // 바나나
  Color.fromRGBO(244, 81, 30, 1.0),   // 귤
  Color.fromRGBO(3, 155, 229, 1.0),   // 공작, 기본색상
  Color.fromRGBO(97, 97, 97, 1.0),    // 흑연
  Color.fromRGBO(63, 81, 181, 1.0),   // 블루베리
  Color.fromRGBO(11, 128, 67, 1.0),   // 바질
  Color.fromRGBO(213, 0, 0, 1.0),     // 토마토
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
  Colors.red,
];

