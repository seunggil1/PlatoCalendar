// Package imports:
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'subject_code_color_table.g.dart';

class SubjectCodeColorTable extends Table {
  IntColumn get year => integer()();
  IntColumn get semester => integer()();

  TextColumn get subjectCode => text()();

  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {year, semester, subjectCode};
}

@DriftDatabase(tables: [SubjectCodeColorTable])
class SubjectCodeColorDrift extends _$SubjectCodeColorDrift {
  SubjectCodeColorDrift() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'subject_code_color.db');
  }

  Future<void> write(SubjectCodeColorTableCompanion data) async {
    await transaction(() async {
      return await into(subjectCodeColorTable)
          .insert(data, mode: InsertMode.insertOrIgnore);
    });
  }

  Future<void> writeAll(List<SubjectCodeColorTableCompanion> data) async {
    await transaction(() async {
      return await batch((batch) {
        batch.insertAll(subjectCodeColorTable, data,
            mode: InsertMode.insertOrIgnore);
      });
    });
  }

  Future<List<SubjectCodeColorTableData>> readAll(
      {required int year, required int semester}) async {
    final query = select(subjectCodeColorTable)
      ..where((t) => t.year.equals(year) & t.semester.equals(semester));

    return await query.get();
  }
}
