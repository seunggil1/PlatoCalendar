import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:plato_calendar/service/service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Calendar Parser test', () {
    test('Calendar Parser test: Should parse ics data', () async {
      // 테스트용 ics 파일을 읽어온다.
      String fileContent =
          await rootBundle.loadString('assets/ics/icalexport2.ics');
      var result = CalendarParser.parse(fileContent);

      expect(result.length, 40);

      for (var appointment in result) {
        expect(appointment.title, isNotEmpty);
        expect(appointment.body, isNotNull);
      }
    });
  });
}
