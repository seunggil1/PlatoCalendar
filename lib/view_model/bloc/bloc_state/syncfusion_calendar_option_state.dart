import 'package:plato_calendar/model/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final class SyncfusionCalendarOptionState {
  late CalendarController calendarController;
  late final CalendarOption calendarOption;

  SyncfusionCalendarOptionState(CalendarOption option) {
    calendarOption = option;
    calendarController = CalendarController()
      ..view = option.viewType
      ..displayDate = DateTime.now()
      ..selectedDate = DateTime.now();
  }
}
