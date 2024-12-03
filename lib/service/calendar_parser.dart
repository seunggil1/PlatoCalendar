import 'package:icalendar_parser/icalendar_parser.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

final Set<String> _calendarReserved = {
  'BEGIN',
  'METHOD',
  'PRODID',
  'VERSION',
  'UID',
  'SUMMARY',
  'DESCRIPTION',
  'CLASS',
  'LAST-MODIFIED',
  'DTSTAMP',
  'DTSTART',
  'DTEND',
  'CATEGORIES',
  'END'
};

class CalendarParser {
  static final logger = LoggerManager.getLogger('CalendarParser');

  static List<PlatoAppointment> parse(String bytes) {
    try {
      // For Test
      // String bytes = await rootBundle.loadString('icalexport.ics');
      // End For Test

      List<String> lineBytes = bytes.split('\r\n');
      // 일정 내용에 :가 있을 경우 오류가 발생하는 경우가 있어서 : -> ####로 교체하고 파싱진행.
      for (int i = 0; i < lineBytes.length; i++) {
        int index = lineBytes[i].indexOf(':');
        if (index != -1) {
          String first = lineBytes[i].substring(0, index);
          if (_calendarReserved.contains(first)) {
            lineBytes[i] =
                '$first:${lineBytes[i].substring(index + 1).replaceAll(':', '####')}';
          } else {
            lineBytes[i] = lineBytes[i].replaceAll(':', '####');
          }
        }
      }
      bytes = lineBytes.join('\r\n');
      ICalendar iCalendar = ICalendar.fromString(bytes);

      List<PlatoAppointment> appointments =
          iCalendar.data.map((iter) => PlatoAppointment.byIcsMap(iter)).toList();

      return appointments;
    } catch (e, stackTrace) {
      logger.severe('Failed to parse ics: $e', stackTrace);
      rethrow;
    }
  }
}
