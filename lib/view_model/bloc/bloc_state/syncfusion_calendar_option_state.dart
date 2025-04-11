// Package imports:
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';

final class SyncfusionCalendarOptionState {
  final SyncfusionCalendarOption calendarOption;

  CalendarController calendarController;

  SyncfusionCalendarOptionState(SyncfusionCalendarOption option,
      {CalendarController? calendarController,
      CalendarView? calendarView,
      DateTime? displayDate})
      : calendarOption = option,
        calendarController = calendarController ?? CalendarController() {
    this.calendarController.view = calendarView ?? CalendarView.month;
    this.calendarController.displayDate = displayDate ?? DateTime.now();
    this.calendarController.selectedDate = displayDate ?? DateTime.now();
  }

  bool calendarViewTypeIsSchedule() {
    return calendarController.view == CalendarView.schedule;
  }

  bool calendarViewTypeIsMonth() {
    return calendarController.view == CalendarView.month;
  }
}
