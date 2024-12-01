import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:plato_calendar/repository/appointment_db.dart';
import 'package:plato_calendar/model/appointment.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');

  late Appointment testAppointment;

  group('AppointmentDB Test', () {
    // 테스트 전 초기화
    setUp(() {
      // windows 환경에서 테스트할 수 있게, getApplicationDocumentsDirectory 대체
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return Directory.current.createTempSync('test_documents').path;
          }
          return null;
        },
      );

      testAppointment = Appointment()
        ..uuid = 'test'
        ..title = 'test'
        ..body = 'test'
        ..comment = 'test_comment'
        ..subjectCode = 'test_subjectCode'
        ..start = DateTime.now()
        ..end = DateTime.now()
        ..deletedAt = DateTime.now();
    });

    // 테스트 후 정리
    tearDown(() async {
      // Mock 핸들러 해제
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('writeAppointment: Should write an appointment to the database',
        () async {
      // 실행
      final data = testAppointment.copyWith();
      await AppointmentDB.writeAppointment(data);

      final readData = await AppointmentDB.getAppointmentById(data.id);

      // 검증
      expect(data.uuid, readData.uuid);
      expect(data.title, readData.title);
      expect(data.body, readData.body);
      expect(data.comment, readData.comment);
      expect(data.subjectCode, readData.subjectCode);
      expect(data.start, readData.start);
      expect(data.end, readData.end);
      expect(data.createdAt, readData.createdAt);
      expect(data.deletedAt, readData.deletedAt);
      expect(data.status, readData.status);
      expect(data.dataType, readData.dataType);

      await AppointmentDB.deleteAppointmentById(data.id);
    });

    test('readAllAppointment: Should return all appointments from the database',
        () async {
      // 데이터 미리 추가
      final data = testAppointment.copyWith();

      final prevAppointments = await AppointmentDB.readAllAppointment();
      await AppointmentDB.writeAppointment(data);

      // 실행
      final afterAppointments = await AppointmentDB.readAllAppointment();

      // 검증
      expect(prevAppointments.length + 1, afterAppointments.length);

      await AppointmentDB.deleteAppointmentById(data.id);
    });
  });
}
