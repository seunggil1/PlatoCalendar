import 'package:isar/isar.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/service/service.dart';
import 'package:plato_calendar/util/logger.dart';

import './_isar_interface.dart';

class PlatoCredentialDB {
  static Isar? _isar;
  static final logger =
      LoggerManager.getLogger('model repository - PlatoCredentialDB');

  static Future<Isar> _initIsar() async {
    Isar dbInstance = await IsarInterface().initIsar(PlatoCredentialSchema);
    _isar = dbInstance;
    return dbInstance;
  }

  static Future<void> write(PlatoCredential data) async {
    Isar db = _isar ?? await _initIsar();

    String encryptedPassword =
        await PasswordEncryptors.encryptPassword(data.password);
    PlatoCredential encryptedData = PlatoCredential()
      ..username = data.username
      ..password = encryptedPassword;

    try {
      await db.writeTxn(() async {
        await db.platoCredentials.put(encryptedData);
      });

      logger.fine('Write plato credential: ${data.username}');
    } catch (e, stackTrace) {
      logger.severe('Failed to write plato credential: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoCredential> read() async {
    try {
      Isar db = _isar ?? await _initIsar();
      final queryResult = await db.platoCredentials.where().sortByDbTimestampDesc().findFirst();
      PlatoCredential data = queryResult!;

      String plainPassword =
          await PasswordEncryptors.decryptPassword(data.password);

      PlatoCredential result = PlatoCredential()
        ..username = data.username
        ..password = plainPassword;

      logger.fine('Read plato credential: ${result.id}');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to read plato credential: $e', stackTrace);
      rethrow;
    }
  }

  static Future<bool> isEmpty() async{
    try {
      Isar db = _isar ?? await _initIsar();
      final result = await db.platoCredentials.where().isEmpty();

      logger.fine('isEmpty : $result');
      return result;
    } catch (e, stackTrace) {
      logger.severe('Failed to check isEmpty : $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> delete(PlatoCredential data) async {
    Isar db = _isar ?? await _initIsar();

    try {
      await db.writeTxn(() async {
        await db.platoCredentials.delete(data.id);
      });

      logger.fine('Write plato credential: ${data.username}');
    } catch (e, stackTrace) {
      logger.severe('Failed to write plato credential: $e', stackTrace);
      rethrow;
    }
  }
}
