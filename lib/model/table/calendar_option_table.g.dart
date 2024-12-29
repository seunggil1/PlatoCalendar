// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_option_table.dart';

// ignore_for_file: type=lint
class $CalendarOptionTableTable extends CalendarOptionTable
    with TableInfo<$CalendarOptionTableTable, CalendarOptionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $CalendarOptionTableTable(this.attachedDatabase, [this._alias]);

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
  static const VerificationMeta _viewTypeMeta =
      const VerificationMeta('viewType');
  @override
  late final GeneratedColumnWithTypeConverter<CalendarView, String> viewType =
      GeneratedColumn<String>('view_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CalendarView>(
              $CalendarOptionTableTable.$converterviewType);
  static const VerificationMeta _appointmentDisplayModeMeta =
      const VerificationMeta('appointmentDisplayMode');
  @override
  late final GeneratedColumnWithTypeConverter<MonthAppointmentDisplayMode,
      String> appointmentDisplayMode = GeneratedColumn<String>(
          'appointment_display_mode', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true)
      .withConverter<MonthAppointmentDisplayMode>(
          $CalendarOptionTableTable.$converterappointmentDisplayMode);
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
  List<GeneratedColumn> get $columns => [
        id,
        showFinished,
        firstDayOfWeek,
        viewType,
        appointmentDisplayMode,
        showAgenda,
        dbTimestamp
      ];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_option_table';

  @override
  VerificationContext validateIntegrity(
      Insertable<CalendarOptionTableData> instance,
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
    context.handle(_viewTypeMeta, const VerificationResult.success());
    context.handle(
        _appointmentDisplayModeMeta, const VerificationResult.success());
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
  CalendarOptionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarOptionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      showFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_finished'])!,
      firstDayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}first_day_of_week'])!,
      viewType: $CalendarOptionTableTable.$converterviewType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}view_type'])!),
      appointmentDisplayMode: $CalendarOptionTableTable
          .$converterappointmentDisplayMode
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}appointment_display_mode'])!),
      showAgenda: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_agenda'])!,
      dbTimestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}db_timestamp'])!,
    );
  }

  @override
  $CalendarOptionTableTable createAlias(String alias) {
    return $CalendarOptionTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CalendarView, String, String> $converterviewType =
      const EnumNameConverter<CalendarView>(CalendarView.values);
  static JsonTypeConverter2<MonthAppointmentDisplayMode, String, String>
      $converterappointmentDisplayMode =
      const EnumNameConverter<MonthAppointmentDisplayMode>(
          MonthAppointmentDisplayMode.values);
}

