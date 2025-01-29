import 'package:plato_calendar/model/model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final class SyncfusionCalendarOptionState {
  final CalendarOption calendarOption;

  CalendarController calendarController;

  SyncfusionCalendarOptionState(CalendarOption option,
      {CalendarView? calendarView, DateTime? displayDate})
      : calendarOption = option,
        calendarController = CalendarController()
          ..view = calendarView ?? CalendarView.month
          ..displayDate = displayDate ?? DateTime.now()
          ..selectedDate = DateTime.now();

  bool calendarViewTypeIsSchedule() {
    return calendarController.view == CalendarView.schedule;
  }

  bool calendarViewTypeIsMonth() {
    return calendarController.view == CalendarView.month;
  }
}
