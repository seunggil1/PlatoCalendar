import 'package:flutter/services.dart' show rootBundle;
import 'package:icalendar_parser/icalendar_parser.dart';

// UID	      일정의 고유한 ID 값. 단일 캘린더 ID에서는 iCalendar의 UID가 고유해야 한다.
//            UID는 일반적으로 iCalendar 데이터를 최초 생성할 때 사용자 ID, 타임스탬프, 도메인 등의 정보를 조합해서 만든다.
//            이때 특수 기호 % 문자는 이스케이프 문제로 지원되지 않으니 주의한다.
// DTSTART	  일정이 시작된 날짜 및 시간.
//            별도의 표준시간대를 사용하지 않는다면 'T' 이하의 시간 값만 수정해서 사용할 수 있다.
//            DTEND	일정이 종료된 날짜 및 시간.
//            별도의 표준시간대를 사용하지 않는다면 'T' 이하의 시간 값만 수정해서 사용할 수 있다.
// SUMMARY	  일정 제목
// DESCRIPTION	일정의 상세 내용
// LOCATION	  장소 정보
// RRULE	    반복 정보
// ORGANIZER	캘린더 시스템 이메일.
//            기본 캘린더에 약속 생성 시, 캘린더 API 서버에 의해서 기본 캘린더 Owner 이메일로 설정된다.
//            공유 캘린더에 약속 생성 시, 캘린더 API 서버에 의해서 캘린더 시스템 이메일로 설정된다.
//            약속 수정 시에는 조회된 ORGANIZER를 그대로 사용해야 한다.
//            약속이 아니면 ORGANIZER를 빼고 iCalendar 데이터를 생성한다.
// ATTENDEE	  약속인 경우 참석자 정보.
//            약속이 아니면 ATTENDEE를 빼고 iCalendar 데이터를 생성한다.
// CREATED	  일정이 생성된 날짜 및 시간
// LAST-MODIFIED	일정이 최종 수정된 날짜 및 시간
// DTSTAMP	  일정을 iCalendar 데이터로 변환한 날짜 및 시간(현재는 중요하지 않게 취급).

ICalendar iCalendar;
void test() async{
  String bytes = await rootBundle.loadString('icalexport.ics');
  iCalendar = ICalendar.fromString(bytes);
  print(1);
}