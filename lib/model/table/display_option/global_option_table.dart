import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' as flutter_material;

part 'global_option_table.g.dart';

class GlobalOptionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tapIndex => integer()();

  TextColumn get themeMode => textEnum<flutter_material.ThemeMode>()();

  DateTimeColumn get dbTimestamp => dateTime()();
}

@DriftDatabase(tables: [GlobalOptionTable])
class GlobalOptionDrift extends _$GlobalOptionDrift {
  GlobalOptionDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'global_option_table.db');
  }

  Future<void> write(GlobalOptionTableCompanion data) async {
    await transaction(() async {
      return await into(globalOptionTable).insert(data);
    });
  }

  Future<GlobalOptionTableData> read() async {
    final query = select(globalOptionTable)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1);
    final result = await query.getSingle();
    return result;
  }
}
