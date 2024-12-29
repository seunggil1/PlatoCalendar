import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  late Directory testDirectory;
  late CalendarOption testCalendarOption;

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

    testCalendarOption = CalendarOption(
      showAgenda: true,
    );
  });

  tearDown(() async {
    // 테스트 종료 후 임시 디렉터리 삭제
    // if (await testDirectory.exists()) {
    //   await testDirectory.delete(recursive: true);
    // }
  });

  group('CalendarOptionDB test', () {
    test('write: Should write a calendar option to the database', () async {
      // CalendarOptionDB 생성
      final db = CalendarOptionDB();

      // 데이터베이스 쓰기
      await db.write(testCalendarOption);

      // 데이터 읽기
      final readData = await db.read();

      // 검증
      expect(readData.showFinished, testCalendarOption.showFinished);
      expect(readData.firstDayOfWeek, testCalendarOption.firstDayOfWeek);
      expect(readData.viewType, testCalendarOption.viewType);
      expect(readData.appointmentDisplayMode,
          testCalendarOption.appointmentDisplayMode);
      expect(readData.showAgenda, testCalendarOption.showAgenda);
    });
  });
}
