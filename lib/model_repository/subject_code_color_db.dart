// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/etc/school_data.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class SubjectCodeColorDB {
  static final _logger =
      LoggerManager.getLogger('model_repository - SubjectCodeColorDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield* _dbUpdateStream.stream;
  }

  static final SubjectCodeColorDrift _database = SubjectCodeColorDrift();

  static Future<void> writeAll(List<SubjectCodeColor> subjectCodeColors) async {
    try {
      final schemaList = subjectCodeColors.map((e) => e.toSchema()).toList();
      await _database.writeAll(schemaList);
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to write all subject code colors: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<SubjectCodeColor>> readAllThisSemester() async {
    try {
      final data =
          await _database.readAllThisSemester(year: year, semester: semester);
      return data.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to read all subject code colors: $e', stackTrace);
      rethrow;
    }
  }

  static Future<Map<String, int>> readAll() async {
    try {
      final data = await _database.readAll();
      return {
        for (final item in data.map((e) => e.toModel()))
          item.subjectCode: item.color
      };
    } catch (e, stackTrace) {
      _logger.severe('Failed to read all subject code colors: $e', stackTrace);
      rethrow;
    }
  }
}
