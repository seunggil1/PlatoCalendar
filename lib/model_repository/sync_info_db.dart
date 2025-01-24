import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class SyncInfoDB {
  static final logger =
      LoggerManager.getLogger('model repository - SyncInfoDB');
  static SyncInfoDrift database = SyncInfoDrift();

  static Future<void> write(SyncInfo data) async {
    try {
      await database.write(data.toSchema());
    } catch (e, stackTrace) {
      logger.severe('Failed to writeSyncInfo: $e', stackTrace);
      rethrow;
    }
  }

  static Future<SyncInfo> read() async {
    try {
      return await database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        logger.warning('No element found');
        rethrow;
      } else {
        logger.severe('Failed to readSyncInfo: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to readSyncInfo: $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await database.deleteAll();
    } catch (e, stackTrace) {
      logger.severe('Failed to deleteAllSyncInfo: $e', stackTrace);
      rethrow;
    }
  }
}
