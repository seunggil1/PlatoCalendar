import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'calendar_option.g.dart';

// enum SortMethod { sortByDue, sortByRegister }

@collection
class CalendarOption {
  CalendarOption();

  Id id = Isar.autoIncrement;

  bool showFinished = true;
  int firstDayOfWeek = 7;

  @Enumerated(EnumType.name)
  CalendarView viewType = CalendarView.month;

  @Enumerated(EnumType.name)
  MonthAppointmentDisplayMode appointmentDisplayMode =
      MonthAppointmentDisplayMode.appointment;

  @Enumerated(EnumType.name)
  bool showAgenda = true; // For MonthViewSettings

  @Index()
  DateTime dbTimestamp = DateTime.now();

  bool calendarViewTypeIsMonth() => viewType == CalendarView.month;

  bool calendarViewTypeIsSchedule() => viewType == CalendarView.schedule;

  bool monthAppointmentDisplayModeIsAppointment() =>
      appointmentDisplayMode == MonthAppointmentDisplayMode.appointment;

  bool monthAppointmentDisplayModeIsIndicator() =>
      appointmentDisplayMode == MonthAppointmentDisplayMode.indicator;

  // syncfusion_flutter_calendar 에서 사용 하는 형태로 변경
  MonthViewSettings getMonthViewSettings() => MonthViewSettings(
        appointmentDisplayCount: 4,
        appointmentDisplayMode: appointmentDisplayMode,
        monthCellStyle: MonthCellStyle(),
        showAgenda: showAgenda,
      );

  CalendarOption copyWith(
      {bool? showFinished,
      int? firstDayOfWeek,
      CalendarView? viewType,
      MonthAppointmentDisplayMode? appointmentDisplayMode,
      bool? showAgenda}) {
    return CalendarOption()
      ..showFinished = showFinished ?? this.showFinished
      ..firstDayOfWeek = firstDayOfWeek ?? this.firstDayOfWeek
      ..viewType = viewType ?? this.viewType
      ..appointmentDisplayMode =
          appointmentDisplayMode ?? this.appointmentDisplayMode
      ..showAgenda = showAgenda ?? this.showAgenda;
  }
}
