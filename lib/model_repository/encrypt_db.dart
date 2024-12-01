import 'dart:math';
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:plato_calendar/util/logger.dart';

class EncryptDBException implements Exception {
  final String message;

  EncryptDBException(this.message);
}

class EncryptDB {
  static final logger = LoggerManager.getLogger('EncryptDB');

  static final storage = FlutterSecureStorage();
  static final options =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  static final secureStorageKey = 'encryption_key';

  static Future<bool> hasEncryptionKey() async {
    return await storage.containsKey(key: secureStorageKey, iOptions: options);
  }

  static Future<void> saveEncryptionKey(String key) async {
    if (await EncryptDB.hasEncryptionKey()) {
      logger.severe('Encryption key already exists');
      throw EncryptDBException('Encryption key already exists');
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
      return (await storage.read(key: 'encryption_key', iOptions: options))!;
    } catch (e, stackTrace) {
      logger.severe('Failed to get encryption key: $e', stackTrace);
      rethrow;
    }
  }

  static String generateRandomKey(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64UrlEncode(values); // Base64로 인코딩
  }

  static Future<String> encryptPassword(String plainText) async {
    if (await EncryptDB.hasEncryptionKey() == false) {
      logger.info('Encryption key does not exist');

      String encryptionKey = EncryptDB.generateRandomKey(32);
      await EncryptDB.saveEncryptionKey(encryptionKey);
    }

    final key = await EncryptDB.getEncryptionKey();

    final keyBytes = encrypt.Key.fromUtf8(key.padRight(32));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));
    return encrypter.encrypt(plainText, iv: iv).base64;
  }

  static Future<String> decryptPassword(String encryptedText) async {
    final key = await EncryptDB.getEncryptionKey();

    final keyBytes = encrypt.Key.fromUtf8(key.padRight(32));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));
    return encrypter.decrypt64(encryptedText, iv: iv);
  }
}
