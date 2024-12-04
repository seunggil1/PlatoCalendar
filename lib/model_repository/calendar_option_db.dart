import 'package:isar/isar.dart';
import 'package:plato_calendar/model/calendar_option.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

import './_isar_interface.dart';

class CalendarOptionDBException implements Exception {
  final String message;

  CalendarOptionDBException(this.message);
}

class CalendarOptionDB {
  static Isar? _isar;
  static final logger =
      LoggerManager.getLogger('model_repository - CalendarOptionDB');

  static Future<Isar> _initIsar() async {
    Isar dbInstance = await IsarInterface().initIsar(CalendarOptionSchema);
    _isar = dbInstance;
    return dbInstance;
  }

  static Future<void> closeIsar() async {
    try {
      if (_isar?.isOpen ?? false) {
        await _isar?.close();
        logger.fine('Isar is closed');
      } else {
        logger.warning('Isar is already closed');
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to close Isar: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> write(CalendarOption data) async {
    Isar db = _isar ?? await _initIsar();

    try {
      await db.writeTxn(() async {
        await db.calendarOptions.put(data);
      });

      logger.fine(
          'Write CalendarOption: ${data.showAgenda} ${data.viewType} ${data.appointmentDisplayMode}');
    } catch (e, stackTrace) {
      logger.severe('Failed to write CalendarOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<CalendarOption> read() async {
    Isar db = _isar ?? await _initIsar();

    try {
      final result =
          await db.calendarOptions.where().sortByDbTimestampDesc().findFirst();

      if (result == null) {
        throw Exception('No CalendarOption data');
      }

      logger.fine('Read calendar option: ${result.id}');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to read CalendarOption : $e', stackTrace);
      rethrow;
    }
  }

  static Future<bool> isEmpty() async{
    try {
      Isar db = _isar ?? await _initIsar();
      final result = await db.calendarOptions.where().isEmpty();

      logger.fine('isEmpty : $result');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to check isEmpty : $e', stackTrace);
      rethrow;
    }
  }

  static Future<CalendarOption> readById(int id) async {
    try {
      Isar db = _isar ?? await _initIsar();
      final result = await db.calendarOptions.get(id);

      logger.fine('Read CalendarOption by id: ${result?.id}');
      return result!;
    } catch (e, stackTrace) {
      logger.severe('Failed to CalendarOption by id : $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteById(int id) async {
    try {
      Isar db = _isar ?? await _initIsar();

      await db.writeTxn(() async {
        await db.calendarOptions.delete(id);
      });

      logger.fine('Delete CalendarOption by id : $id');
    } catch (e, stackTrace) {
      logger.severe('Failed to CalendarOption by id : $e', stackTrace);
      rethrow;
    }
  }
}
