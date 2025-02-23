import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'plato_appointment_table.g.dart';
part 'plato_appointment_table_query.dart';

enum Status { enable, disable }

enum DataType { school, etc }

@TableIndex(name: 'finished', columns: {#finished})
@TableIndex(name: 'end', columns: {#end})
class PlatoAppointmentTable extends Table {
  TextColumn get uid => text().unique()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  TextColumn get comment => text()();

  TextColumn get subjectCode => text()();

  TextColumn get year => text()();

  TextColumn get semester => text()();

  DateTimeColumn get start => dateTime()();

  DateTimeColumn get end => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  BoolColumn get finished => boolean()();

  TextColumn get status => textEnum<Status>()();

  TextColumn get dataType => textEnum<DataType>()();

  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {uid};
}

@DriftDatabase(tables: [PlatoAppointmentTable])
class PlatoAppointmentDrift extends _$PlatoAppointmentDrift {
  PlatoAppointmentDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'plato_appointment.db');
  }

  Future<void> write(PlatoAppointmentTableCompanion data) async {
    await transaction(() async {
      return await into(platoAppointmentTable).insertOnConflictUpdate(data);
    });
  }

  Future<void> writeAll(List<PlatoAppointmentTableCompanion> data) async {
    await transaction(() async {
      return await batch((batch) {
        batch.insertAllOnConflictUpdate(platoAppointmentTable, data);
      });
    });
  }

  Future<List<PlatoAppointmentTableData>> readAll(
      {required bool showFinished}) {
    final query = select(platoAppointmentTable);

    // showFinished가 false이면, finished가 false인 것만 가져옴
    if (!showFinished) {
      query.where((tbl) => tbl.finished.equals(false));
    }
    query.orderBy([
      (t) => OrderingTerm(expression: t.end, mode: OrderingMode.asc),
    ]);
    return query.get();
  }

  Future<PlatoAppointmentTableData> readByUid(String uid) async {
    return await (select(platoAppointmentTable)
          ..where((tbl) => tbl.uid.equals(uid)))
        .getSingle();
  }

  Future<void> deleteById(String uid) async {
    await transaction(() async {
      return await (delete(platoAppointmentTable)
            ..where((col) => col.uid.equals(uid)))
          .go();
    });
  }

  Future<void> deleteAll() async {
    await transaction(() async {
      return await delete(platoAppointmentTable).go();
    });
  }
}
