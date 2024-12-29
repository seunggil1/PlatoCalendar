import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model/plato_appointment.dart';
import 'package:plato_calendar/model/table/table.dart';
import 'package:plato_calendar/util/logger.dart';

class PlatoAppointmentDB {
  static PlatoAppointmentDrift database = PlatoAppointmentDrift();

  static final logger =
      LoggerManager.getLogger('model_repository - PlatoAppointmentDB');

  static Future<void> write(PlatoAppointment data) async {
    try {
      await database.write(data.toSchema());
    } catch (e, stackTrace) {
      logger.severe('Failed to writeAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> writeAll(List<PlatoAppointment> data) async {
    try {
      final schemaList = data.map((e) => e.toSchema()).toList();
      await database.writeAll(schemaList);
    } catch (e, stackTrace) {
      logger.severe('Failed to writeAllAppointments: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readAll() async {
    try {
      final result = await database.readAll();
      logger.fine('Read all appointments: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readAllAppointments: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoAppointment> readById(int id) async {
    try {
      final result = await database.readById(id);
      logger.fine('Read appointment by id: $id');
      return result.toModel();
    } catch (e, stackTrace) {
      logger.severe('Failed to readAppointmentById: $e', stackTrace);
      rethrow;
    }
  }
}
