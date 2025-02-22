import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'sync_info_table.g.dart';

@TableIndex(name: 'platoSyncTime', columns: {#platoSyncTime})
class SyncInfoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get success => boolean().withDefault(Constant(true))();
  DateTimeColumn get platoSyncTime => dateTime()();

  TextColumn get failReason => text().withDefault(Constant(''))();
}

@DriftDatabase(tables: [SyncInfoTable])
class SyncInfoDrift extends _$SyncInfoDrift {
  SyncInfoDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'sync_info.db');
  }

  Future<void> write(SyncInfoTableCompanion data) async {
    await transaction(() async {
      return await into(syncInfoTable).insertOnConflictUpdate(data);
    });
  }

  Future<SyncInfoTableData> read() async {
    return await (select(syncInfoTable)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.platoSyncTime, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Future<bool> isEmpty() async {
    return (await managers.syncInfoTable.count()) == 0;
  }

  Future<void> deleteAll() async {
    await transaction(() async {
      return await delete(syncInfoTable).go();
    });
  }
}
