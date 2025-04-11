// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class TaskCheckListDisplayOptionDB {
  static final _logger = LoggerManager.getLogger(
      'model repository - TaskCheckListDisplayOptionDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield* _dbUpdateStream.stream;
  }

  static final TaskCheckListOptionDrift _database = TaskCheckListOptionDrift();

  static Future<void> write(TaskCheckListDisplayOption data) async {
    try {
      await _database.write(data.toSchema());
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to writeTaskCheckListDisplayOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<TaskCheckListDisplayOption> read() async {
    try {
      return await _database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        _logger.warning('No element found');
        final defaultOption = TaskCheckListDisplayOption();
        await write(defaultOption);
        return defaultOption;
      } else {
        _logger.severe('Failed to readTaskCheckListDisplayOption: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to readTaskCheckListDisplayOption: $e', stackTrace);
      rethrow;
    }
  }
}
