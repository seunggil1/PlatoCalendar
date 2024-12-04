import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plato_calendar/service/service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel secureStorageChannel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  group('Password encryptors test ', () {
    final mockStorage = <String, String>{};

    // 테스트 전 초기화
    setUp(() {
      // flutter_secure_storage 모의 객체 설정
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        secureStorageChannel,
        (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'write':
              final String key = methodCall.arguments['key'];
              final String value = methodCall.arguments['value'];
              mockStorage[key] = value;
              return null;
            case 'read':
              final String key = methodCall.arguments['key'];
              return mockStorage[key];
            case 'delete':
              final String key = methodCall.arguments['key'];
              mockStorage.remove(key);
              return null;
            case 'containsKey':
              final String key = methodCall.arguments['key'];
              return mockStorage.containsKey(key);
            case 'clear':
              mockStorage.clear();
              return null;
            default:
              return null;
          }
        },
      );
    });

    // 테스트 후 정리
    tearDown(() {});

    test('Password encryptors test: Should encrypt and decrypt password',
        () async {
      // 실행
      const testPassword = 'test_password';

      final encryptedPassword =
          await PasswordEncryptors.encryptPassword(testPassword);
      final decryptedPassword =
          await PasswordEncryptors.decryptPassword(encryptedPassword);

      expect(testPassword, decryptedPassword);
    });
  });
}
