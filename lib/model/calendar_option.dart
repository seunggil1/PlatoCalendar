import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'calendar_option.g.dart';

// enum SortMethod { sortByDue, sortByRegister }

enum CalendarType { split, integrated }

@collection
class CalendarOption {
  Id id = Isar.autoIncrement;

  late bool showFinished;
  int firstDayOfWeek = 7;

  @Enumerated(EnumType.name)
  late CalendarType calendarType; // MonthViewSettings - showAgenda

  @Enumerated(EnumType.name)
  CalendarView viewType = CalendarView.month;

  @Enumerated(EnumType.name)
  MonthAppointmentDisplayMode appointmentDisplayMode = MonthAppointmentDisplayMode.appointment;

  @Index()
  DateTime dbTimestamp = DateTime.now();

  // syncfusion_flutter_calendar 에서 사용 하는 형태로 변경
  MonthViewSettings getMonthViewSettings() => MonthViewSettings(
    appointmentDisplayCount: 4,
    appointmentDisplayMode: appointmentDisplayMode,
    monthCellStyle: MonthCellStyle(),
    showAgenda: calendarType == CalendarType.integrated ? true : false,
  );
}
