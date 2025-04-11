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
  late TaskCheckListDisplayOption taskCheckListDisplayOption;

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

    taskCheckListDisplayOption = TaskCheckListDisplayOption()
      ..showToDoList = [true, true, false, true, true, false, true, false];
  });

  group('TaskCheckListDisplayOptionDB test', () {
    test('read : read TaskCheckListDisplayOption from empty database',
        () async {
      // 데이터 읽기
      try {
        await TaskCheckListDisplayOptionDB.read();
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

    test('write: Should write a task check list display option to the database',
        () async {
      // 데이터베이스 쓰기
      await TaskCheckListDisplayOptionDB.write(taskCheckListDisplayOption);
    });

    test(
        'read, write: Should write and read task check list display option to the database',
        () async {
      // 데이터베이스 쓰기
      await TaskCheckListDisplayOptionDB.write(taskCheckListDisplayOption);

      // 데이터 읽기
      final readTaskCheckListDisplayOption =
          await TaskCheckListDisplayOptionDB.read();
      expect(taskCheckListDisplayOption.showToDoList.length, 8);
      expect(readTaskCheckListDisplayOption.showToDoList,
          taskCheckListDisplayOption.showToDoList);
    });
  });
}
