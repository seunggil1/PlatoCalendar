// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class SyncInfoDB {
  static final _logger =
      LoggerManager.getLogger('model repository - SyncInfoDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield* _dbUpdateStream.stream;
  }

  static final SyncInfoDrift _database = SyncInfoDrift();

  static Future<void> write(SyncInfo data) async {
    try {
      await _database.write(data.toSchema());
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to writeSyncInfo: $e', stackTrace);
      rethrow;
    }
  }

  static Future<SyncInfo?> read() async {
    try {
      return await _database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        _logger.warning('No element found');
        return null;
      } else {
        _logger.severe('Failed to readSyncInfo: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to readSyncInfo: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await _database.deleteAll();
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to deleteAllSyncInfo: $e', stackTrace);
      rethrow;
    }
  }
}
