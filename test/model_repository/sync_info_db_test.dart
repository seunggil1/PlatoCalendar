// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  late Directory testDirectory;
  late SyncInfo syncInfo;

  setUp(() async {
    // 임시 디렉터리 생성
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

    syncInfo = SyncInfo()..platoSyncTime = DateTime.now();
  });

  group('SyncInfoDB test', () {
    test('read : read SyncInfo from empty database', () async {
      // 데이터 읽기
      try {
        await SyncInfoDB.read();
      } on StateError catch (e) {
        if (e.message == 'No element') {
          return;
        } else {
          rethrow;
        }
      } catch (e) {
        rethrow;
      }
    });

    test('write: Should write a sync info to the database', () async {
      // 데이터베이스 쓰기
      await SyncInfoDB.write(syncInfo);
    });

    test('read, write: Should write and read sync info to the database',
        () async {
      // 데이터베이스 쓰기
      await SyncInfoDB.write(syncInfo);

      // 데이터베이스 읽기
      SyncInfo? readSyncInfo = await SyncInfoDB.read();

      // 업데이트 확인
      expect(readSyncInfo!.platoSyncTime.year, syncInfo.platoSyncTime.year);
      expect(readSyncInfo.platoSyncTime.month, syncInfo.platoSyncTime.month);
      expect(readSyncInfo.platoSyncTime.day, syncInfo.platoSyncTime.day);
      expect(readSyncInfo.platoSyncTime.hour, syncInfo.platoSyncTime.hour);
      expect(readSyncInfo.platoSyncTime.minute, syncInfo.platoSyncTime.minute);
      expect(readSyncInfo.platoSyncTime.second, syncInfo.platoSyncTime.second);
    });
  });
}
