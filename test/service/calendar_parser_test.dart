// Flutter imports:
import 'package:flutter/services.dart' show rootBundle;

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:plato_calendar/service/service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Calendar Parser test', () {
    test('Calendar Parser test: Should parse ics data', () async {
      // 테스트용 ics 파일을 읽어온다.

      List<String> icsFilePathList = [
        'assets/ics/icalexport_test.ics',
      ];

      for (var icsFilePath in icsFilePathList) {
        String fileContent = await rootBundle.loadString(icsFilePath);
        var result = CalendarParser.parse(fileContent);

        expect(result.length, isNot(0));

        for (var appointment in result) {
          expect(appointment.title, isNotEmpty);
          expect(appointment.body, isNotNull);
        }
      }
    });
  });
}
