import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'calendar_option_table.g.dart';

class CalendarOptionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get showFinished => boolean()();

  IntColumn get firstDayOfWeek => integer()();

  TextColumn get viewType => textEnum<CalendarView>()();

  TextColumn get appointmentDisplayMode =>
      textEnum<MonthAppointmentDisplayMode>()();

  BoolColumn get showAgenda => boolean()();

  DateTimeColumn get dbTimestamp => dateTime()();
}

@DriftDatabase(tables: [CalendarOptionTable])
class CalendarOptionDrift extends _$CalendarOptionDrift {
  CalendarOptionDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'calendar_option.db');
  }

  Future<void> write(CalendarOptionTableCompanion data) async {
    await transaction(() async {
      return await into(calendarOptionTable).insert(data);
    });
  }

  Future<CalendarOptionTableData> read() async {
    return await (select(calendarOptionTable)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.dbTimestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Future<void> replace(CalendarOptionTableCompanion data) async {
    await transaction(() async {
      return await into(calendarOptionTable).insertOnConflictUpdate(data);
    });
  }

  Future<void> deleteById(int id) async {
    await transaction(() async {
      return await (delete(calendarOptionTable)
            ..where((col) => col.id.equals(id)))
          .go();
    });
  }

  Future<bool> isEmpty() async {
    return (await managers.calendarOptionTable.count()) == 0;
  }

  Future<int> count() async {
    return await managers.calendarOptionTable.count();
  }
}
