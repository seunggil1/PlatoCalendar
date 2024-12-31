import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/service/service.dart';
import 'package:plato_calendar/util/logger.dart';

class PlatoCredentialDB {
  static final logger =
      LoggerManager.getLogger('model repository - PlatoCredentialDB');
  static PlatoCredentialDrift database = PlatoCredentialDrift();

  static Future<void> write(PlatoCredential data) async {
    try {
      String encryptedPassword =
          await PasswordEncryptors.encryptPassword(data.password);
      PlatoCredential encryptedData = PlatoCredential()
        ..username = data.username
        ..password = encryptedPassword;

      await database.write(encryptedData.toSchema());
    } catch (e, stackTrace) {
      logger.severe('Failed to write plato credential: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoCredential> read() async {
    try {
      final queryResult = await database.read();
      PlatoCredential data = queryResult.toModel();

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

  static Future<bool> isEmpty() async {
    try {
      final queryResult = await database.isEmpty();
      return queryResult;
    } catch (e, stackTrace) {
      logger.severe('Failed to check isEmpty : $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await database.deleteAll();
    } catch (e, stackTrace) {
      logger.severe('Failed to deleteAll : $e', stackTrace);
      rethrow;
    }
  }
}