class CalendarOptionTableData extends DataClass
    implements Insertable<CalendarOptionTableData> {
  final int id;
  final bool showFinished;
  final int firstDayOfWeek;
  final CalendarView viewType;
  final MonthAppointmentDisplayMode appointmentDisplayMode;
  final bool showAgenda;
  final DateTime dbTimestamp;

  const CalendarOptionTableData(
      {required this.id,
      required this.showFinished,
      required this.firstDayOfWeek,
      required this.viewType,
      required this.appointmentDisplayMode,
      required this.showAgenda,
      required this.dbTimestamp});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['show_finished'] = Variable<bool>(showFinished);
    map['first_day_of_week'] = Variable<int>(firstDayOfWeek);
    {
      map['view_type'] = Variable<String>(
          $CalendarOptionTableTable.$converterviewType.toSql(viewType));
    }
    {
      map['appointment_display_mode'] = Variable<String>(
          $CalendarOptionTableTable.$converterappointmentDisplayMode
              .toSql(appointmentDisplayMode));
    }
    map['show_agenda'] = Variable<bool>(showAgenda);
    map['db_timestamp'] = Variable<DateTime>(dbTimestamp);
    return map;
  }

  CalendarOptionTableCompanion toCompanion(bool nullToAbsent) {
    return CalendarOptionTableCompanion(
      id: Value(id),
      showFinished: Value(showFinished),
      firstDayOfWeek: Value(firstDayOfWeek),
      viewType: Value(viewType),
      appointmentDisplayMode: Value(appointmentDisplayMode),
      showAgenda: Value(showAgenda),
      dbTimestamp: Value(dbTimestamp),
    );
  }

  factory CalendarOptionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarOptionTableData(
      id: serializer.fromJson<int>(json['id']),
      showFinished: serializer.fromJson<bool>(json['showFinished']),
      firstDayOfWeek: serializer.fromJson<int>(json['firstDayOfWeek']),
      viewType: $CalendarOptionTableTable.$converterviewType
          .fromJson(serializer.fromJson<String>(json['viewType'])),
      appointmentDisplayMode:
          $CalendarOptionTableTable.$converterappointmentDisplayMode.fromJson(
              serializer.fromJson<String>(json['appointmentDisplayMode'])),
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
      'viewType': serializer.toJson<String>(
          $CalendarOptionTableTable.$converterviewType.toJson(viewType)),
      'appointmentDisplayMode': serializer.toJson<String>(
          $CalendarOptionTableTable.$converterappointmentDisplayMode
              .toJson(appointmentDisplayMode)),
      'showAgenda': serializer.toJson<bool>(showAgenda),
      'dbTimestamp': serializer.toJson<DateTime>(dbTimestamp),
    };
  }

  CalendarOptionTableData copyWith(
          {int? id,
          bool? showFinished,
          int? firstDayOfWeek,
          CalendarView? viewType,
          MonthAppointmentDisplayMode? appointmentDisplayMode,
          bool? showAgenda,
          DateTime? dbTimestamp}) =>
      CalendarOptionTableData(
        id: id ?? this.id,
        showFinished: showFinished ?? this.showFinished,
        firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
        viewType: viewType ?? this.viewType,
        appointmentDisplayMode:
            appointmentDisplayMode ?? this.appointmentDisplayMode,
        showAgenda: showAgenda ?? this.showAgenda,
        dbTimestamp: dbTimestamp ?? this.dbTimestamp,
      );

  CalendarOptionTableData copyWithCompanion(CalendarOptionTableCompanion data) {
    return CalendarOptionTableData(
      id: data.id.present ? data.id.value : this.id,
      showFinished: data.showFinished.present
          ? data.showFinished.value
          : this.showFinished,
      firstDayOfWeek: data.firstDayOfWeek.present
          ? data.firstDayOfWeek.value
          : this.firstDayOfWeek,
      viewType: data.viewType.present ? data.viewType.value : this.viewType,
      appointmentDisplayMode: data.appointmentDisplayMode.present
          ? data.appointmentDisplayMode.value
          : this.appointmentDisplayMode,
      showAgenda:
          data.showAgenda.present ? data.showAgenda.value : this.showAgenda,
      dbTimestamp:
          data.dbTimestamp.present ? data.dbTimestamp.value : this.dbTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarOptionTableData(')
          ..write('id: $id, ')
          ..write('showFinished: $showFinished, ')
          ..write('firstDayOfWeek: $firstDayOfWeek, ')
          ..write('viewType: $viewType, ')
          ..write('appointmentDisplayMode: $appointmentDisplayMode, ')
          ..write('showAgenda: $showAgenda, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, showFinished, firstDayOfWeek, viewType,
      appointmentDisplayMode, showAgenda, dbTimestamp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarOptionTableData &&
          other.id == this.id &&
          other.showFinished == this.showFinished &&
          other.firstDayOfWeek == this.firstDayOfWeek &&
          other.viewType == this.viewType &&
          other.appointmentDisplayMode == this.appointmentDisplayMode &&
          other.showAgenda == this.showAgenda &&
          other.dbTimestamp == this.dbTimestamp);
}

class CalendarOptionTableCompanion
    extends UpdateCompanion<CalendarOptionTableData> {
  final Value<int> id;
  final Value<bool> showFinished;
  final Value<int> firstDayOfWeek;
  final Value<CalendarView> viewType;
  final Value<MonthAppointmentDisplayMode> appointmentDisplayMode;
  final Value<bool> showAgenda;
  final Value<DateTime> dbTimestamp;

  const CalendarOptionTableCompanion({
    this.id = const Value.absent(),
    this.showFinished = const Value.absent(),
    this.firstDayOfWeek = const Value.absent(),
    this.viewType = const Value.absent(),
    this.appointmentDisplayMode = const Value.absent(),
    this.showAgenda = const Value.absent(),
    this.dbTimestamp = const Value.absent(),
  });

  CalendarOptionTableCompanion.insert({
    this.id = const Value.absent(),
    required bool showFinished,
    required int firstDayOfWeek,
    required CalendarView viewType,
    required MonthAppointmentDisplayMode appointmentDisplayMode,
    required bool showAgenda,
    required DateTime dbTimestamp,
  })  : showFinished = Value(showFinished),
        firstDayOfWeek = Value(firstDayOfWeek),
        viewType = Value(viewType),
        appointmentDisplayMode = Value(appointmentDisplayMode),
        showAgenda = Value(showAgenda),
        dbTimestamp = Value(dbTimestamp);

  static Insertable<CalendarOptionTableData> custom({
    Expression<int>? id,
    Expression<bool>? showFinished,
    Expression<int>? firstDayOfWeek,
    Expression<String>? viewType,
    Expression<String>? appointmentDisplayMode,
    Expression<bool>? showAgenda,
    Expression<DateTime>? dbTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (showFinished != null) 'show_finished': showFinished,
      if (firstDayOfWeek != null) 'first_day_of_week': firstDayOfWeek,
      if (viewType != null) 'view_type': viewType,
      if (appointmentDisplayMode != null)
        'appointment_display_mode': appointmentDisplayMode,
      if (showAgenda != null) 'show_agenda': showAgenda,
      if (dbTimestamp != null) 'db_timestamp': dbTimestamp,
    });
  }

  CalendarOptionTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? showFinished,
      Value<int>? firstDayOfWeek,
      Value<CalendarView>? viewType,
      Value<MonthAppointmentDisplayMode>? appointmentDisplayMode,
      Value<bool>? showAgenda,
      Value<DateTime>? dbTimestamp}) {
    return CalendarOptionTableCompanion(
      id: id ?? this.id,
      showFinished: showFinished ?? this.showFinished,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      viewType: viewType ?? this.viewType,
      appointmentDisplayMode:
          appointmentDisplayMode ?? this.appointmentDisplayMode,
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
    if (viewType.present) {
      map['view_type'] = Variable<String>(
          $CalendarOptionTableTable.$converterviewType.toSql(viewType.value));
    }
    if (appointmentDisplayMode.present) {
      map['appointment_display_mode'] = Variable<String>(
          $CalendarOptionTableTable.$converterappointmentDisplayMode
              .toSql(appointmentDisplayMode.value));
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
    return (StringBuffer('CalendarOptionTableCompanion(')
          ..write('id: $id, ')
          ..write('showFinished: $showFinished, ')
          ..write('firstDayOfWeek: $firstDayOfWeek, ')
          ..write('viewType: $viewType, ')
          ..write('appointmentDisplayMode: $appointmentDisplayMode, ')
          ..write('showAgenda: $showAgenda, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$CalendarOptionDrift extends GeneratedDatabase {
  _$CalendarOptionDrift(QueryExecutor e) : super(e);

  $CalendarOptionDriftManager get managers => $CalendarOptionDriftManager(this);
  late final $CalendarOptionTableTable calendarOptionTable =
      $CalendarOptionTableTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [calendarOptionTable];
}

typedef $$CalendarOptionTableTableCreateCompanionBuilder
    = CalendarOptionTableCompanion Function({
  Value<int> id,
  required bool showFinished,
  required int firstDayOfWeek,
  required CalendarView viewType,
  required MonthAppointmentDisplayMode appointmentDisplayMode,
  required bool showAgenda,
  required DateTime dbTimestamp,
});
typedef $$CalendarOptionTableTableUpdateCompanionBuilder
    = CalendarOptionTableCompanion Function({
  Value<int> id,
  Value<bool> showFinished,
  Value<int> firstDayOfWeek,
  Value<CalendarView> viewType,
  Value<MonthAppointmentDisplayMode> appointmentDisplayMode,
  Value<bool> showAgenda,
  Value<DateTime> dbTimestamp,
});

class $$CalendarOptionTableTableFilterComposer
    extends Composer<_$CalendarOptionDrift, $CalendarOptionTableTable> {
  $$CalendarOptionTableTableFilterComposer({
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

  ColumnWithTypeConverterFilters<CalendarView, CalendarView, String>
      get viewType => $composableBuilder(
          column: $table.viewType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<MonthAppointmentDisplayMode,
          MonthAppointmentDisplayMode, String>
      get appointmentDisplayMode => $composableBuilder(
          column: $table.appointmentDisplayMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get showAgenda => $composableBuilder(
      column: $table.showAgenda, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnFilters(column));
}

class $$CalendarOptionTableTableOrderingComposer
    extends Composer<_$CalendarOptionDrift, $CalendarOptionTableTable> {
  $$CalendarOptionTableTableOrderingComposer({
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

  ColumnOrderings<String> get viewType => $composableBuilder(
      column: $table.viewType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appointmentDisplayMode => $composableBuilder(
      column: $table.appointmentDisplayMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showAgenda => $composableBuilder(
      column: $table.showAgenda, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnOrderings(column));
}

class $$CalendarOptionTableTableAnnotationComposer
    extends Composer<_$CalendarOptionDrift, $CalendarOptionTableTable> {
  $$CalendarOptionTableTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<CalendarView, String> get viewType =>
      $composableBuilder(column: $table.viewType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MonthAppointmentDisplayMode, String>
      get appointmentDisplayMode => $composableBuilder(
          column: $table.appointmentDisplayMode, builder: (column) => column);

  GeneratedColumn<bool> get showAgenda => $composableBuilder(
      column: $table.showAgenda, builder: (column) => column);

  GeneratedColumn<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => column);
}

class $$CalendarOptionTableTableTableManager extends RootTableManager<
    _$CalendarOptionDrift,
    $CalendarOptionTableTable,
    CalendarOptionTableData,
    $$CalendarOptionTableTableFilterComposer,
    $$CalendarOptionTableTableOrderingComposer,
    $$CalendarOptionTableTableAnnotationComposer,
    $$CalendarOptionTableTableCreateCompanionBuilder,
    $$CalendarOptionTableTableUpdateCompanionBuilder,
    (
      CalendarOptionTableData,
      BaseReferences<_$CalendarOptionDrift, $CalendarOptionTableTable,
          CalendarOptionTableData>
    ),
    CalendarOptionTableData,
    PrefetchHooks Function()> {
  $$CalendarOptionTableTableTableManager(
      _$CalendarOptionDrift db, $CalendarOptionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarOptionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarOptionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarOptionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> showFinished = const Value.absent(),
            Value<int> firstDayOfWeek = const Value.absent(),
            Value<CalendarView> viewType = const Value.absent(),
            Value<MonthAppointmentDisplayMode> appointmentDisplayMode =
                const Value.absent(),
            Value<bool> showAgenda = const Value.absent(),
            Value<DateTime> dbTimestamp = const Value.absent(),
          }) =>
              CalendarOptionTableCompanion(
            id: id,
            showFinished: showFinished,
            firstDayOfWeek: firstDayOfWeek,
            viewType: viewType,
            appointmentDisplayMode: appointmentDisplayMode,
            showAgenda: showAgenda,
            dbTimestamp: dbTimestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required bool showFinished,
            required int firstDayOfWeek,
            required CalendarView viewType,
            required MonthAppointmentDisplayMode appointmentDisplayMode,
            required bool showAgenda,
            required DateTime dbTimestamp,
          }) =>
              CalendarOptionTableCompanion.insert(
            id: id,
            showFinished: showFinished,
            firstDayOfWeek: firstDayOfWeek,
            viewType: viewType,
            appointmentDisplayMode: appointmentDisplayMode,
            showAgenda: showAgenda,
            dbTimestamp: dbTimestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CalendarOptionTableTableProcessedTableManager = ProcessedTableManager<
    _$CalendarOptionDrift,
    $CalendarOptionTableTable,
    CalendarOptionTableData,
    $$CalendarOptionTableTableFilterComposer,
    $$CalendarOptionTableTableOrderingComposer,
    $$CalendarOptionTableTableAnnotationComposer,
    $$CalendarOptionTableTableCreateCompanionBuilder,
    $$CalendarOptionTableTableUpdateCompanionBuilder,
    (
      CalendarOptionTableData,
      BaseReferences<_$CalendarOptionDrift, $CalendarOptionTableTable,
          CalendarOptionTableData>
    ),
    CalendarOptionTableData,
    PrefetchHooks Function()>;

class $CalendarOptionDriftManager {
  final _$CalendarOptionDrift _db;

  $CalendarOptionDriftManager(this._db);

  $$CalendarOptionTableTableTableManager get calendarOptionTable =>
      $$CalendarOptionTableTableTableManager(_db, _db.calendarOptionTable);
}
