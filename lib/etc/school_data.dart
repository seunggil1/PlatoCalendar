import 'package:intl/intl.dart';

final int year = DateTime.now().year;
final int semester =
    (2 < DateTime.now().month && DateTime.now().month < 9) ? 10 : 20;

final Map<int, String> weekdayLocaleKR = {
  1: '월',
  2: '화',
  3: '수',
  4: '목',
  5: '금',
  6: '토',
  7: '일',
};

/// 한글 날짜 형식으로 변경
String getDateTimeLocaleKR(DateTime time) =>
    DateFormat('yyyy년 M월 d일 (', 'ko_KR').format(time) +
    weekdayLocaleKR[time.weekday]! +
    DateFormat(')  a h:mm', 'ko_KR').format(time);

String getTimeLocaleKR(DateTime time) => DateFormat('HH:mm').format(time);

String toISO8601(DateTime data) {
  data = data.toUtc();
  return '${DateFormat('yyyyMMddTHHmmss').format(data)}Z';
}
