// Flutter imports:
import 'package:flutter/services.dart' show rootBundle;

// Project imports:
import 'package:plato_calendar/etc/school_data.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/util/util.dart';
import 'calendar_api.dart';
import 'calendar_parser.dart';

class AppSyncHandler {
  static final logger = LoggerManager.getLogger('service - AppSyncHandler');

  static Future<void> sync() async {
    // check last syncTime
    try {
      SyncInfo? info = await SyncInfoDB.read();
      if (info == null) {
        logger.fine('No sync info found');
        info = SyncInfo()..platoSyncTime = DateTime(1990);
      }
      // 마지막 동기화로부터 3시간이 지나지 않았다면 동기화를 수행하지 않는다.
      if (info.success &&
          DateTime.now().difference(info.platoSyncTime).inHours < 3) {
        logger.fine('Last sync time is less than 3 hours ago');
        await Future.delayed(const Duration(seconds: 3));
        return;
      }

      // update plato calendar
      await updatePlatoAppointment();
    } catch (e, stackTrace) {
      logger.severe('Failed to plato sync: $e', stackTrace);
      await SyncInfoDB.write(SyncInfo()
        ..success = false
        ..platoSyncTime = DateTime.now()
        ..failReason = '$e');
    }
  }

  static Future<void> updatePlatoAppointment() async {
    // check login info
    try {
      PlatoCredential? credential = await PlatoCredentialDB.read();
      if (credential == null) {
        logger.fine('No sync info found');
        return;
      }
      List<String> calendarData =
          await CalendarAPI.getPlatoCalendar(credential);

      final data1 = CalendarParser.parse(calendarData[0]).toSet();
      final data2 = CalendarParser.parse(calendarData[1]).toSet();
      Set<PlatoAppointment> appointments = data1.union(data2);

      await Future.wait([
        SyncInfoDB.write(SyncInfo()..platoSyncTime = DateTime.now()),
        PlatoAppointmentDB.writeAll(appointments.toList())
      ]);
    } catch (e, stackTrace) {
      logger.severe('Failed to updatePlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  /// 테스트를 위해 임의의 일정 생성하는 함수
  /// icalexport_test.ics 내용을 현재 날짜 기준으로 바꿔서 넣는다.
  static Future<void> addTestPlatoAppointment() async {
    String fileContent =
        await rootBundle.loadString('assets/ics/icalexport_test.ics');
    final appointments = CalendarParser.parse(fileContent);

    DateTime now = DateTime.now().subtract(const Duration(days: 2));
    now = DateTime(now.year, now.month, now.day, 0, 0, 0);

    for (var appointment in appointments) {
      appointment.year = year.toString();
      appointment.semester = semester.toString();

      appointment.start = now;
      appointment.end = now.add(const Duration(hours: 1));

      now = now.add(const Duration(hours: 4));
    }

    PlatoAppointmentDB.writeAll(appointments);
  }
}
