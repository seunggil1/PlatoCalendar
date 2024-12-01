import 'package:isar/isar.dart';

import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

import 'package:plato_calendar/model_repository/_isar_interface.dart';
import 'package:plato_calendar/model_repository/encrypt_db.dart';

class PlatoCredentialDB {
  static Isar? _isar;
  static final logger = LoggerManager.getLogger('PlatoCredentialDB');

  static Future<Isar> _initIsar() async {
    Isar dbInstance = await IsarInterface().initIsar(PlatoCredentialSchema);
    _isar = dbInstance;
    return dbInstance;
  }

  static Future<void> write(PlatoCredential data) async {
    Isar db = _isar ?? await _initIsar();

    String encryptedPassword = await EncryptDB.encryptPassword(data.password);
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
      final queryResult = await db.platoCredentials.where().findAll();
      PlatoCredential data = queryResult.first;

      String plainPassword = await EncryptDB.decryptPassword(data.password);

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
}
