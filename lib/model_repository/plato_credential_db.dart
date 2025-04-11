// Dart imports:
import 'dart:async';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/service/service.dart';
import 'package:plato_calendar/util/logger.dart';

class PlatoCredentialDB {
  static final _logger =
      LoggerManager.getLogger('model repository - PlatoCredentialDB');

  static final _dbUpdateStream = StreamController<bool>.broadcast();
  static Stream<bool> get dbUpdatedStream async* {
    yield true;
    yield* _dbUpdateStream.stream;
  }

  static final PlatoCredentialDrift _database = PlatoCredentialDrift();

  static Future<void> write(PlatoCredential data) async {
    try {
      String encryptedPassword =
          await PasswordEncryptors.encryptPassword(data.password);
      PlatoCredential encryptedData = PlatoCredential()
        ..username = data.username
        ..password = encryptedPassword;

      await _database.write(encryptedData.toSchema());
      _dbUpdateStream.add(true);
    } catch (e, stackTrace) {
      _logger.severe('Failed to write plato credential: $e', stackTrace);
      rethrow;
    }
  }

  static Future<PlatoCredential?> read() async {
    try {
      final queryResult = await _database.read();
      PlatoCredential data = queryResult.toModel();

      String plainPassword =
          await PasswordEncryptors.decryptPassword(data.password);

      PlatoCredential result = PlatoCredential()
        ..username = data.username
        ..password = plainPassword;

      _logger.fine('Read plato credential: ${result.id}');
      return result;
    } on StateError catch (e) {
      if (e.message == 'No element') {
        _logger.warning('No element found');
        return null;
      } else {
        _logger.severe('Failed to readSyncInfo: $e');
        rethrow;
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to read plato credential: $e', stackTrace);
      rethrow;
    }
  }

  static Future<bool> isEmpty() async {
    try {
      final queryResult = await _database.isEmpty();
      return queryResult;
    } catch (e, stackTrace) {
      _logger.severe('Failed to check isEmpty : $e', stackTrace);
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await _database.deleteAll();
    } catch (e, stackTrace) {
      _logger.severe('Failed to deleteAll : $e', stackTrace);
      rethrow;
    }
  }
}
