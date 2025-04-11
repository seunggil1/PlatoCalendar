// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class GlobalDisplayOptionDB {
  static final _logger =
      LoggerManager.getLogger('model repository - GlobalDisplayOptionDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield true;
    yield* _dbUpdateStream.stream;
  }

  static final GlobalOptionDrift _database = GlobalOptionDrift();

  static Future<void> write(GlobalDisplayOption data) async {
    try {
      await _database.write(data.toSchema());
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to writeGlobalDisplayOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<GlobalDisplayOption> read() async {
    try {
      return await _database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        _logger.warning('No element found');
        final defaultOption = GlobalDisplayOption();
        await write(defaultOption);
        return defaultOption;
      } else {
        _logger.severe('Failed to readGlobalDisplayOption: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to readGlobalDisplayOption: $e', stackTrace);
      rethrow;
    }
  }
}
