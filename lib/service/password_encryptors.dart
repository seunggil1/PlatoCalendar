// Dart imports:
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

class PasswordEncryptors {
  static final logger = LoggerManager.getLogger(
      'model repository - EncryptDB(PasswordEncryptors)');

  static Future<String> encryptPassword(String plainText) async {
    try {
      // 암호화 키가 없으면, 새로 생성
      if (await _EncryptKeyDB.hasEncryptionKey() == false) {
        logger.info('Encryption key does not exist');

        final EncryptKey base64Key = _generateRandomKey(32);
        await _EncryptKeyDB.saveEncryptionKey(base64Key);
      }

      // 암호화 키를 SECURE_STORAGE 에서 가져와서, 비밀번호 암호화
      final EncryptKey key = await _EncryptKeyDB.getEncryptionKey();
      final encryptor = Encrypter(AES(key.key));

      return encryptor.encrypt(plainText, iv: key.iv).base64;
    } catch (e, stackTrace) {
      logger.severe('Failed to encrypt password: $e', stackTrace);
      rethrow;
    }
  }

  static Future<String> decryptPassword(String encryptedText) async {
    try {
      final EncryptKey key = await _EncryptKeyDB.getEncryptionKey();
      final encryptor = Encrypter(AES(key.key));

      return encryptor.decrypt64(encryptedText, iv: key.iv);
    } catch (e, stackTrace) {
      logger.severe('Failed to decrypt password: $e', stackTrace);
      rethrow;
    }
  }

  static EncryptKey _generateRandomKey(int length) {
    // 허용되는 AES 키 길이 확인
    if (length != 16 && length != 24 && length != 32) {
      throw ArgumentError('Key length must be 16, 24, or 32 bytes for AES.');
    }

    final Random random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    final key = Key(Uint8List.fromList(values));
    final iv = IV.fromSecureRandom(16);

    return EncryptKey(key, iv);
  }
}

class EncryptDBException implements Exception {
  final String message;

  EncryptDBException(this.message);
}

class _EncryptKeyDB {
  static final logger = LoggerManager.getLogger('model repository - EncryptDB');

  static final storage = FlutterSecureStorage();
  static final options =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  static final secureStorageKey = 'encryption_key';

  static Future<void> saveEncryptionKey(EncryptKey key) async {
    if (await _EncryptKeyDB.hasEncryptionKey()) {
      const msg = 'Encryption key already exists';
      logger.severe(msg);
      throw EncryptDBException(msg);
    } else {
      logger.info('Save encryption key');

      try {
        await storage.write(
            key: 'encryption_key', value: key.toString(), iOptions: options);
      } catch (e, stackTrace) {
        logger.severe('Failed to save encryption key: $e', stackTrace);
        rethrow;
      }
    }
  }

  static Future<EncryptKey> getEncryptionKey() async {
    logger.info('Get encryption key');
    try {
      if ((await _EncryptKeyDB.hasEncryptionKey()) == false) {
        const msg = 'Encryption key does not exist';
        logger.severe(msg);
        throw EncryptDBException(msg);
      } else {
        String? key =
            (await storage.read(key: secureStorageKey, iOptions: options));
        if (key == null) {
          const msg = 'Encryption key is null';
          logger.severe(msg);
          throw EncryptDBException(msg);
        } else {
          return EncryptKey.fromString(key);
        }
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to get encryption key: $e', stackTrace);
      rethrow;
    }
  }

  static Future<bool> hasEncryptionKey() async {
    return await storage.containsKey(key: secureStorageKey, iOptions: options);
  }

  static Future<void> deleteEncryptionKey() async {
    logger.info('Delete encryption key');
    try {
      await storage.delete(key: secureStorageKey, iOptions: options);
    } catch (e, stackTrace) {
      logger.severe('Failed to delete encryption key: $e', stackTrace);
      rethrow;
    }
  }
}
