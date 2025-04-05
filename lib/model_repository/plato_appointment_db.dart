// Project imports:
import 'package:plato_calendar/etc/subject_code.dart';
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
      final originalData = await database.readAll(showFinished: true);
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

  static Future<List<PlatoAppointment>> readAll(
      {required bool showFinished}) async {
    try {
      final result = await database.readAll(showFinished: showFinished);
      logger.fine('Read all appointments: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readAllAppointments: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<String>> readAllSubjectCode() async {
    try {
      final result = [subjectCodeAll];
      result.addAll(await database.readAllSubjectCode());
      // result.remove(subjectNone);

      logger.fine('Read all subject code: ${result.length}');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to readAllSubjectCode: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoAppointment> readByUid(String uid) async {
    try {
      final result = await database.readByUid(uid);
      logger.fine('Read appointment by uid: $uid');
      return result.toModel();
    } catch (e, stackTrace) {
      logger.severe('Failed to read appointment by uid: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPastPlatoAppointment(
      String subjectCode) async {
    try {
      final result = await database.readPastPlatoAppointment(subjectCode);
      logger.fine('readPastPlatoAppointment : ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPastPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithin6Hours(
      String subjectCode) async {
    try {
      final result =
          await database.readPlatoAppointmentWithin6Hours(subjectCode);
      logger.fine('readPlatoAppointmentWithin6Hours: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe(
          'Failed to readPlatoAppointmentWithin6Hours: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithin12Hours(
      String subjectCode) async {
    try {
      final result =
          await database.readPlatoAppointmentWithin12Hours(subjectCode);
      logger.fine('readPlatoAppointmentWithin12Hours: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe(
          'Failed to readPlatoAppointmentWithin12Hours: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readTodayPlatoAppointment(
      String subjectCode) async {
    try {
      final result = await database.readTodayPlatoAppointment(subjectCode);
      logger.fine('readTodayPlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readTodayPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readTomorrowPlatoAppointment(
      String subjectCode) async {
    try {
      final result = await database.readTomorrowPlatoAppointment(subjectCode);
      logger.fine('readTomorrowPlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readTomorrowPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithinWeek(
      String subjectCode) async {
    try {
      final result = await database.readPlatoAppointmentWithinWeek(subjectCode);
      logger.fine('readPlatoAppointmentWithinWeek: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to readPlatoAppointmentWithinWeek: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentMoreThanWeek(
      String subjectCode) async {
    try {
      final result =
          await database.readPlatoAppointmentMoreThanWeek(subjectCode);
      logger.fine('readPlatoAppointmentMoreThanWeek: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe(
          'Failed to readPlatoAppointmentMoreThanWeek: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readCompletePlatoAppointment(
      String subjectCode) async {
    try {
      final result = await database.readCompletePlatoAppointment(subjectCode);
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
