import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class TaskCheckListDisplayOptionDB {
  static final logger = LoggerManager.getLogger(
      'model repository - TaskCheckListDisplayOptionDB');
  static TaskCheckListOptionDrift database = TaskCheckListOptionDrift();

  static Future<void> write(TaskCheckListDisplayOption data) async {
    try {
      await database.write(data.toSchema());
    } catch (e, stackTrace) {
      logger.severe(
          'Failed to writeTaskCheckListDisplayOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<TaskCheckListDisplayOption> read() async {
    try {
      return await database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        logger.warning('No element found');
        final defaultOption = TaskCheckListDisplayOption();
        await write(defaultOption);
        return defaultOption;
      } else {
        logger.severe('Failed to readTaskCheckListDisplayOption: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to readTaskCheckListDisplayOption: $e', stackTrace);
      rethrow;
    }
  }
}
