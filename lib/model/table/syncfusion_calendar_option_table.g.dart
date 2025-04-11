// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syncfusion_calendar_option_table.dart';

// ignore_for_file: type=lint
class $SyncfusionCalendarOptionTableTable extends SyncfusionCalendarOptionTable
    with
        TableInfo<$SyncfusionCalendarOptionTableTable,
            SyncfusionCalendarOptionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncfusionCalendarOptionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _showFinishedMeta =
      const VerificationMeta('showFinished');
  @override
  late final GeneratedColumn<bool> showFinished = GeneratedColumn<bool>(
      'show_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_finished" IN (0, 1))'));
  static const VerificationMeta _firstDayOfWeekMeta =
      const VerificationMeta('firstDayOfWeek');
  @override
  late final GeneratedColumn<int> firstDayOfWeek = GeneratedColumn<int>(
      'first_day_of_week', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _showAgendaMeta =
      const VerificationMeta('showAgenda');
  @override
  late final GeneratedColumn<bool> showAgenda = GeneratedColumn<bool>(
      'show_agenda', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_agenda" IN (0, 1))'));
  static const VerificationMeta _dbTimestampMeta =
      const VerificationMeta('dbTimestamp');
  @override
  late final GeneratedColumn<DateTime> dbTimestamp = GeneratedColumn<DateTime>(
      'db_timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, showFinished, firstDayOfWeek, showAgenda, dbTimestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'syncfusion_calendar_option_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SyncfusionCalendarOptionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('show_finished')) {
      context.handle(
          _showFinishedMeta,
          showFinished.isAcceptableOrUnknown(
              data['show_finished']!, _showFinishedMeta));
    } else if (isInserting) {
      context.missing(_showFinishedMeta);
    }
    if (data.containsKey('first_day_of_week')) {
      context.handle(
          _firstDayOfWeekMeta,
          firstDayOfWeek.isAcceptableOrUnknown(
              data['first_day_of_week']!, _firstDayOfWeekMeta));
    } else if (isInserting) {
      context.missing(_firstDayOfWeekMeta);
    }
    if (data.containsKey('show_agenda')) {
      context.handle(
          _showAgendaMeta,
          showAgenda.isAcceptableOrUnknown(
              data['show_agenda']!, _showAgendaMeta));
    } else if (isInserting) {
      context.missing(_showAgendaMeta);
    }
    if (data.containsKey('db_timestamp')) {
      context.handle(
          _dbTimestampMeta,
          dbTimestamp.isAcceptableOrUnknown(
              data['db_timestamp']!, _dbTimestampMeta));
    } else if (isInserting) {
      context.missing(_dbTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncfusionCalendarOptionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncfusionCalendarOptionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      showFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_finished'])!,
      firstDayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}first_day_of_week'])!,
      showAgenda: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_agenda'])!,
      dbTimestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}db_timestamp'])!,
    );
  }

  @override
  $SyncfusionCalendarOptionTableTable createAlias(String alias) {
    return $SyncfusionCalendarOptionTableTable(attachedDatabase, alias);
  }
}

