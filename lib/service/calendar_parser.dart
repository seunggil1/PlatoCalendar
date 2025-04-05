// Package imports:
import 'package:collection/collection.dart';
import 'package:icalendar_parser/icalendar_parser.dart';

// Project imports:
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
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

      List<PlatoAppointment> appointments = iCalendar.data
          .map((iter) => PlatoAppointment.byIcsMap(iter))
          .toList();

      return appointments;
    } catch (e, stackTrace) {
      logger.severe('Failed to parse ics: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> updateSubjectCodeColor(
      Iterable<PlatoAppointment> appointments) async {
    // 중복된 과목코드 제거
    final subjectCodeList = appointments.mapIndexed((index, appointments) {
      return appointments.subjectCode;
    }).toSet();

    // 기존에 저장된 과목코드 가져오기
    final existSubjectCodeList =
        (await SubjectCodeColorDB.readAllThisSemester())
            .mapIndexed((index, subjectCodeColor) {
      return subjectCodeColor.subjectCode;
    }).toSet();

    // 새로운 과목코드 리스트 생성
    final newSubjectCodeList = subjectCodeList.difference(existSubjectCodeList);

    // 새로운 과목코드의 색상 지정
    final update = newSubjectCodeList.mapIndexed((index, newSubjectCode) {
      return SubjectCodeColor(
          subjectCode: newSubjectCode,
          color: (index + existSubjectCodeList.length) % calendarColor.length);
    }).toList(growable: false);

    await SubjectCodeColorDB.writeAll(update);
  }

  static Future<Iterable<PlatoAppointment>> setPlatoAppointmentColor(
      Iterable<PlatoAppointment> appointments) async {
    // { subjectCode: color } 형태로 저장된 과목코드 색상 가져오기
    final subjectCodeColorMap = await SubjectCodeColorDB.readAll();

    appointments = appointments.mapIndexed((index, appointment) {
      appointment.color = subjectCodeColorMap[appointment.subjectCode] ?? 0;
      return appointment;
    });

    return appointments;
  }
}
