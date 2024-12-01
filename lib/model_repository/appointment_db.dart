import 'package:isar/isar.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

import 'package:plato_calendar/model_repository/_isar_interface.dart';

class AppointmentDB {
  static Isar? _isar;
  static final logger = LoggerManager.getLogger('AppointmentDBRepository');

  static Future<Isar> _initIsar() async {
    Isar dbInstance = await IsarInterface().initIsar(AppointmentSchema);
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

  static Future<void> writeAppointment(Appointment data) async {
    Isar db = _isar ?? await _initIsar();

    try {
      await db.writeTxn(() async {
        await db.appointments.put(data);
      });

      logger.fine('Write appointment: ${data.title}');
    } catch (e, stackTrace) {
      logger.severe('Failed to write appointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<Appointment> getAppointmentById(int id) async {
    try {
      Isar db = _isar ?? await _initIsar();
      final result = await db.appointments.get(id);

      logger.fine('Read appointment by id: ${result?.uid}');
      return result!;
    } catch (e, stackTrace) {
      logger.severe('Failed to getAppointmentById: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAppointmentById(int id) async {
    try {
      Isar db = _isar ?? await _initIsar();

      await db.writeTxn(() async {
        await db.appointments.delete(id);
      });

      logger.fine('Delete appointment by id: $id');
    } catch (e, stackTrace) {
      logger.severe('Failed to deleteAppointmentById: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<Appointment>> readAllAppointment() async {
    Isar db = _isar ?? await _initIsar();

    try {
      final result = await db.appointments.where().findAll();

      logger.fine('Read all appointments: ${result.length}');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to read all appointments: $e', stackTrace);
      rethrow;
    }
  }
}
