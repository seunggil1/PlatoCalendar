import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
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
    test('read : read CalendarOption from empty database', () async {
      // 데이터 읽기
      try{
        await CalendarOptionDB.read();
      }on StateError catch (e){
        if(e.message == 'No element'){
          return;
        }else{
          rethrow;
        }
      } catch (e) {
        rethrow;
      }
    });

    test('write: Should write a calendar option to the database', () async {
      // CalendarOptionDB 생성

      // 데이터베이스 쓰기
      await CalendarOptionDB.write(testCalendarOption);

      // 데이터 읽기
      final readData = await CalendarOptionDB.read();

      // 검증
      expect(readData.showFinished, testCalendarOption.showFinished);
      expect(readData.firstDayOfWeek, testCalendarOption.firstDayOfWeek);
      expect(readData.viewType, testCalendarOption.viewType);
      expect(readData.showAgenda, testCalendarOption.showAgenda);
    });
  });
}