class SyncfusionCalendarOptionTableData extends DataClass
    implements Insertable<SyncfusionCalendarOptionTableData> {
  final int id;
  final bool showFinished;
  final int firstDayOfWeek;
  final bool showAgenda;
  final DateTime dbTimestamp;
  const SyncfusionCalendarOptionTableData(
      {required this.id,
      required this.showFinished,
      required this.firstDayOfWeek,
      required this.showAgenda,
      required this.dbTimestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['show_finished'] = Variable<bool>(showFinished);
    map['first_day_of_week'] = Variable<int>(firstDayOfWeek);
    map['show_agenda'] = Variable<bool>(showAgenda);
    map['db_timestamp'] = Variable<DateTime>(dbTimestamp);
    return map;
  }

  SyncfusionCalendarOptionTableCompanion toCompanion(bool nullToAbsent) {
    return SyncfusionCalendarOptionTableCompanion(
      id: Value(id),
      showFinished: Value(showFinished),
      firstDayOfWeek: Value(firstDayOfWeek),
      showAgenda: Value(showAgenda),
      dbTimestamp: Value(dbTimestamp),
    );
  }

  factory SyncfusionCalendarOptionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncfusionCalendarOptionTableData(
      id: serializer.fromJson<int>(json['id']),
      showFinished: serializer.fromJson<bool>(json['showFinished']),
      firstDayOfWeek: serializer.fromJson<int>(json['firstDayOfWeek']),
      showAgenda: serializer.fromJson<bool>(json['showAgenda']),
      dbTimestamp: serializer.fromJson<DateTime>(json['dbTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'showFinished': serializer.toJson<bool>(showFinished),
      'firstDayOfWeek': serializer.toJson<int>(firstDayOfWeek),
      'showAgenda': serializer.toJson<bool>(showAgenda),
      'dbTimestamp': serializer.toJson<DateTime>(dbTimestamp),
    };
  }

  SyncfusionCalendarOptionTableData copyWith(
          {int? id,
          bool? showFinished,
          int? firstDayOfWeek,
          bool? showAgenda,
          DateTime? dbTimestamp}) =>
      SyncfusionCalendarOptionTableData(
        id: id ?? this.id,
        showFinished: showFinished ?? this.showFinished,
        firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
        showAgenda: showAgenda ?? this.showAgenda,
        dbTimestamp: dbTimestamp ?? this.dbTimestamp,
      );
  SyncfusionCalendarOptionTableData copyWithCompanion(
      SyncfusionCalendarOptionTableCompanion data) {
    return SyncfusionCalendarOptionTableData(
      id: data.id.present ? data.id.value : this.id,
      showFinished: data.showFinished.present
          ? data.showFinished.value
          : this.showFinished,
      firstDayOfWeek: data.firstDayOfWeek.present
          ? data.firstDayOfWeek.value
          : this.firstDayOfWeek,
      showAgenda:
          data.showAgenda.present ? data.showAgenda.value : this.showAgenda,
      dbTimestamp:
          data.dbTimestamp.present ? data.dbTimestamp.value : this.dbTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncfusionCalendarOptionTableData(')
          ..write('id: $id, ')
          ..write('showFinished: $showFinished, ')
          ..write('firstDayOfWeek: $firstDayOfWeek, ')
          ..write('showAgenda: $showAgenda, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, showFinished, firstDayOfWeek, showAgenda, dbTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncfusionCalendarOptionTableData &&
          other.id == this.id &&
          other.showFinished == this.showFinished &&
          other.firstDayOfWeek == this.firstDayOfWeek &&
          other.showAgenda == this.showAgenda &&
          other.dbTimestamp == this.dbTimestamp);
}

class SyncfusionCalendarOptionTableCompanion
    extends UpdateCompanion<SyncfusionCalendarOptionTableData> {
  final Value<int> id;
  final Value<bool> showFinished;
  final Value<int> firstDayOfWeek;
  final Value<bool> showAgenda;
  final Value<DateTime> dbTimestamp;
  const SyncfusionCalendarOptionTableCompanion({
    this.id = const Value.absent(),
    this.showFinished = const Value.absent(),
    this.firstDayOfWeek = const Value.absent(),
    this.showAgenda = const Value.absent(),
    this.dbTimestamp = const Value.absent(),
  });
  SyncfusionCalendarOptionTableCompanion.insert({
    this.id = const Value.absent(),
    required bool showFinished,
    required int firstDayOfWeek,
    required bool showAgenda,
    required DateTime dbTimestamp,
  })  : showFinished = Value(showFinished),
        firstDayOfWeek = Value(firstDayOfWeek),
        showAgenda = Value(showAgenda),
        dbTimestamp = Value(dbTimestamp);
  static Insertable<SyncfusionCalendarOptionTableData> custom({
    Expression<int>? id,
    Expression<bool>? showFinished,
    Expression<int>? firstDayOfWeek,
    Expression<bool>? showAgenda,
    Expression<DateTime>? dbTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (showFinished != null) 'show_finished': showFinished,
      if (firstDayOfWeek != null) 'first_day_of_week': firstDayOfWeek,
      if (showAgenda != null) 'show_agenda': showAgenda,
      if (dbTimestamp != null) 'db_timestamp': dbTimestamp,
    });
  }

  SyncfusionCalendarOptionTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? showFinished,
      Value<int>? firstDayOfWeek,
      Value<bool>? showAgenda,
      Value<DateTime>? dbTimestamp}) {
    return SyncfusionCalendarOptionTableCompanion(
      id: id ?? this.id,
      showFinished: showFinished ?? this.showFinished,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      showAgenda: showAgenda ?? this.showAgenda,
      dbTimestamp: dbTimestamp ?? this.dbTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (showFinished.present) {
      map['show_finished'] = Variable<bool>(showFinished.value);
    }
    if (firstDayOfWeek.present) {
      map['first_day_of_week'] = Variable<int>(firstDayOfWeek.value);
    }
    if (showAgenda.present) {
      map['show_agenda'] = Variable<bool>(showAgenda.value);
    }
    if (dbTimestamp.present) {
      map['db_timestamp'] = Variable<DateTime>(dbTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncfusionCalendarOptionTableCompanion(')
          ..write('id: $id, ')
          ..write('showFinished: $showFinished, ')
          ..write('firstDayOfWeek: $firstDayOfWeek, ')
          ..write('showAgenda: $showAgenda, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$SyncfusionCalendarOptionDrift extends GeneratedDatabase {
  _$SyncfusionCalendarOptionDrift(QueryExecutor e) : super(e);
  $SyncfusionCalendarOptionDriftManager get managers =>
      $SyncfusionCalendarOptionDriftManager(this);
  late final $SyncfusionCalendarOptionTableTable syncfusionCalendarOptionTable =
      $SyncfusionCalendarOptionTableTable(this);
  late final Index dbTimestamp = Index('dbTimestamp',
      'CREATE INDEX dbTimestamp ON syncfusion_calendar_option_table (db_timestamp)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [syncfusionCalendarOptionTable, dbTimestamp];
}

typedef $$SyncfusionCalendarOptionTableTableCreateCompanionBuilder
    = SyncfusionCalendarOptionTableCompanion Function({
  Value<int> id,
  required bool showFinished,
  required int firstDayOfWeek,
  required bool showAgenda,
  required DateTime dbTimestamp,
});
typedef $$SyncfusionCalendarOptionTableTableUpdateCompanionBuilder
    = SyncfusionCalendarOptionTableCompanion Function({
  Value<int> id,
  Value<bool> showFinished,
  Value<int> firstDayOfWeek,
  Value<bool> showAgenda,
  Value<DateTime> dbTimestamp,
});

class $$SyncfusionCalendarOptionTableTableFilterComposer extends Composer<
    _$SyncfusionCalendarOptionDrift, $SyncfusionCalendarOptionTableTable> {
  $$SyncfusionCalendarOptionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showFinished => $composableBuilder(
      column: $table.showFinished, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get firstDayOfWeek => $composableBuilder(
      column: $table.firstDayOfWeek,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showAgenda => $composableBuilder(
      column: $table.showAgenda, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnFilters(column));
}

class $$SyncfusionCalendarOptionTableTableOrderingComposer extends Composer<
    _$SyncfusionCalendarOptionDrift, $SyncfusionCalendarOptionTableTable> {
  $$SyncfusionCalendarOptionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showFinished => $composableBuilder(
      column: $table.showFinished,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get firstDayOfWeek => $composableBuilder(
      column: $table.firstDayOfWeek,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showAgenda => $composableBuilder(
      column: $table.showAgenda, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnOrderings(column));
}

class $$SyncfusionCalendarOptionTableTableAnnotationComposer extends Composer<
    _$SyncfusionCalendarOptionDrift, $SyncfusionCalendarOptionTableTable> {
  $$SyncfusionCalendarOptionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get showFinished => $composableBuilder(
      column: $table.showFinished, builder: (column) => column);

  GeneratedColumn<int> get firstDayOfWeek => $composableBuilder(
      column: $table.firstDayOfWeek, builder: (column) => column);

  GeneratedColumn<bool> get showAgenda => $composableBuilder(
      column: $table.showAgenda, builder: (column) => column);

  GeneratedColumn<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => column);
}

class $$SyncfusionCalendarOptionTableTableTableManager extends RootTableManager<
    _$SyncfusionCalendarOptionDrift,
    $SyncfusionCalendarOptionTableTable,
    SyncfusionCalendarOptionTableData,
    $$SyncfusionCalendarOptionTableTableFilterComposer,
    $$SyncfusionCalendarOptionTableTableOrderingComposer,
    $$SyncfusionCalendarOptionTableTableAnnotationComposer,
    $$SyncfusionCalendarOptionTableTableCreateCompanionBuilder,
    $$SyncfusionCalendarOptionTableTableUpdateCompanionBuilder,
    (
      SyncfusionCalendarOptionTableData,
      BaseReferences<
          _$SyncfusionCalendarOptionDrift,
          $SyncfusionCalendarOptionTableTable,
          SyncfusionCalendarOptionTableData>
    ),
    SyncfusionCalendarOptionTableData,
    PrefetchHooks Function()> {
  $$SyncfusionCalendarOptionTableTableTableManager(
      _$SyncfusionCalendarOptionDrift db,
      $SyncfusionCalendarOptionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncfusionCalendarOptionTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncfusionCalendarOptionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncfusionCalendarOptionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> showFinished = const Value.absent(),
            Value<int> firstDayOfWeek = const Value.absent(),
            Value<bool> showAgenda = const Value.absent(),
            Value<DateTime> dbTimestamp = const Value.absent(),
          }) =>
              SyncfusionCalendarOptionTableCompanion(
            id: id,
            showFinished: showFinished,
            firstDayOfWeek: firstDayOfWeek,
            showAgenda: showAgenda,
            dbTimestamp: dbTimestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required bool showFinished,
            required int firstDayOfWeek,
            required bool showAgenda,
            required DateTime dbTimestamp,
          }) =>
              SyncfusionCalendarOptionTableCompanion.insert(
            id: id,
            showFinished: showFinished,
            firstDayOfWeek: firstDayOfWeek,
            showAgenda: showAgenda,
            dbTimestamp: dbTimestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncfusionCalendarOptionTableTableProcessedTableManager
    = ProcessedTableManager<
        _$SyncfusionCalendarOptionDrift,
        $SyncfusionCalendarOptionTableTable,
        SyncfusionCalendarOptionTableData,
        $$SyncfusionCalendarOptionTableTableFilterComposer,
        $$SyncfusionCalendarOptionTableTableOrderingComposer,
        $$SyncfusionCalendarOptionTableTableAnnotationComposer,
        $$SyncfusionCalendarOptionTableTableCreateCompanionBuilder,
        $$SyncfusionCalendarOptionTableTableUpdateCompanionBuilder,
        (
          SyncfusionCalendarOptionTableData,
          BaseReferences<
              _$SyncfusionCalendarOptionDrift,
              $SyncfusionCalendarOptionTableTable,
              SyncfusionCalendarOptionTableData>
        ),
        SyncfusionCalendarOptionTableData,
        PrefetchHooks Function()>;

class $SyncfusionCalendarOptionDriftManager {
  final _$SyncfusionCalendarOptionDrift _db;
  $SyncfusionCalendarOptionDriftManager(this._db);
  $$SyncfusionCalendarOptionTableTableTableManager
      get syncfusionCalendarOptionTable =>
          $$SyncfusionCalendarOptionTableTableTableManager(
              _db, _db.syncfusionCalendarOptionTable);
}
