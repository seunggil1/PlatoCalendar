import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plato_calendar/util/logger.dart';

class PasswordEncryptors {
  static final logger = LoggerManager.getLogger(
      'model repository - EncryptDB(PasswordEncryptors)');

  static Future<String> encryptPassword(String plainText) async {
    try {
      // 암호화 키가 없으면, 새로 생성
      if (await _EncryptKeyDB.hasEncryptionKey() == false) {
        logger.info('Encryption key does not exist');

        String encryptionKey = _generateRandomKey(32);
        await _EncryptKeyDB.saveEncryptionKey(encryptionKey);
      }

      // 암호화 키를 SECURE_STORAGE 에서 가져와서, 비밀번호 암호화
      final key = await _EncryptKeyDB.getEncryptionKey();

      final keyBytes = encrypt.Key.fromUtf8(key.padRight(32));
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));

      return encrypter.encrypt(plainText, iv: iv).base64;
    } catch (e, stackTrace) {
      logger.severe('Failed to encrypt password: $e', stackTrace);
      rethrow;
    }
  }

  static Future<String> decryptPassword(String encryptedText) async {
    try {
      final key = await _EncryptKeyDB.getEncryptionKey();

      final keyBytes = encrypt.Key.fromUtf8(key.padRight(32));
      final iv = encrypt.IV.fromLength(16);
      final encryptor = encrypt.Encrypter(encrypt.AES(keyBytes));

      return encryptor.decrypt64(encryptedText, iv: iv);
    } catch (e, stackTrace) {
      logger.severe('Failed to decrypt password: $e', stackTrace);
      rethrow;
    }
  }

  static String _generateRandomKey(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64UrlEncode(values); // Base64로 인코딩
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

  static Future<void> saveEncryptionKey(String key) async {
    if (await _EncryptKeyDB.hasEncryptionKey()) {
      const msg = 'Encryption key already exists';
      logger.severe(msg);
      throw EncryptDBException(msg);
    } else {
      logger.info('Save encryption key');

      try {
        await storage.write(
            key: 'encryption_key', value: key, iOptions: options);
      } catch (e, stackTrace) {
        logger.severe('Failed to save encryption key: $e', stackTrace);
        rethrow;
      }
    }
  }

  static Future<String> getEncryptionKey() async {
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
          return key;
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
