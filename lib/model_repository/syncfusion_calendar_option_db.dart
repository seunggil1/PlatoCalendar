// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class SyncfusionCalendarOptionDB {
  static final _logger =
      LoggerManager.getLogger('model_repository - SyncfusionCalendarOptionDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield* _dbUpdateStream.stream;
  }

  static final SyncfusionCalendarOptionDrift _database =
      SyncfusionCalendarOptionDrift();

  static Future<void> write(SyncfusionCalendarOption data) async {
    try {
      await _database.replace(data.toSchema());
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to writeCalendarOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<SyncfusionCalendarOption> read() async {
    try {
      return await _database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        _logger.warning('No element found');
        final defaultOption = SyncfusionCalendarOption();
        await write(defaultOption);
        return defaultOption;
      } else {
        _logger.severe('Failed to readGlobalDisplayOption: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to readCalendarOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<bool> isEmpty() async {
    try {
      return await _database.isEmpty();
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to check if calendarOption is empty: $e', stackTrace);
      rethrow;
    }
  }

  static Future<int> count() async {
    try {
      return await _database.count();
    } catch (e, stackTrace) {
      _logger.severe('Failed to count calendarOption: $e', stackTrace);
      rethrow;
    }
  }
}
