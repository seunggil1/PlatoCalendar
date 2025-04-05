// Project imports:
import 'package:plato_calendar/etc/school_data.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class SubjectCodeColorDB {
  static SubjectCodeColorDrift database = SubjectCodeColorDrift();

  static final logger =
      LoggerManager.getLogger('model_repository - SubjectCodeColorDB');

  static Future<void> writeAll(List<SubjectCodeColor> subjectCodeColors) async {
    try {
      final schemaList = subjectCodeColors.map((e) => e.toSchema()).toList();
      await database.writeAll(schemaList);
    } catch (e, stackTrace) {
      logger.severe('Failed to write all subject code colors: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<SubjectCodeColor>> readAllThisSemester() async {
    try {
      final data =
          await database.readAllThisSemester(year: year, semester: semester);
      return data.map((e) => e.toModel()).toList();
    } catch (e, stackTrace) {
      logger.severe('Failed to read all subject code colors: $e', stackTrace);
      rethrow;
    }
  }

  static Future<Map<String, int>> readAll() async {
    try {
      final data = await database.readAll();
      return {
        for (final item in data.map((e) => e.toModel()))
          item.subjectCode: item.color
      };
    } catch (e, stackTrace) {
      logger.severe('Failed to read all subject code colors: $e', stackTrace);
      rethrow;
    }
  }
}
