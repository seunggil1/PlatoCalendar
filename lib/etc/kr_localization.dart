import 'package:intl/intl.dart';

final Map<int, String> weekdayLocaleKR = const {
  1: '월',
  2: '화',
  3: '수',
  4: '목',
  5: '금',
  6: '토',
  7: '일',
};

final Map<int, String> taskDurationLocaleKR = const {
  0: '지난 할일',
  1: '6시간 남음',
  2: '12시간 남음',
  3: '오늘',
  4: '내일',
  5: '7일 이내',
  6: '7일 이상',
  7: '완료',
};

String getDateTimeLocaleKR(DateTime data) {
  return DateFormat('MM-dd ').format(data) +
      weekdayLocaleKR[data.weekday]! +
      DateFormat(' HH:mm').format(data);
}

/// 한글 날짜 형식으로 변경
String getFullDateTimeLocaleKR(DateTime time) =>
    DateFormat('yyyy년 M월 d일 (', 'ko_KR').format(time) +
    weekdayLocaleKR[time.weekday]! +
    DateFormat(')  a h:mm', 'ko_KR').format(time);

String getTimeLocaleKR(DateTime time) => DateFormat('HH:mm').format(time);

String toISO8601(DateTime data) {
  data = data.toUtc();
  return '${DateFormat('yyyyMMddTHHmmss').format(data)}Z';
}
