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
  static const VerificationMeta _successMeta =
      const VerificationMeta('success');
  @override
  late final GeneratedColumn<bool> success = GeneratedColumn<bool>(
      'success', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("success" IN (0, 1))'),
      defaultValue: Constant(true));
  static const VerificationMeta _platoSyncTimeMeta =
      const VerificationMeta('platoSyncTime');
  @override
  late final GeneratedColumn<DateTime> platoSyncTime =
      GeneratedColumn<DateTime>('plato_sync_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _failReasonMeta =
      const VerificationMeta('failReason');
  @override
  late final GeneratedColumn<String> failReason = GeneratedColumn<String>(
      'fail_reason', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, success, platoSyncTime, failReason];
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
    if (data.containsKey('success')) {
      context.handle(_successMeta,
          success.isAcceptableOrUnknown(data['success']!, _successMeta));
    }
    if (data.containsKey('plato_sync_time')) {
      context.handle(
          _platoSyncTimeMeta,
          platoSyncTime.isAcceptableOrUnknown(
              data['plato_sync_time']!, _platoSyncTimeMeta));
    } else if (isInserting) {
      context.missing(_platoSyncTimeMeta);
    }
    if (data.containsKey('fail_reason')) {
      context.handle(
          _failReasonMeta,
          failReason.isAcceptableOrUnknown(
              data['fail_reason']!, _failReasonMeta));
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
      success: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}success'])!,
      platoSyncTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}plato_sync_time'])!,
      failReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fail_reason'])!,
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
  final bool success;
  final DateTime platoSyncTime;
  final String failReason;
  const SyncInfoTableData(
      {required this.id,
      required this.success,
      required this.platoSyncTime,
      required this.failReason});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['success'] = Variable<bool>(success);
    map['plato_sync_time'] = Variable<DateTime>(platoSyncTime);
    map['fail_reason'] = Variable<String>(failReason);
    return map;
  }

  SyncInfoTableCompanion toCompanion(bool nullToAbsent) {
    return SyncInfoTableCompanion(
      id: Value(id),
      success: Value(success),
      platoSyncTime: Value(platoSyncTime),
      failReason: Value(failReason),
    );
  }

  factory SyncInfoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncInfoTableData(
      id: serializer.fromJson<int>(json['id']),
      success: serializer.fromJson<bool>(json['success']),
      platoSyncTime: serializer.fromJson<DateTime>(json['platoSyncTime']),
      failReason: serializer.fromJson<String>(json['failReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'success': serializer.toJson<bool>(success),
      'platoSyncTime': serializer.toJson<DateTime>(platoSyncTime),
      'failReason': serializer.toJson<String>(failReason),
    };
  }

  SyncInfoTableData copyWith(
          {int? id,
          bool? success,
          DateTime? platoSyncTime,
          String? failReason}) =>
      SyncInfoTableData(
        id: id ?? this.id,
        success: success ?? this.success,
        platoSyncTime: platoSyncTime ?? this.platoSyncTime,
        failReason: failReason ?? this.failReason,
      );
  SyncInfoTableData copyWithCompanion(SyncInfoTableCompanion data) {
    return SyncInfoTableData(
      id: data.id.present ? data.id.value : this.id,
      success: data.success.present ? data.success.value : this.success,
      platoSyncTime: data.platoSyncTime.present
          ? data.platoSyncTime.value
          : this.platoSyncTime,
      failReason:
          data.failReason.present ? data.failReason.value : this.failReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncInfoTableData(')
          ..write('id: $id, ')
          ..write('success: $success, ')
          ..write('platoSyncTime: $platoSyncTime, ')
          ..write('failReason: $failReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, success, platoSyncTime, failReason);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncInfoTableData &&
          other.id == this.id &&
          other.success == this.success &&
          other.platoSyncTime == this.platoSyncTime &&
          other.failReason == this.failReason);
}

class SyncInfoTableCompanion extends UpdateCompanion<SyncInfoTableData> {
  final Value<int> id;
  final Value<bool> success;
  final Value<DateTime> platoSyncTime;
  final Value<String> failReason;
  const SyncInfoTableCompanion({
    this.id = const Value.absent(),
    this.success = const Value.absent(),
    this.platoSyncTime = const Value.absent(),
    this.failReason = const Value.absent(),
  });
  SyncInfoTableCompanion.insert({
    this.id = const Value.absent(),
    this.success = const Value.absent(),
    required DateTime platoSyncTime,
    this.failReason = const Value.absent(),
  }) : platoSyncTime = Value(platoSyncTime);
  static Insertable<SyncInfoTableData> custom({
    Expression<int>? id,
    Expression<bool>? success,
    Expression<DateTime>? platoSyncTime,
    Expression<String>? failReason,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (success != null) 'success': success,
      if (platoSyncTime != null) 'plato_sync_time': platoSyncTime,
      if (failReason != null) 'fail_reason': failReason,
    });
  }

  SyncInfoTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? success,
      Value<DateTime>? platoSyncTime,
      Value<String>? failReason}) {
    return SyncInfoTableCompanion(
      id: id ?? this.id,
      success: success ?? this.success,
      platoSyncTime: platoSyncTime ?? this.platoSyncTime,
      failReason: failReason ?? this.failReason,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (success.present) {
      map['success'] = Variable<bool>(success.value);
    }
    if (platoSyncTime.present) {
      map['plato_sync_time'] = Variable<DateTime>(platoSyncTime.value);
    }
    if (failReason.present) {
      map['fail_reason'] = Variable<String>(failReason.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('success: $success, ')
          ..write('platoSyncTime: $platoSyncTime, ')
          ..write('failReason: $failReason')
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
  Value<bool> success,
  required DateTime platoSyncTime,
  Value<String> failReason,
});
typedef $$SyncInfoTableTableUpdateCompanionBuilder = SyncInfoTableCompanion
    Function({
  Value<int> id,
  Value<bool> success,
  Value<DateTime> platoSyncTime,
  Value<String> failReason,
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

  ColumnFilters<bool> get success => $composableBuilder(
      column: $table.success, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get platoSyncTime => $composableBuilder(
      column: $table.platoSyncTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get failReason => $composableBuilder(
      column: $table.failReason, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<bool> get success => $composableBuilder(
      column: $table.success, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get platoSyncTime => $composableBuilder(
      column: $table.platoSyncTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get failReason => $composableBuilder(
      column: $table.failReason, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<bool> get success =>
      $composableBuilder(column: $table.success, builder: (column) => column);

  GeneratedColumn<DateTime> get platoSyncTime => $composableBuilder(
      column: $table.platoSyncTime, builder: (column) => column);

  GeneratedColumn<String> get failReason => $composableBuilder(
      column: $table.failReason, builder: (column) => column);
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
            Value<bool> success = const Value.absent(),
            Value<DateTime> platoSyncTime = const Value.absent(),
            Value<String> failReason = const Value.absent(),
          }) =>
              SyncInfoTableCompanion(
            id: id,
            success: success,
            platoSyncTime: platoSyncTime,
            failReason: failReason,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> success = const Value.absent(),
            required DateTime platoSyncTime,
            Value<String> failReason = const Value.absent(),
          }) =>
              SyncInfoTableCompanion.insert(
            id: id,
            success: success,
            platoSyncTime: platoSyncTime,
            failReason: failReason,
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
