// Package imports:
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'syncfusion_calendar_option_table.g.dart';

@TableIndex(name: 'dbTimestamp', columns: {#dbTimestamp})
class SyncfusionCalendarOptionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get showFinished => boolean()();

  IntColumn get firstDayOfWeek => integer()();

  BoolColumn get showAgenda => boolean()();

  DateTimeColumn get dbTimestamp => dateTime()();
}

@DriftDatabase(tables: [SyncfusionCalendarOptionTable])
class SyncfusionCalendarOptionDrift extends _$SyncfusionCalendarOptionDrift {
  SyncfusionCalendarOptionDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'syncfusion_calendar_option.db');
  }

  Future<void> write(SyncfusionCalendarOptionTableCompanion data) async {
    await transaction(() async {
      // SyncfusionCalendarOptionTable
      return await into(syncfusionCalendarOptionTable).insert(data);
    });
  }

  Future<SyncfusionCalendarOptionTableData> read() async {
    return await (select(syncfusionCalendarOptionTable)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.dbTimestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Future<void> replace(SyncfusionCalendarOptionTableCompanion data) async {
    await transaction(() async {
      return await into(syncfusionCalendarOptionTable)
          .insertOnConflictUpdate(data);
    });
  }

  Future<void> deleteById(int id) async {
    await transaction(() async {
      return await (delete(syncfusionCalendarOptionTable)
            ..where((col) => col.id.equals(id)))
          .go();
    });
  }

  Future<bool> isEmpty() async {
    return (await managers.syncfusionCalendarOptionTable.count()) == 0;
  }

  Future<int> count() async {
    return await managers.syncfusionCalendarOptionTable.count();
  }
}
