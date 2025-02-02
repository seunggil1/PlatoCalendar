// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_option_table.dart';

// ignore_for_file: type=lint
class $GlobalOptionTableTable extends GlobalOptionTable
    with TableInfo<$GlobalOptionTableTable, GlobalOptionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $GlobalOptionTableTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tapIndexMeta =
      const VerificationMeta('tapIndex');
  @override
  late final GeneratedColumn<int> tapIndex = GeneratedColumn<int>(
      'tap_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumnWithTypeConverter<flutter_material.ThemeMode,
      String> themeMode = GeneratedColumn<String>(
          'theme_mode', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true)
      .withConverter<flutter_material.ThemeMode>(
          $GlobalOptionTableTable.$converterthemeMode);
  static const VerificationMeta _dbTimestampMeta =
      const VerificationMeta('dbTimestamp');
  @override
  late final GeneratedColumn<DateTime> dbTimestamp = GeneratedColumn<DateTime>(
      'db_timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns => [id, tapIndex, themeMode, dbTimestamp];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'global_option_table';

  @override
  VerificationContext validateIntegrity(
      Insertable<GlobalOptionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tap_index')) {
      context.handle(_tapIndexMeta,
          tapIndex.isAcceptableOrUnknown(data['tap_index']!, _tapIndexMeta));
    } else if (isInserting) {
      context.missing(_tapIndexMeta);
    }
    context.handle(_themeModeMeta, const VerificationResult.success());
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
  GlobalOptionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlobalOptionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tapIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tap_index'])!,
      themeMode: $GlobalOptionTableTable.$converterthemeMode.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}theme_mode'])!),
      dbTimestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}db_timestamp'])!,
    );
  }

  @override
  $GlobalOptionTableTable createAlias(String alias) {
    return $GlobalOptionTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<flutter_material.ThemeMode, String, String>
      $converterthemeMode = const EnumNameConverter<flutter_material.ThemeMode>(
          flutter_material.ThemeMode.values);
}

