// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_code_color_table.dart';

// ignore_for_file: type=lint
class $SubjectCodeColorTableTable extends SubjectCodeColorTable
    with TableInfo<$SubjectCodeColorTableTable, SubjectCodeColorTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectCodeColorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _semesterMeta =
      const VerificationMeta('semester');
  @override
  late final GeneratedColumn<int> semester = GeneratedColumn<int>(
      'semester', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subjectCodeMeta =
      const VerificationMeta('subjectCode');
  @override
  late final GeneratedColumn<String> subjectCode = GeneratedColumn<String>(
      'subject_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [year, semester, subjectCode, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subject_code_color_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SubjectCodeColorTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('semester')) {
      context.handle(_semesterMeta,
          semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta));
    } else if (isInserting) {
      context.missing(_semesterMeta);
    }
    if (data.containsKey('subject_code')) {
      context.handle(
          _subjectCodeMeta,
          subjectCode.isAcceptableOrUnknown(
              data['subject_code']!, _subjectCodeMeta));
    } else if (isInserting) {
      context.missing(_subjectCodeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year, semester, subjectCode};
  @override
  SubjectCodeColorTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectCodeColorTableData(
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      semester: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}semester'])!,
      subjectCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_code'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $SubjectCodeColorTableTable createAlias(String alias) {
    return $SubjectCodeColorTableTable(attachedDatabase, alias);
  }
}

