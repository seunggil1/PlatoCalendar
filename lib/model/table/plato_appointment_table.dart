// Package imports:
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'plato_appointment_table.g.dart';
part 'plato_appointment_table_query.dart';

enum Status { enable, disable }

enum DataType { school, etc }

@TableIndex(name: 'status', columns: {#status})
@TableIndex(name: 'finished', columns: {#finished})
@TableIndex(name: 'end', columns: {#end})
@TableIndex(name: 'subjectCode', columns: {#subjectCode})
class PlatoAppointmentTable extends Table {
  TextColumn get uid => text()();

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
      // 새로운 데이터 기록. 이미 있을 경우 업데이트
      return await into(platoAppointmentTable).insertOnConflictUpdate(data);
    });
  }

  Future<void> writeAll(List<PlatoAppointmentTableCompanion> data) async {
    await transaction(() async {
      return await batch((batch) {
        // TODO : 데이터 변경사항이 반영되지 않는 문제가 있음
        batch.insertAll(platoAppointmentTable, data,
            mode: InsertMode.insertOrIgnore);
      });
    });
  }

  Future<List<PlatoAppointmentTableData>> readAll(
      {required bool showFinished}) {
    final query = select(platoAppointmentTable)
      ..where((t) => t.status.equals('enable'));

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
