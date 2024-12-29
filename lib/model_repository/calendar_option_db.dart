import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model/table/table.dart';
import 'package:plato_calendar/util/logger.dart';

class CalendarOptionDB {
  static final logger =
      LoggerManager.getLogger('model_repository - CalendarOptionDB');
  static CalendarOptionDrift database = CalendarOptionDrift();

  Future<void> write(CalendarOption data) async {
    try {
      await database.replace(data.toSchema());
    } catch (e, stackTrace) {
      logger.severe('Failed to writeCalendarOption: $e', stackTrace);
      rethrow;
    }
  }

  Future<CalendarOption> read() async {
    try {
      return await database.read().then((value) => value.toModel());
    } catch (e, stackTrace) {
      logger.severe('Failed to readCalendarOption: $e', stackTrace);
      rethrow;
    }
  }

  Future<bool> isEmpty() async {
    try {
      return await database.isEmpty();
    } catch (e, stackTrace) {
      logger.severe(
          'Failed to check if calendarOption is empty: $e', stackTrace);
      rethrow;
    }
  }

  Future<int> count() async {
    try {
      return await database.count();
    } catch (e, stackTrace) {
      logger.severe('Failed to count calendarOption: $e', stackTrace);
      rethrow;
    }
  }
}
