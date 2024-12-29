import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plato_calendar/model/plato_credential.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  const MethodChannel secureStorageChannel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  late Directory testDirectory;
  late PlatoCredential testPlatoCredential;

  group('Plato AppointmentDB Test', () {
    final mockStorage = <String, String>{};

    // 테스트 전 초기화
    setUp(() async {
      // windows 환경에서 테스트할 수 있게, getApplicationDocumentsDirectory 대체
      testDirectory = await Directory.systemTemp.createTemp('test_documents');

      // path_provider 모킹
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return testDirectory.path;
          } else if (methodCall.method == 'getTemporaryDirectory') {
            return testDirectory.path;
          }
          return null;
        },
      );
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

      testPlatoCredential = PlatoCredential()
        ..username = 'test_user'
        ..password = 'test_password';
    });

    // 테스트 후 정리
    tearDown(() async {
      // Mock 핸들러 해제
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('Plato CredentialDB Test: Should write and read PlatoCredential data',
        () async {
      // 실행
      await PlatoCredentialDB.write(testPlatoCredential);

      final readData = await PlatoCredentialDB.read();

      expect(testPlatoCredential.username, readData.username);
      expect(testPlatoCredential.password, readData.password);
    });
  });
}
