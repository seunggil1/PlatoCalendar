// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_info_table.dart';

// ignore_for_file: type=lint
class $SyncInfoTableTable extends SyncInfoTable
    with TableInfo<$SyncInfoTableTable, SyncInfoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $SyncInfoTableTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _platoSyncTimeMeta =
      const VerificationMeta('platoSyncTime');
  @override
  late final GeneratedColumn<DateTime> platoSyncTime =
      GeneratedColumn<DateTime>('plato_sync_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns => [id, platoSyncTime];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'sync_info_table';

  @override
  VerificationContext validateIntegrity(Insertable<SyncInfoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plato_sync_time')) {
      context.handle(
          _platoSyncTimeMeta,
          platoSyncTime.isAcceptableOrUnknown(
              data['plato_sync_time']!, _platoSyncTimeMeta));
    } else if (isInserting) {
      context.missing(_platoSyncTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  SyncInfoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncInfoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      platoSyncTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}plato_sync_time'])!,
    );
  }

  @override
  $SyncInfoTableTable createAlias(String alias) {
    return $SyncInfoTableTable(attachedDatabase, alias);
  }
}

class SyncInfoTableData extends DataClass
    implements Insertable<SyncInfoTableData> {
  final int id;
  final DateTime platoSyncTime;

  const SyncInfoTableData({required this.id, required this.platoSyncTime});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plato_sync_time'] = Variable<DateTime>(platoSyncTime);
    return map;
  }

  SyncInfoTableCompanion toCompanion(bool nullToAbsent) {
    return SyncInfoTableCompanion(
      id: Value(id),
      platoSyncTime: Value(platoSyncTime),
    );
  }

  factory SyncInfoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncInfoTableData(
      id: serializer.fromJson<int>(json['id']),
      platoSyncTime: serializer.fromJson<DateTime>(json['platoSyncTime']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'platoSyncTime': serializer.toJson<DateTime>(platoSyncTime),
    };
  }

  SyncInfoTableData copyWith({int? id, DateTime? platoSyncTime}) =>
      SyncInfoTableData(
        id: id ?? this.id,
        platoSyncTime: platoSyncTime ?? this.platoSyncTime,
      );

  SyncInfoTableData copyWithCompanion(SyncInfoTableCompanion data) {
    return SyncInfoTableData(
      id: data.id.present ? data.id.value : this.id,
      platoSyncTime: data.platoSyncTime.present
          ? data.platoSyncTime.value
          : this.platoSyncTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncInfoTableData(')
          ..write('id: $id, ')
          ..write('platoSyncTime: $platoSyncTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, platoSyncTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncInfoTableData &&
          other.id == this.id &&
          other.platoSyncTime == this.platoSyncTime);
}

class SyncInfoTableCompanion extends UpdateCompanion<SyncInfoTableData> {
  final Value<int> id;
  final Value<DateTime> platoSyncTime;

  const SyncInfoTableCompanion({
    this.id = const Value.absent(),
    this.platoSyncTime = const Value.absent(),
  });

  SyncInfoTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime platoSyncTime,
  }) : platoSyncTime = Value(platoSyncTime);

  static Insertable<SyncInfoTableData> custom({
    Expression<int>? id,
    Expression<DateTime>? platoSyncTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (platoSyncTime != null) 'plato_sync_time': platoSyncTime,
    });
  }

  SyncInfoTableCompanion copyWith(
      {Value<int>? id, Value<DateTime>? platoSyncTime}) {
    return SyncInfoTableCompanion(
      id: id ?? this.id,
      platoSyncTime: platoSyncTime ?? this.platoSyncTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (platoSyncTime.present) {
      map['plato_sync_time'] = Variable<DateTime>(platoSyncTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('platoSyncTime: $platoSyncTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$SyncInfoDrift extends GeneratedDatabase {
  _$SyncInfoDrift(QueryExecutor e) : super(e);

  $SyncInfoDriftManager get managers => $SyncInfoDriftManager(this);
  late final $SyncInfoTableTable syncInfoTable = $SyncInfoTableTable(this);
  late final Index platoSyncTime = Index('platoSyncTime',
      'CREATE INDEX platoSyncTime ON sync_info_table (plato_sync_time)');

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [syncInfoTable, platoSyncTime];
}

typedef $$SyncInfoTableTableCreateCompanionBuilder = SyncInfoTableCompanion
    Function({
  Value<int> id,
  required DateTime platoSyncTime,
});
typedef $$SyncInfoTableTableUpdateCompanionBuilder = SyncInfoTableCompanion
    Function({
  Value<int> id,
  Value<DateTime> platoSyncTime,
});

class $$SyncInfoTableTableFilterComposer
    extends Composer<_$SyncInfoDrift, $SyncInfoTableTable> {
  $$SyncInfoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get platoSyncTime => $composableBuilder(
      column: $table.platoSyncTime, builder: (column) => ColumnFilters(column));
}

class $$SyncInfoTableTableOrderingComposer
    extends Composer<_$SyncInfoDrift, $SyncInfoTableTable> {
  $$SyncInfoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get platoSyncTime => $composableBuilder(
      column: $table.platoSyncTime,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncInfoTableTableAnnotationComposer
    extends Composer<_$SyncInfoDrift, $SyncInfoTableTable> {
  $$SyncInfoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get platoSyncTime => $composableBuilder(
      column: $table.platoSyncTime, builder: (column) => column);
}

class $$SyncInfoTableTableTableManager extends RootTableManager<
    _$SyncInfoDrift,
    $SyncInfoTableTable,
    SyncInfoTableData,
    $$SyncInfoTableTableFilterComposer,
    $$SyncInfoTableTableOrderingComposer,
    $$SyncInfoTableTableAnnotationComposer,
    $$SyncInfoTableTableCreateCompanionBuilder,
    $$SyncInfoTableTableUpdateCompanionBuilder,
    (
      SyncInfoTableData,
      BaseReferences<_$SyncInfoDrift, $SyncInfoTableTable, SyncInfoTableData>
    ),
    SyncInfoTableData,
    PrefetchHooks Function()> {
  $$SyncInfoTableTableTableManager(
      _$SyncInfoDrift db, $SyncInfoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncInfoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncInfoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncInfoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> platoSyncTime = const Value.absent(),
          }) =>
              SyncInfoTableCompanion(
            id: id,
            platoSyncTime: platoSyncTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime platoSyncTime,
          }) =>
              SyncInfoTableCompanion.insert(
            id: id,
            platoSyncTime: platoSyncTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncInfoTableTableProcessedTableManager = ProcessedTableManager<
    _$SyncInfoDrift,
    $SyncInfoTableTable,
    SyncInfoTableData,
    $$SyncInfoTableTableFilterComposer,
    $$SyncInfoTableTableOrderingComposer,
    $$SyncInfoTableTableAnnotationComposer,
    $$SyncInfoTableTableCreateCompanionBuilder,
    $$SyncInfoTableTableUpdateCompanionBuilder,
    (
      SyncInfoTableData,
      BaseReferences<_$SyncInfoDrift, $SyncInfoTableTable, SyncInfoTableData>
    ),
    SyncInfoTableData,
    PrefetchHooks Function()>;

class $SyncInfoDriftManager {
  final _$SyncInfoDrift _db;

  $SyncInfoDriftManager(this._db);

  $$SyncInfoTableTableTableManager get syncInfoTable =>
      $$SyncInfoTableTableTableManager(_db, _db.syncInfoTable);
}
