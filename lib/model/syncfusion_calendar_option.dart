// Package imports:
import 'package:drift/drift.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Project imports:
import 'table/table.dart';

class SyncfusionCalendarOption {
  final int? id;
  final bool showFinished;
  final int firstDayOfWeek;

  // final MonthAppointmentDisplayMode appointmentDisplayMode;
  final bool showAgenda;
  final DateTime dbTimestamp;

  SyncfusionCalendarOption({
    this.id,
    this.showFinished = true,
    this.firstDayOfWeek = 7,
    // this.appointmentDisplayMode = MonthAppointmentDisplayMode.appointment,
    this.showAgenda = true,
    DateTime? dbTimestamp,
  }) : dbTimestamp = dbTimestamp ?? DateTime.now();

  SyncfusionCalendarOption copyWith({
    bool? showFinished,
    int? firstDayOfWeek,
    bool? showAgenda,
    DateTime? dbTimestamp,
  }) {
    return SyncfusionCalendarOption(
      showFinished: showFinished ?? this.showFinished,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      showAgenda: showAgenda ?? this.showAgenda,
      dbTimestamp: dbTimestamp ?? this.dbTimestamp,
    );
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
      'showAgenda: $showAgenda, dbTimestamp: $dbTimestamp)';
}

extension CalendarOptionMapper on SyncfusionCalendarOption {
  /// CalendarOption -> CalendarOptionTableData
  SyncfusionCalendarOptionTableData _toData() {
    return SyncfusionCalendarOptionTableData(
      id: id ?? 0,
      // autoIncrement 컬럼이므로, INSERT 시에 0 무시됨.
      showFinished: showFinished,
      firstDayOfWeek: firstDayOfWeek,
      showAgenda: showAgenda,
      dbTimestamp: dbTimestamp,
    );
  }

  SyncfusionCalendarOptionTableCompanion toSchema() {
    return SyncfusionCalendarOptionTableCompanion(
      showFinished: Value(showFinished),
      firstDayOfWeek: Value(firstDayOfWeek),
      showAgenda: Value(showAgenda),
      dbTimestamp: Value(dbTimestamp),
    );
  }
}

extension CalendarOptionTableDataMapper on SyncfusionCalendarOptionTableData {
  /// CalendarOptionTableData -> CalendarOption
  SyncfusionCalendarOption toModel() {
    return SyncfusionCalendarOption(
      id: id,
      showFinished: showFinished,
      firstDayOfWeek: firstDayOfWeek,
      showAgenda: showAgenda,
      dbTimestamp: dbTimestamp,
    );
  }
}
