import 'package:plato_calendar/model/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final class CalendarOptionState {
  late CalendarController calendarController;
  late final CalendarOption calendarOption;

  CalendarOptionState(CalendarOption option) {
    calendarOption = option;
    calendarController = CalendarController()
      ..view = option.viewType
      ..displayDate = DateTime.now();
  }
}
