import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plato_calendar/model/plato_appointment.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');

  late Directory testDirectory;
  late PlatoAppointment testAppointment;

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

    testAppointment = PlatoAppointment()
      ..uid = 'test'
      ..title = 'test'
      ..body = 'test'
      ..comment = 'test_comment'
      ..subjectCode = 'test_subjectCode'
      ..start = DateTime.now()
      ..end = DateTime.now()
      ..finished = false
      ..year = '2024'
      ..semester = '10';
  });

  test('writeAppointment: Should write an appointment to the database',
      () async {
    // 실행
    final before = await PlatoAppointmentDB.readAll();

    final data = testAppointment.copyWith();
    await PlatoAppointmentDB.write(data);

    final after = await PlatoAppointmentDB.readAll();
    expect(before.length + 1, after.length);

    final readData = after.last;
    // 검증
    expect(data.uid, readData.uid);
    expect(data.title, readData.title);
    expect(data.body, readData.body);
    expect(data.comment, readData.comment);
    expect(data.subjectCode, readData.subjectCode);
    expect(data.start.year, readData.start.year);
    expect(data.start.month, readData.start.month);
    expect(data.start.day, readData.start.day);
    expect(data.start.hour, readData.start.hour);
    expect(data.start.minute, readData.start.minute);
    expect(data.end.year, readData.end.year);
    expect(data.end.month, readData.end.month);
    expect(data.end.day, readData.end.day);
    expect(data.end.hour, readData.end.hour);
    expect(data.end.minute, readData.end.minute);
    expect(data.createdAt.year, readData.createdAt.year);
    expect(data.createdAt.month, readData.createdAt.month);
    expect(data.createdAt.day, readData.createdAt.day);
    expect(data.createdAt.hour, readData.createdAt.hour);
    expect(data.createdAt.minute, readData.createdAt.minute);
    expect(data.finished, readData.finished);
    expect(data.status, readData.status);
    expect(data.dataType, readData.dataType);
  });
}
