// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
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
  late GlobalDisplayOption testGlobalDisplayOption;

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

    testGlobalDisplayOption = GlobalDisplayOption()
      ..tapIndex = 0
      ..themeMode = ThemeMode.system
      ..themeSeedColorIndex = 1;
  });

  group('CalendarOptionDB test', () {
    test('read : read GlobalDisplayOption from empty database', () async {
      // 데이터 읽기
      try {
        await GlobalDisplayOptionDB.read();
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

    test('write: Should write a global display option to the database',
        () async {
      // CalendarOptionDB 생성

      // 데이터베이스 쓰기
      await GlobalDisplayOptionDB.write(testGlobalDisplayOption);

      // 데이터 읽기
      final readData = await GlobalDisplayOptionDB.read();

      // 검증
      expect(readData.tapIndex, testGlobalDisplayOption.tapIndex);
      expect(readData.themeMode, testGlobalDisplayOption.themeMode);
      expect(readData.themeSeedColorIndex,
          testGlobalDisplayOption.themeSeedColorIndex);
    });
  });
}