class GlobalOptionTableData extends DataClass
    implements Insertable<GlobalOptionTableData> {
  final int id;
  final int tapIndex;
  final flutter_material.ThemeMode themeMode;
  final DateTime dbTimestamp;

  const GlobalOptionTableData(
      {required this.id,
      required this.tapIndex,
      required this.themeMode,
      required this.dbTimestamp});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tap_index'] = Variable<int>(tapIndex);
    {
      map['theme_mode'] = Variable<String>(
          $GlobalOptionTableTable.$converterthemeMode.toSql(themeMode));
    }
    map['db_timestamp'] = Variable<DateTime>(dbTimestamp);
    return map;
  }

  GlobalOptionTableCompanion toCompanion(bool nullToAbsent) {
    return GlobalOptionTableCompanion(
      id: Value(id),
      tapIndex: Value(tapIndex),
      themeMode: Value(themeMode),
      dbTimestamp: Value(dbTimestamp),
    );
  }

  factory GlobalOptionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlobalOptionTableData(
      id: serializer.fromJson<int>(json['id']),
      tapIndex: serializer.fromJson<int>(json['tapIndex']),
      themeMode: $GlobalOptionTableTable.$converterthemeMode
          .fromJson(serializer.fromJson<String>(json['themeMode'])),
      dbTimestamp: serializer.fromJson<DateTime>(json['dbTimestamp']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tapIndex': serializer.toJson<int>(tapIndex),
      'themeMode': serializer.toJson<String>(
          $GlobalOptionTableTable.$converterthemeMode.toJson(themeMode)),
      'dbTimestamp': serializer.toJson<DateTime>(dbTimestamp),
    };
  }

  GlobalOptionTableData copyWith(
          {int? id,
          int? tapIndex,
          flutter_material.ThemeMode? themeMode,
          DateTime? dbTimestamp}) =>
      GlobalOptionTableData(
        id: id ?? this.id,
        tapIndex: tapIndex ?? this.tapIndex,
        themeMode: themeMode ?? this.themeMode,
        dbTimestamp: dbTimestamp ?? this.dbTimestamp,
      );

  GlobalOptionTableData copyWithCompanion(GlobalOptionTableCompanion data) {
    return GlobalOptionTableData(
      id: data.id.present ? data.id.value : this.id,
      tapIndex: data.tapIndex.present ? data.tapIndex.value : this.tapIndex,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      dbTimestamp:
          data.dbTimestamp.present ? data.dbTimestamp.value : this.dbTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlobalOptionTableData(')
          ..write('id: $id, ')
          ..write('tapIndex: $tapIndex, ')
          ..write('themeMode: $themeMode, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tapIndex, themeMode, dbTimestamp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlobalOptionTableData &&
          other.id == this.id &&
          other.tapIndex == this.tapIndex &&
          other.themeMode == this.themeMode &&
          other.dbTimestamp == this.dbTimestamp);
}

class GlobalOptionTableCompanion
    extends UpdateCompanion<GlobalOptionTableData> {
  final Value<int> id;
  final Value<int> tapIndex;
  final Value<flutter_material.ThemeMode> themeMode;
  final Value<DateTime> dbTimestamp;

  const GlobalOptionTableCompanion({
    this.id = const Value.absent(),
    this.tapIndex = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.dbTimestamp = const Value.absent(),
  });

  GlobalOptionTableCompanion.insert({
    this.id = const Value.absent(),
    required int tapIndex,
    required flutter_material.ThemeMode themeMode,
    required DateTime dbTimestamp,
  })  : tapIndex = Value(tapIndex),
        themeMode = Value(themeMode),
        dbTimestamp = Value(dbTimestamp);

  static Insertable<GlobalOptionTableData> custom({
    Expression<int>? id,
    Expression<int>? tapIndex,
    Expression<String>? themeMode,
    Expression<DateTime>? dbTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tapIndex != null) 'tap_index': tapIndex,
      if (themeMode != null) 'theme_mode': themeMode,
      if (dbTimestamp != null) 'db_timestamp': dbTimestamp,
    });
  }

  GlobalOptionTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? tapIndex,
      Value<flutter_material.ThemeMode>? themeMode,
      Value<DateTime>? dbTimestamp}) {
    return GlobalOptionTableCompanion(
      id: id ?? this.id,
      tapIndex: tapIndex ?? this.tapIndex,
      themeMode: themeMode ?? this.themeMode,
      dbTimestamp: dbTimestamp ?? this.dbTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tapIndex.present) {
      map['tap_index'] = Variable<int>(tapIndex.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
          $GlobalOptionTableTable.$converterthemeMode.toSql(themeMode.value));
    }
    if (dbTimestamp.present) {
      map['db_timestamp'] = Variable<DateTime>(dbTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlobalOptionTableCompanion(')
          ..write('id: $id, ')
          ..write('tapIndex: $tapIndex, ')
          ..write('themeMode: $themeMode, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$GlobalOptionDrift extends GeneratedDatabase {
  _$GlobalOptionDrift(QueryExecutor e) : super(e);

  $GlobalOptionDriftManager get managers => $GlobalOptionDriftManager(this);
  late final $GlobalOptionTableTable globalOptionTable =
      $GlobalOptionTableTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [globalOptionTable];
}

typedef $$GlobalOptionTableTableCreateCompanionBuilder
    = GlobalOptionTableCompanion Function({
  Value<int> id,
  required int tapIndex,
  required flutter_material.ThemeMode themeMode,
  required DateTime dbTimestamp,
});
typedef $$GlobalOptionTableTableUpdateCompanionBuilder
    = GlobalOptionTableCompanion Function({
  Value<int> id,
  Value<int> tapIndex,
  Value<flutter_material.ThemeMode> themeMode,
  Value<DateTime> dbTimestamp,
});

class $$GlobalOptionTableTableFilterComposer
    extends Composer<_$GlobalOptionDrift, $GlobalOptionTableTable> {
  $$GlobalOptionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tapIndex => $composableBuilder(
      column: $table.tapIndex, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<flutter_material.ThemeMode,
          flutter_material.ThemeMode, String>
      get themeMode => $composableBuilder(
          column: $table.themeMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnFilters(column));
}

class $$GlobalOptionTableTableOrderingComposer
    extends Composer<_$GlobalOptionDrift, $GlobalOptionTableTable> {
  $$GlobalOptionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tapIndex => $composableBuilder(
      column: $table.tapIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnOrderings(column));
}

class $$GlobalOptionTableTableAnnotationComposer
    extends Composer<_$GlobalOptionDrift, $GlobalOptionTableTable> {
  $$GlobalOptionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tapIndex =>
      $composableBuilder(column: $table.tapIndex, builder: (column) => column);

  GeneratedColumnWithTypeConverter<flutter_material.ThemeMode, String>
      get themeMode => $composableBuilder(
          column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => column);
}

class $$GlobalOptionTableTableTableManager extends RootTableManager<
    _$GlobalOptionDrift,
    $GlobalOptionTableTable,
    GlobalOptionTableData,
    $$GlobalOptionTableTableFilterComposer,
    $$GlobalOptionTableTableOrderingComposer,
    $$GlobalOptionTableTableAnnotationComposer,
    $$GlobalOptionTableTableCreateCompanionBuilder,
    $$GlobalOptionTableTableUpdateCompanionBuilder,
    (
      GlobalOptionTableData,
      BaseReferences<_$GlobalOptionDrift, $GlobalOptionTableTable,
          GlobalOptionTableData>
    ),
    GlobalOptionTableData,
    PrefetchHooks Function()> {
  $$GlobalOptionTableTableTableManager(
      _$GlobalOptionDrift db, $GlobalOptionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlobalOptionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlobalOptionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlobalOptionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tapIndex = const Value.absent(),
            Value<flutter_material.ThemeMode> themeMode = const Value.absent(),
            Value<DateTime> dbTimestamp = const Value.absent(),
          }) =>
              GlobalOptionTableCompanion(
            id: id,
            tapIndex: tapIndex,
            themeMode: themeMode,
            dbTimestamp: dbTimestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tapIndex,
            required flutter_material.ThemeMode themeMode,
            required DateTime dbTimestamp,
          }) =>
              GlobalOptionTableCompanion.insert(
            id: id,
            tapIndex: tapIndex,
            themeMode: themeMode,
            dbTimestamp: dbTimestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GlobalOptionTableTableProcessedTableManager = ProcessedTableManager<
    _$GlobalOptionDrift,
    $GlobalOptionTableTable,
    GlobalOptionTableData,
    $$GlobalOptionTableTableFilterComposer,
    $$GlobalOptionTableTableOrderingComposer,
    $$GlobalOptionTableTableAnnotationComposer,
    $$GlobalOptionTableTableCreateCompanionBuilder,
    $$GlobalOptionTableTableUpdateCompanionBuilder,
    (
      GlobalOptionTableData,
      BaseReferences<_$GlobalOptionDrift, $GlobalOptionTableTable,
          GlobalOptionTableData>
    ),
    GlobalOptionTableData,
    PrefetchHooks Function()>;

class $GlobalOptionDriftManager {
  final _$GlobalOptionDrift _db;

  $GlobalOptionDriftManager(this._db);

  $$GlobalOptionTableTableTableManager get globalOptionTable =>
      $$GlobalOptionTableTableTableManager(_db, _db.globalOptionTable);
}
