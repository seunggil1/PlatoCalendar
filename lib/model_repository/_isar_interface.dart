import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:plato_calendar/util/logger.dart';

class IsarInterface{
  final logger = LoggerManager.getLogger('IsarInterface');

  Future<Isar> initIsar(CollectionSchema schema) async {
    try {
      logger.fine('_initIsar() called');

      final dir = await getApplicationDocumentsDirectory();
      logger.fine('Database directory: ${dir.path}');
      Isar dbInstance = await Isar.open(
        [schema],
        directory: dir.path,
      );

      logger.fine('Isar is initialized');

      return dbInstance;
    } catch (e, stackTrace) {
      logger.severe('Failed to initialize Isar: $e', stackTrace);
      rethrow;
    }
  }
}