import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'plato_appointment_table.g.dart';

enum Status { enable, disable }

enum DataType { school, etc }

@TableIndex(name: 'finished', columns: {#finished})
class PlatoAppointmentTable extends Table {
  IntColumn get id => integer().autoIncrement()();

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
      return await into(platoAppointmentTable).insert(data);
    });
  }

  Future<void> writeAll(List<PlatoAppointmentTableCompanion> data) async {
    await transaction(() async {
      return await batch((batch) {
        batch.insertAllOnConflictUpdate(platoAppointmentTable, data);
      });
    });
  }

  Future<List<PlatoAppointmentTableData>> readAll() async {
    return await (select(platoAppointmentTable)
          ..orderBy(
              [(t) => OrderingTerm(expression: t.end, mode: OrderingMode.asc)]))
        .get();
  }

  Future<PlatoAppointmentTableData> readById(int id) async {
    return await (select(platoAppointmentTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<void> deleteById(int id) async {
    await transaction(() async {
      return await (delete(platoAppointmentTable)
            ..where((col) => col.id.equals(id)))
          .go();
    });
  }

  Future<void> deleteAll() async {
    await transaction(() async {
      return await delete(platoAppointmentTable).go();
    });
  }
}
