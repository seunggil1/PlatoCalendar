import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/util/util.dart';

import 'calendar_parser.dart';
import 'calendar_api.dart';

class AppSyncHandler {
  static final logger = LoggerManager.getLogger('service - AppSyncHandler');

  static Future<void> sync() async {
    // check last syncTime
    try {
      SyncInfo info = await SyncInfoDB.read();
      // 마지막 동기화로부터 3시간이 지나지 않았다면 동기화를 수행하지 않는다.
      if (DateTime.now().difference(info.platoSyncTime).inHours < 3) {
        logger.fine('Last sync time is less than 3 hours ago');
        return;
      }
    } on StateError catch (e, stackTrace) {
      // last sync time이 없는 경우는 오류가 아님.
      if (e.message != 'No element') {
        logger.severe('Failed to readSyncInfo: $e', stackTrace);
        rethrow;
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to readSyncInfo: $e', stackTrace);
      rethrow;
    }

    // update plato calendar
    await updatePlatoAppointment();
  }

  static Future<void> updatePlatoAppointment() async {
    // check login info
    try {
      PlatoCredential credential = await PlatoCredentialDB.read();
      List<String> calendarData =
          await CalendarAPI.getPlatoCalendar(credential);

      final data1 = CalendarParser.parse(calendarData[0]).toSet();
      final data2 = CalendarParser.parse(calendarData[1]).toSet();
      Set<PlatoAppointment> appointments = data1.union(data2);

      await Future.wait([
        SyncInfoDB.write(SyncInfo()..platoSyncTime = DateTime.now()),
        PlatoAppointmentDB.writeAll(appointments.toList())
      ]);
    } on StateError catch (e, stackTrace) {
      if (e.message != 'No element') {
        logger.severe('Failed to readCredential: $e', stackTrace);
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to readCredential: $e', stackTrace);
      rethrow;
    }
  }
}
