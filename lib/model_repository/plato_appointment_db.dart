import 'package:isar/isar.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

import './_isar_interface.dart';

class PlatoAppointmentDB {
  static Isar? _isar;
  static final logger = LoggerManager.getLogger('model_repository - PlatoAppointmentDB');

  static Future<Isar> _initIsar() async {
    Isar dbInstance = await IsarInterface().initIsar(PlatoAppointmentSchema);
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

  static Future<void> writeAppointment(PlatoAppointment data) async {
    Isar db = _isar ?? await _initIsar();

    try {
      await db.writeTxn(() async {
        await db.platoAppointments.put(data);
      });

      logger.fine('Write appointment: ${data.title}');
    } catch (e, stackTrace) {
      logger.severe('Failed to write appointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoAppointment> getAppointmentById(int id) async {
    try {
      Isar db = _isar ?? await _initIsar();
      final result = await db.platoAppointments.get(id);

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
        await db.platoAppointments.delete(id);
      });

      logger.fine('Delete appointment by id: $id');
    } catch (e, stackTrace) {
      logger.severe('Failed to deleteAppointmentById: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readAllAppointment() async {
    Isar db = _isar ?? await _initIsar();

    try {
      final result = await db.platoAppointments.where().findAll();

      logger.fine('Read all appointments: ${result.length}');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to read all appointments: $e', stackTrace);
      rethrow;
    }
  }
}
