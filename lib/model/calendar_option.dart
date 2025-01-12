import 'package:drift/drift.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'table/table.dart';

class CalendarOption {
  final int? id;
  final bool showFinished;
  final int firstDayOfWeek;
  final CalendarView viewType;

  // final MonthAppointmentDisplayMode appointmentDisplayMode;
  final bool showAgenda;
  final DateTime dbTimestamp;

  CalendarOption({
    this.id,
    this.showFinished = true,
    this.firstDayOfWeek = 7,
    this.viewType = CalendarView.month,
    // this.appointmentDisplayMode = MonthAppointmentDisplayMode.appointment,
    this.showAgenda = true,
    DateTime? dbTimestamp,
  }) : dbTimestamp = dbTimestamp ?? DateTime.now();

  CalendarOption copyWith({
    bool? showFinished,
    int? firstDayOfWeek,
    CalendarView? viewType,
    bool? showAgenda,
    DateTime? dbTimestamp,
  }) {
    return CalendarOption(
      showFinished: showFinished ?? this.showFinished,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      viewType: viewType ?? this.viewType,
      showAgenda: showAgenda ?? this.showAgenda,
      dbTimestamp: dbTimestamp ?? this.dbTimestamp,
    );
  }

  bool calendarViewTypeIsSchedule() {
    return viewType == CalendarView.schedule;
  }

  bool calendarViewTypeIsMonth() {
    return viewType == CalendarView.month;
  }

  // syncfusion_flutter_calendar 에서 사용 하는 형태로 변경
  MonthViewSettings getMonthViewSettings() => MonthViewSettings(
        appointmentDisplayCount: 4,
        appointmentDisplayMode: showAgenda
            ? MonthAppointmentDisplayMode.indicator
            : MonthAppointmentDisplayMode.appointment,
        monthCellStyle: MonthCellStyle(),
        showAgenda: showAgenda,
      );

  @override
  String toString() =>
      'CalendarOption(id: $id, showFinished: $showFinished, firstDayOfWeek: $firstDayOfWeek, '
      'viewType: $viewType, '
      'showAgenda: $showAgenda, dbTimestamp: $dbTimestamp)';
}

extension CalendarOptionMapper on CalendarOption {
  /// CalendarOption -> CalendarOptionTableData
  CalendarOptionTableData _toData() {
    return CalendarOptionTableData(
      id: id ?? 0,
      // autoIncrement 컬럼이므로, INSERT 시에 0 무시됨.
      showFinished: showFinished,
      firstDayOfWeek: firstDayOfWeek,
      viewType: viewType,
      showAgenda: showAgenda,
      dbTimestamp: dbTimestamp,
    );
  }

  CalendarOptionTableCompanion toSchema() {
    return CalendarOptionTableCompanion(
      showFinished: Value(showFinished),
      firstDayOfWeek: Value(firstDayOfWeek),
      viewType: Value(viewType),
      showAgenda: Value(showAgenda),
      dbTimestamp: Value(dbTimestamp),
    );
  }
}

extension CalendarOptionTableDataMapper on CalendarOptionTableData {
  /// CalendarOptionTableData -> CalendarOption
  CalendarOption toModel() {
    return CalendarOption(
      id: id,
      showFinished: showFinished,
      firstDayOfWeek: firstDayOfWeek,
      viewType: CalendarView.values.firstWhere((e) => e == viewType),
      showAgenda: showAgenda,
      dbTimestamp: dbTimestamp,
    );
  }
}