class SubjectCodeColorTableData extends DataClass
    implements Insertable<SubjectCodeColorTableData> {
  final int year;
  final int semester;
  final String subjectCode;
  final int color;
  const SubjectCodeColorTableData(
      {required this.year,
      required this.semester,
      required this.subjectCode,
      required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['semester'] = Variable<int>(semester);
    map['subject_code'] = Variable<String>(subjectCode);
    map['color'] = Variable<int>(color);
    return map;
  }

  SubjectCodeColorTableCompanion toCompanion(bool nullToAbsent) {
    return SubjectCodeColorTableCompanion(
      year: Value(year),
      semester: Value(semester),
      subjectCode: Value(subjectCode),
      color: Value(color),
    );
  }

  factory SubjectCodeColorTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectCodeColorTableData(
      year: serializer.fromJson<int>(json['year']),
      semester: serializer.fromJson<int>(json['semester']),
      subjectCode: serializer.fromJson<String>(json['subjectCode']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'semester': serializer.toJson<int>(semester),
      'subjectCode': serializer.toJson<String>(subjectCode),
      'color': serializer.toJson<int>(color),
    };
  }

  SubjectCodeColorTableData copyWith(
          {int? year, int? semester, String? subjectCode, int? color}) =>
      SubjectCodeColorTableData(
        year: year ?? this.year,
        semester: semester ?? this.semester,
        subjectCode: subjectCode ?? this.subjectCode,
        color: color ?? this.color,
      );
  SubjectCodeColorTableData copyWithCompanion(
      SubjectCodeColorTableCompanion data) {
    return SubjectCodeColorTableData(
      year: data.year.present ? data.year.value : this.year,
      semester: data.semester.present ? data.semester.value : this.semester,
      subjectCode:
          data.subjectCode.present ? data.subjectCode.value : this.subjectCode,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubjectCodeColorTableData(')
          ..write('year: $year, ')
          ..write('semester: $semester, ')
          ..write('subjectCode: $subjectCode, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(year, semester, subjectCode, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectCodeColorTableData &&
          other.year == this.year &&
          other.semester == this.semester &&
          other.subjectCode == this.subjectCode &&
          other.color == this.color);
}

class SubjectCodeColorTableCompanion
    extends UpdateCompanion<SubjectCodeColorTableData> {
  final Value<int> year;
  final Value<int> semester;
  final Value<String> subjectCode;
  final Value<int> color;
  final Value<int> rowid;
  const SubjectCodeColorTableCompanion({
    this.year = const Value.absent(),
    this.semester = const Value.absent(),
    this.subjectCode = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectCodeColorTableCompanion.insert({
    required int year,
    required int semester,
    required String subjectCode,
    required int color,
    this.rowid = const Value.absent(),
  })  : year = Value(year),
        semester = Value(semester),
        subjectCode = Value(subjectCode),
        color = Value(color);
  static Insertable<SubjectCodeColorTableData> custom({
    Expression<int>? year,
    Expression<int>? semester,
    Expression<String>? subjectCode,
    Expression<int>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (semester != null) 'semester': semester,
      if (subjectCode != null) 'subject_code': subjectCode,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectCodeColorTableCompanion copyWith(
      {Value<int>? year,
      Value<int>? semester,
      Value<String>? subjectCode,
      Value<int>? color,
      Value<int>? rowid}) {
    return SubjectCodeColorTableCompanion(
      year: year ?? this.year,
      semester: semester ?? this.semester,
      subjectCode: subjectCode ?? this.subjectCode,
      color: color ?? this.color,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (semester.present) {
      map['semester'] = Variable<int>(semester.value);
    }
    if (subjectCode.present) {
      map['subject_code'] = Variable<String>(subjectCode.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectCodeColorTableCompanion(')
          ..write('year: $year, ')
          ..write('semester: $semester, ')
          ..write('subjectCode: $subjectCode, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SubjectCodeColorDrift extends GeneratedDatabase {
  _$SubjectCodeColorDrift(QueryExecutor e) : super(e);
  $SubjectCodeColorDriftManager get managers =>
      $SubjectCodeColorDriftManager(this);
  late final $SubjectCodeColorTableTable subjectCodeColorTable =
      $SubjectCodeColorTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [subjectCodeColorTable];
}

typedef $$SubjectCodeColorTableTableCreateCompanionBuilder
    = SubjectCodeColorTableCompanion Function({
  required int year,
  required int semester,
  required String subjectCode,
  required int color,
  Value<int> rowid,
});
typedef $$SubjectCodeColorTableTableUpdateCompanionBuilder
    = SubjectCodeColorTableCompanion Function({
  Value<int> year,
  Value<int> semester,
  Value<String> subjectCode,
  Value<int> color,
  Value<int> rowid,
});

class $$SubjectCodeColorTableTableFilterComposer
    extends Composer<_$SubjectCodeColorDrift, $SubjectCodeColorTableTable> {
  $$SubjectCodeColorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get semester => $composableBuilder(
      column: $table.semester, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subjectCode => $composableBuilder(
      column: $table.subjectCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));
}

class $$SubjectCodeColorTableTableOrderingComposer
    extends Composer<_$SubjectCodeColorDrift, $SubjectCodeColorTableTable> {
  $$SubjectCodeColorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get semester => $composableBuilder(
      column: $table.semester, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subjectCode => $composableBuilder(
      column: $table.subjectCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));
}

class $$SubjectCodeColorTableTableAnnotationComposer
    extends Composer<_$SubjectCodeColorDrift, $SubjectCodeColorTableTable> {
  $$SubjectCodeColorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get semester =>
      $composableBuilder(column: $table.semester, builder: (column) => column);

  GeneratedColumn<String> get subjectCode => $composableBuilder(
      column: $table.subjectCode, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);
}

class $$SubjectCodeColorTableTableTableManager extends RootTableManager<
    _$SubjectCodeColorDrift,
    $SubjectCodeColorTableTable,
    SubjectCodeColorTableData,
    $$SubjectCodeColorTableTableFilterComposer,
    $$SubjectCodeColorTableTableOrderingComposer,
    $$SubjectCodeColorTableTableAnnotationComposer,
    $$SubjectCodeColorTableTableCreateCompanionBuilder,
    $$SubjectCodeColorTableTableUpdateCompanionBuilder,
    (
      SubjectCodeColorTableData,
      BaseReferences<_$SubjectCodeColorDrift, $SubjectCodeColorTableTable,
          SubjectCodeColorTableData>
    ),
    SubjectCodeColorTableData,
    PrefetchHooks Function()> {
  $$SubjectCodeColorTableTableTableManager(
      _$SubjectCodeColorDrift db, $SubjectCodeColorTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectCodeColorTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectCodeColorTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectCodeColorTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> year = const Value.absent(),
            Value<int> semester = const Value.absent(),
            Value<String> subjectCode = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubjectCodeColorTableCompanion(
            year: year,
            semester: semester,
            subjectCode: subjectCode,
            color: color,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int year,
            required int semester,
            required String subjectCode,
            required int color,
            Value<int> rowid = const Value.absent(),
          }) =>
              SubjectCodeColorTableCompanion.insert(
            year: year,
            semester: semester,
            subjectCode: subjectCode,
            color: color,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SubjectCodeColorTableTableProcessedTableManager
    = ProcessedTableManager<
        _$SubjectCodeColorDrift,
        $SubjectCodeColorTableTable,
        SubjectCodeColorTableData,
        $$SubjectCodeColorTableTableFilterComposer,
        $$SubjectCodeColorTableTableOrderingComposer,
        $$SubjectCodeColorTableTableAnnotationComposer,
        $$SubjectCodeColorTableTableCreateCompanionBuilder,
        $$SubjectCodeColorTableTableUpdateCompanionBuilder,
        (
          SubjectCodeColorTableData,
          BaseReferences<_$SubjectCodeColorDrift, $SubjectCodeColorTableTable,
              SubjectCodeColorTableData>
        ),
        SubjectCodeColorTableData,
        PrefetchHooks Function()>;

class $SubjectCodeColorDriftManager {
  final _$SubjectCodeColorDrift _db;
  $SubjectCodeColorDriftManager(this._db);
  $$SubjectCodeColorTableTableTableManager get subjectCodeColorTable =>
      $$SubjectCodeColorTableTableTableManager(_db, _db.subjectCodeColorTable);
}
