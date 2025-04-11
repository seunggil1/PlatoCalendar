// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/etc/subject_code.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class PlatoAppointmentDB {
  static final _logger =
      LoggerManager.getLogger('model_repository - PlatoAppointmentDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield* _dbUpdateStream.stream;
  }

  static final PlatoAppointmentDrift _database = PlatoAppointmentDrift();

  static Future<void> write(PlatoAppointment data) async {
    try {
      await _database.write(data.toSchema());
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to writeAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> writeAll(List<PlatoAppointment> data) async {
    try {
      final originalData = await _database.readAll(showFinished: true);
      final originalUidSet = originalData.map((e) => e.toModel().uid).toSet();

      final updateTargetList =
          data.where((element) => !originalUidSet.contains(element.uid));

      final schemaList = updateTargetList.map((e) => e.toSchema()).toList();
      await _database.writeAll(schemaList);
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to writeAllAppointments: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readAll(
      {required bool showFinished}) async {
    try {
      final result = await _database.readAll(showFinished: showFinished);
      _logger.fine('Read all appointments: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to readAllAppointments: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<String>> readAllSubjectCode() async {
    try {
      final result = [subjectCodeAll];
      result.addAll(await _database.readAllSubjectCode());
      // result.remove(subjectNone);

      _logger.fine('Read all subject code: ${result.length}');
      return result;
    } catch (e, stackTrace) {
      _logger.severe('Failed to readAllSubjectCode: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoAppointment> readByUid(String uid) async {
    try {
      final result = await _database.readByUid(uid);
      _logger.fine('Read appointment by uid: $uid');
      return result.toModel();
    } catch (e, stackTrace) {
      _logger.severe('Failed to read appointment by uid: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPastPlatoAppointment(
      String subjectCode) async {
    try {
      final result = await _database.readPastPlatoAppointment(subjectCode);
      _logger.fine('readPastPlatoAppointment : ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to readPastPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithin6Hours(
      String subjectCode) async {
    try {
      final result =
          await _database.readPlatoAppointmentWithin6Hours(subjectCode);
      _logger.fine('readPlatoAppointmentWithin6Hours: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to readPlatoAppointmentWithin6Hours: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithin12Hours(
      String subjectCode) async {
    try {
      final result =
          await _database.readPlatoAppointmentWithin12Hours(subjectCode);
      _logger.fine('readPlatoAppointmentWithin12Hours: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to readPlatoAppointmentWithin12Hours: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readTodayPlatoAppointment(
      String subjectCode) async {
    try {
      final result = await _database.readTodayPlatoAppointment(subjectCode);
      _logger.fine('readTodayPlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to readTodayPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readTomorrowPlatoAppointment(
      String subjectCode) async {
    try {
      final result = await _database.readTomorrowPlatoAppointment(subjectCode);
      _logger.fine('readTomorrowPlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to readTomorrowPlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentWithinWeek(
      String subjectCode) async {
    try {
      final result =
          await _database.readPlatoAppointmentWithinWeek(subjectCode);
      _logger.fine('readPlatoAppointmentWithinWeek: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to readPlatoAppointmentWithinWeek: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readPlatoAppointmentMoreThanWeek(
      String subjectCode) async {
    try {
      final result =
          await _database.readPlatoAppointmentMoreThanWeek(subjectCode);
      _logger.fine('readPlatoAppointmentMoreThanWeek: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to readPlatoAppointmentMoreThanWeek: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<PlatoAppointment>> readCompletePlatoAppointment(
      String subjectCode) async {
    try {
      final result = await _database.readCompletePlatoAppointment(subjectCode);
      _logger.fine('readCompletePlatoAppointment: ${result.length}');
      return result.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to readCompletePlatoAppointment: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await _database.deleteAll();
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to deleteAllAppointments: $e', stackTrace);
      rethrow;
    }
  }
}
