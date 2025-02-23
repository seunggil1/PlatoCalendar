import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plato_calendar/model/plato_appointment.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/service/service.dart';

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

  test('readAllSubjectCode: Should read all subject code from the database',
      () async {
    // 실행
    final filePath = 'assets/ics/icalexport(0915)_time_error.ics';
    final fileContent = await rootBundle.loadString(filePath);
    final List<PlatoAppointment> result = CalendarParser.parse(fileContent);
    await PlatoAppointmentDB.writeAll(result);
    List<String> data = await PlatoAppointmentDB.readAllSubjectCode();

    // 검증
    expect(data, isNotEmpty);
    expect(data, isA<List<String>>());
  });
  test('writeAppointment: Should write an appointment to the database',
      () async {
    // 실행
    final before = await PlatoAppointmentDB.readAll(showFinished: true);

    final data = testAppointment.copyWith();
    await PlatoAppointmentDB.write(data);

    final after = await PlatoAppointmentDB.readAll(showFinished: true);
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

  test(
      'writeAppointment: Should update an appointment to the database '
      'when the appointment already exists', () async {
    // 실행
    final before = testAppointment.copyWith(uid: 'updateTest');
    final updateData = before.copyWith(finished: !before.finished);

    await PlatoAppointmentDB.write(before);
    await PlatoAppointmentDB.write(updateData);
    final after = await PlatoAppointmentDB.readByUid(before.uid);

    // 검증
    expect(before.uid, after.uid);
    expect(before.title, after.title);
    expect(before.body, after.body);
    expect(before.comment, after.comment);
    expect(before.subjectCode, after.subjectCode);
    expect(before.start.year, after.start.year);
    expect(before.start.month, after.start.month);
    expect(before.start.day, after.start.day);
    expect(before.start.hour, after.start.hour);
    expect(before.start.minute, after.start.minute);
    expect(before.end.year, after.end.year);
    expect(before.end.month, after.end.month);
    expect(before.end.day, after.end.day);
    expect(before.end.hour, after.end.hour);
    expect(before.end.minute, after.end.minute);
    expect(before.createdAt.year, after.createdAt.year);
    expect(before.createdAt.month, after.createdAt.month);
    expect(before.createdAt.day, after.createdAt.day);
    expect(before.createdAt.hour, after.createdAt.hour);
    expect(before.createdAt.minute, after.createdAt.minute);
    expect(before.finished, !after.finished);
    expect(before.status, after.status);
    expect(before.dataType, after.dataType);
  });
}
