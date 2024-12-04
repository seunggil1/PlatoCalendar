import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:plato_calendar/model/model.dart';

final class CalendarOptionState {
  late CalendarController calendarController;
  late CalendarOption calendarOption;

  CalendarOptionState(CalendarOption option) {
    calendarOption = option;
    calendarController = CalendarController()
      ..view = option.viewType
      ..displayDate = DateTime.now();
  }
}
