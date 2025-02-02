import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class GlobalDisplayOptionDB {
  static final logger =
      LoggerManager.getLogger('model repository - GlobalDisplayOptionDB');
  static GlobalOptionDrift database = GlobalOptionDrift();

  static Future<void> write(GlobalDisplayOption data) async {
    try {
      await database.write(data.toSchema());
    } catch (e, stackTrace) {
      logger.severe('Failed to writeGlobalDisplayOption: $e', stackTrace);
      rethrow;
    }
  }

  static Future<GlobalDisplayOption> read() async {
    try {
      return await database.read().then((value) => value.toModel());
    } on StateError catch (e) {
      if (e.message == 'No element') {
        logger.warning('No element found');
        final defaultOption = GlobalDisplayOption();
        await write(defaultOption);
        return defaultOption;
      } else {
        logger.severe('Failed to readGlobalDisplayOption: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to readGlobalDisplayOption: $e', stackTrace);
      rethrow;
    }
  }
}
