import 'package:plato_calendar/model/model.dart';
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
      final originalData = await database.readAll();
      final originalUidSet = originalData.map((e) => e.toModel().uid).toSet();

      final updateTargetList =
          data.where((element) => !originalUidSet.contains(element.uid));

      // TODO : 데이터 변동이 있으면 어떻게 업데이트 할 것인지 고민해보기
      final schemaList = updateTargetList.map((e) => e.toSchema()).toList();
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

  static Future<List<PlatoAppointment>> readPastPlatoAppointment() async {
    try {
      final result = await database.readPastPlatoAppointment();
      logger.fine('readPastPlatoAppointment : ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPastPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithin6Hours() async {
    try {
      final result = await database.readPlatoAppointmentWithin6Hours();
      logger.fine('readPlatoAppointmentWithin6Hours: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPlatoAppointmentWithin6Hours: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithin12Hours() async {
    try {
      final result = await database.readPlatoAppointmentWithin12Hours();
      logger.fine('readPlatoAppointmentWithin12Hours: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPlatoAppointmentWithin12Hours: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readTodayPlatoAppointment() async {
    try {
      final result = await database.readTodayPlatoAppointment();
      logger.fine('readTodayPlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readTodayPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readTomorrowPlatoAppointment() async {
    try {
      final result = await database.readTomorrowPlatoAppointment();
      logger.fine('readTomorrowPlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readTomorrowPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithinWeek() async {
    try {
      final result = await database.readPlatoAppointmentWithinWeek();
      logger.fine('readPlatoAppointmentWithinWeek: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPlatoAppointmentWithinWeek: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentMoreThanWeek() async {
    try {
      final result = await database.readPlatoAppointmentMoreThanWeek();
      logger.fine('readPlatoAppointmentMoreThanWeek: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPlatoAppointmentMoreThanWeek: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readCompletePlatoAppointment() async {
    try {
      final result = await database.readCompletePlatoAppointment();
      logger.fine('readCompletePlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readCompletePlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await database.deleteAll();
    } catch (e, stackTrace) {
      logger.severe('Failed to deleteAllAppointments: $e', stackTrace);
      rethrow;
    }
  }
}
