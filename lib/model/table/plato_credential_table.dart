// Package imports:
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'plato_credential_table.g.dart';

class PlatoCredentialTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get username => text().withLength(min: 1, max: 50)();

  TextColumn get password => text().withLength(min: 1, max: 50)();

  DateTimeColumn get dbTimestamp => dateTime()();
}

@DriftDatabase(tables: [PlatoCredentialTable])
class PlatoCredentialDrift extends _$PlatoCredentialDrift {
  PlatoCredentialDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'plato_credential.db');
  }

  Future<void> write(PlatoCredentialTableCompanion data) async {
    await transaction(() async {
      return await into(platoCredentialTable).insertOnConflictUpdate(data);
    });
  }

  Future<PlatoCredentialTableData> read() async {
    return await (select(platoCredentialTable)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.dbTimestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Future<bool> isEmpty() async {
    return (await managers.platoCredentialTable.count()) == 0;
  }

  Future<void> deleteAll() async {
    await transaction(() async {
      return await delete(platoCredentialTable).go();
    });
  }
}
