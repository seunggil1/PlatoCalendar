import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'task_check_list_option_table.g.dart';

class TaskCheckListOptionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  // [지남, 6, 12, 오늘, 내일, 1주일 이하, 1주일 이상, 날짜 없음, 완료]
  BoolColumn get showPassedToDoList => boolean()();

  BoolColumn get show6HoursToDoList => boolean()();

  BoolColumn get show12HoursToDoList => boolean()();

  BoolColumn get showTodayToDoList => boolean()();

  BoolColumn get showTomorrowToDoList => boolean()();

  BoolColumn get showWeekToDoList => boolean()();

  BoolColumn get showMoreThanWeekToDoList => boolean()();

  DateTimeColumn get dbTimestamp => dateTime()();
}

@DriftDatabase(tables: [TaskCheckListOptionTable])
class TaskCheckListOptionDrift extends _$TaskCheckListOptionDrift {
  TaskCheckListOptionDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'task_check_list_option_table.db');
  }

  Future<void> write(TaskCheckListOptionTableCompanion data) async {
    await transaction(() async {
      return await into(taskCheckListOptionTable).insert(data);
    });
  }

  Future<TaskCheckListOptionTableData> read() async {
    final query = select(taskCheckListOptionTable)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1);
    final result = await query.getSingle();
    return result;
  }
}
