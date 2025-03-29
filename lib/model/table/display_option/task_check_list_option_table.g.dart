// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_check_list_option_table.dart';

// ignore_for_file: type=lint
class $TaskCheckListOptionTableTable extends TaskCheckListOptionTable
    with
        TableInfo<$TaskCheckListOptionTableTable,
            TaskCheckListOptionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskCheckListOptionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _showPassedToDoListMeta =
      const VerificationMeta('showPassedToDoList');
  @override
  late final GeneratedColumn<bool> showPassedToDoList = GeneratedColumn<bool>(
      'show_passed_to_do_list', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_passed_to_do_list" IN (0, 1))'));
  static const VerificationMeta _show6HoursToDoListMeta =
      const VerificationMeta('show6HoursToDoList');
  @override
  late final GeneratedColumn<bool> show6HoursToDoList = GeneratedColumn<bool>(
      'show6_hours_to_do_list', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show6_hours_to_do_list" IN (0, 1))'));
  static const VerificationMeta _show12HoursToDoListMeta =
      const VerificationMeta('show12HoursToDoList');
  @override
  late final GeneratedColumn<bool> show12HoursToDoList = GeneratedColumn<bool>(
      'show12_hours_to_do_list', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show12_hours_to_do_list" IN (0, 1))'));
  static const VerificationMeta _showTodayToDoListMeta =
      const VerificationMeta('showTodayToDoList');
  @override
  late final GeneratedColumn<bool> showTodayToDoList = GeneratedColumn<bool>(
      'show_today_to_do_list', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_today_to_do_list" IN (0, 1))'));
  static const VerificationMeta _showTomorrowToDoListMeta =
      const VerificationMeta('showTomorrowToDoList');
  @override
  late final GeneratedColumn<bool> showTomorrowToDoList = GeneratedColumn<bool>(
      'show_tomorrow_to_do_list', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_tomorrow_to_do_list" IN (0, 1))'));
  static const VerificationMeta _showWeekToDoListMeta =
      const VerificationMeta('showWeekToDoList');
  @override
  late final GeneratedColumn<bool> showWeekToDoList = GeneratedColumn<bool>(
      'show_week_to_do_list', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_week_to_do_list" IN (0, 1))'));
  static const VerificationMeta _showMoreThanWeekToDoListMeta =
      const VerificationMeta('showMoreThanWeekToDoList');
  @override
  late final GeneratedColumn<bool> showMoreThanWeekToDoList =
      GeneratedColumn<bool>(
          'show_more_than_week_to_do_list', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("show_more_than_week_to_do_list" IN (0, 1))'));
  static const VerificationMeta _showCompletedToDoListMeta =
      const VerificationMeta('showCompletedToDoList');
  @override
  late final GeneratedColumn<bool> showCompletedToDoList =
      GeneratedColumn<bool>('show_completed_to_do_list', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("show_completed_to_do_list" IN (0, 1))'));
  static const VerificationMeta _dbTimestampMeta =
      const VerificationMeta('dbTimestamp');
  @override
  late final GeneratedColumn<DateTime> dbTimestamp = GeneratedColumn<DateTime>(
      'db_timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        showPassedToDoList,
        show6HoursToDoList,
        show12HoursToDoList,
        showTodayToDoList,
        showTomorrowToDoList,
        showWeekToDoList,
        showMoreThanWeekToDoList,
        showCompletedToDoList,
        dbTimestamp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_check_list_option_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaskCheckListOptionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('show_passed_to_do_list')) {
      context.handle(
          _showPassedToDoListMeta,
          showPassedToDoList.isAcceptableOrUnknown(
              data['show_passed_to_do_list']!, _showPassedToDoListMeta));
    } else if (isInserting) {
      context.missing(_showPassedToDoListMeta);
    }
    if (data.containsKey('show6_hours_to_do_list')) {
      context.handle(
          _show6HoursToDoListMeta,
          show6HoursToDoList.isAcceptableOrUnknown(
              data['show6_hours_to_do_list']!, _show6HoursToDoListMeta));
    } else if (isInserting) {
      context.missing(_show6HoursToDoListMeta);
    }
    if (data.containsKey('show12_hours_to_do_list')) {
      context.handle(
          _show12HoursToDoListMeta,
          show12HoursToDoList.isAcceptableOrUnknown(
              data['show12_hours_to_do_list']!, _show12HoursToDoListMeta));
    } else if (isInserting) {
      context.missing(_show12HoursToDoListMeta);
    }
    if (data.containsKey('show_today_to_do_list')) {
      context.handle(
          _showTodayToDoListMeta,
          showTodayToDoList.isAcceptableOrUnknown(
              data['show_today_to_do_list']!, _showTodayToDoListMeta));
    } else if (isInserting) {
      context.missing(_showTodayToDoListMeta);
    }
    if (data.containsKey('show_tomorrow_to_do_list')) {
      context.handle(
          _showTomorrowToDoListMeta,
          showTomorrowToDoList.isAcceptableOrUnknown(
              data['show_tomorrow_to_do_list']!, _showTomorrowToDoListMeta));
    } else if (isInserting) {
      context.missing(_showTomorrowToDoListMeta);
    }
    if (data.containsKey('show_week_to_do_list')) {
      context.handle(
          _showWeekToDoListMeta,
          showWeekToDoList.isAcceptableOrUnknown(
              data['show_week_to_do_list']!, _showWeekToDoListMeta));
    } else if (isInserting) {
      context.missing(_showWeekToDoListMeta);
    }
    if (data.containsKey('show_more_than_week_to_do_list')) {
      context.handle(
          _showMoreThanWeekToDoListMeta,
          showMoreThanWeekToDoList.isAcceptableOrUnknown(
              data['show_more_than_week_to_do_list']!,
              _showMoreThanWeekToDoListMeta));
    } else if (isInserting) {
      context.missing(_showMoreThanWeekToDoListMeta);
    }
    if (data.containsKey('show_completed_to_do_list')) {
      context.handle(
          _showCompletedToDoListMeta,
          showCompletedToDoList.isAcceptableOrUnknown(
              data['show_completed_to_do_list']!, _showCompletedToDoListMeta));
    } else if (isInserting) {
      context.missing(_showCompletedToDoListMeta);
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
  TaskCheckListOptionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskCheckListOptionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      showPassedToDoList: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_passed_to_do_list'])!,
      show6HoursToDoList: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show6_hours_to_do_list'])!,
      show12HoursToDoList: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}show12_hours_to_do_list'])!,
      showTodayToDoList: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_today_to_do_list'])!,
      showTomorrowToDoList: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}show_tomorrow_to_do_list'])!,
      showWeekToDoList: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_week_to_do_list'])!,
      showMoreThanWeekToDoList: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}show_more_than_week_to_do_list'])!,
      showCompletedToDoList: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}show_completed_to_do_list'])!,
      dbTimestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}db_timestamp'])!,
    );
  }

  @override
  $TaskCheckListOptionTableTable createAlias(String alias) {
    return $TaskCheckListOptionTableTable(attachedDatabase, alias);
  }
}

class TaskCheckListOptionTableData extends DataClass
    implements Insertable<TaskCheckListOptionTableData> {
  final int id;
  final bool showPassedToDoList;
  final bool show6HoursToDoList;
  final bool show12HoursToDoList;
  final bool showTodayToDoList;
  final bool showTomorrowToDoList;
  final bool showWeekToDoList;
  final bool showMoreThanWeekToDoList;
  final bool showCompletedToDoList;
  final DateTime dbTimestamp;
  const TaskCheckListOptionTableData(
      {required this.id,
      required this.showPassedToDoList,
      required this.show6HoursToDoList,
      required this.show12HoursToDoList,
      required this.showTodayToDoList,
      required this.showTomorrowToDoList,
      required this.showWeekToDoList,
      required this.showMoreThanWeekToDoList,
      required this.showCompletedToDoList,
      required this.dbTimestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['show_passed_to_do_list'] = Variable<bool>(showPassedToDoList);
    map['show6_hours_to_do_list'] = Variable<bool>(show6HoursToDoList);
    map['show12_hours_to_do_list'] = Variable<bool>(show12HoursToDoList);
    map['show_today_to_do_list'] = Variable<bool>(showTodayToDoList);
    map['show_tomorrow_to_do_list'] = Variable<bool>(showTomorrowToDoList);
    map['show_week_to_do_list'] = Variable<bool>(showWeekToDoList);
    map['show_more_than_week_to_do_list'] =
        Variable<bool>(showMoreThanWeekToDoList);
    map['show_completed_to_do_list'] = Variable<bool>(showCompletedToDoList);
    map['db_timestamp'] = Variable<DateTime>(dbTimestamp);
    return map;
  }

  TaskCheckListOptionTableCompanion toCompanion(bool nullToAbsent) {
    return TaskCheckListOptionTableCompanion(
      id: Value(id),
      showPassedToDoList: Value(showPassedToDoList),
      show6HoursToDoList: Value(show6HoursToDoList),
      show12HoursToDoList: Value(show12HoursToDoList),
      showTodayToDoList: Value(showTodayToDoList),
      showTomorrowToDoList: Value(showTomorrowToDoList),
      showWeekToDoList: Value(showWeekToDoList),
      showMoreThanWeekToDoList: Value(showMoreThanWeekToDoList),
      showCompletedToDoList: Value(showCompletedToDoList),
      dbTimestamp: Value(dbTimestamp),
    );
  }

  factory TaskCheckListOptionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskCheckListOptionTableData(
      id: serializer.fromJson<int>(json['id']),
      showPassedToDoList: serializer.fromJson<bool>(json['showPassedToDoList']),
      show6HoursToDoList: serializer.fromJson<bool>(json['show6HoursToDoList']),
      show12HoursToDoList:
          serializer.fromJson<bool>(json['show12HoursToDoList']),
      showTodayToDoList: serializer.fromJson<bool>(json['showTodayToDoList']),
      showTomorrowToDoList:
          serializer.fromJson<bool>(json['showTomorrowToDoList']),
      showWeekToDoList: serializer.fromJson<bool>(json['showWeekToDoList']),
      showMoreThanWeekToDoList:
          serializer.fromJson<bool>(json['showMoreThanWeekToDoList']),
      showCompletedToDoList:
          serializer.fromJson<bool>(json['showCompletedToDoList']),
      dbTimestamp: serializer.fromJson<DateTime>(json['dbTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'showPassedToDoList': serializer.toJson<bool>(showPassedToDoList),
      'show6HoursToDoList': serializer.toJson<bool>(show6HoursToDoList),
      'show12HoursToDoList': serializer.toJson<bool>(show12HoursToDoList),
      'showTodayToDoList': serializer.toJson<bool>(showTodayToDoList),
      'showTomorrowToDoList': serializer.toJson<bool>(showTomorrowToDoList),
      'showWeekToDoList': serializer.toJson<bool>(showWeekToDoList),
      'showMoreThanWeekToDoList':
          serializer.toJson<bool>(showMoreThanWeekToDoList),
      'showCompletedToDoList': serializer.toJson<bool>(showCompletedToDoList),
      'dbTimestamp': serializer.toJson<DateTime>(dbTimestamp),
    };
  }

  TaskCheckListOptionTableData copyWith(
          {int? id,
          bool? showPassedToDoList,
          bool? show6HoursToDoList,
          bool? show12HoursToDoList,
          bool? showTodayToDoList,
          bool? showTomorrowToDoList,
          bool? showWeekToDoList,
          bool? showMoreThanWeekToDoList,
          bool? showCompletedToDoList,
          DateTime? dbTimestamp}) =>
      TaskCheckListOptionTableData(
        id: id ?? this.id,
        showPassedToDoList: showPassedToDoList ?? this.showPassedToDoList,
        show6HoursToDoList: show6HoursToDoList ?? this.show6HoursToDoList,
        show12HoursToDoList: show12HoursToDoList ?? this.show12HoursToDoList,
        showTodayToDoList: showTodayToDoList ?? this.showTodayToDoList,
        showTomorrowToDoList: showTomorrowToDoList ?? this.showTomorrowToDoList,
        showWeekToDoList: showWeekToDoList ?? this.showWeekToDoList,
        showMoreThanWeekToDoList:
            showMoreThanWeekToDoList ?? this.showMoreThanWeekToDoList,
        showCompletedToDoList:
            showCompletedToDoList ?? this.showCompletedToDoList,
        dbTimestamp: dbTimestamp ?? this.dbTimestamp,
      );
  TaskCheckListOptionTableData copyWithCompanion(
      TaskCheckListOptionTableCompanion data) {
    return TaskCheckListOptionTableData(
      id: data.id.present ? data.id.value : this.id,
      showPassedToDoList: data.showPassedToDoList.present
          ? data.showPassedToDoList.value
          : this.showPassedToDoList,
      show6HoursToDoList: data.show6HoursToDoList.present
          ? data.show6HoursToDoList.value
          : this.show6HoursToDoList,
      show12HoursToDoList: data.show12HoursToDoList.present
          ? data.show12HoursToDoList.value
          : this.show12HoursToDoList,
      showTodayToDoList: data.showTodayToDoList.present
          ? data.showTodayToDoList.value
          : this.showTodayToDoList,
      showTomorrowToDoList: data.showTomorrowToDoList.present
          ? data.showTomorrowToDoList.value
          : this.showTomorrowToDoList,
      showWeekToDoList: data.showWeekToDoList.present
          ? data.showWeekToDoList.value
          : this.showWeekToDoList,
      showMoreThanWeekToDoList: data.showMoreThanWeekToDoList.present
          ? data.showMoreThanWeekToDoList.value
          : this.showMoreThanWeekToDoList,
      showCompletedToDoList: data.showCompletedToDoList.present
          ? data.showCompletedToDoList.value
          : this.showCompletedToDoList,
      dbTimestamp:
          data.dbTimestamp.present ? data.dbTimestamp.value : this.dbTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskCheckListOptionTableData(')
          ..write('id: $id, ')
          ..write('showPassedToDoList: $showPassedToDoList, ')
          ..write('show6HoursToDoList: $show6HoursToDoList, ')
          ..write('show12HoursToDoList: $show12HoursToDoList, ')
          ..write('showTodayToDoList: $showTodayToDoList, ')
          ..write('showTomorrowToDoList: $showTomorrowToDoList, ')
          ..write('showWeekToDoList: $showWeekToDoList, ')
          ..write('showMoreThanWeekToDoList: $showMoreThanWeekToDoList, ')
          ..write('showCompletedToDoList: $showCompletedToDoList, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      showPassedToDoList,
      show6HoursToDoList,
      show12HoursToDoList,
      showTodayToDoList,
      showTomorrowToDoList,
      showWeekToDoList,
      showMoreThanWeekToDoList,
      showCompletedToDoList,
      dbTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskCheckListOptionTableData &&
          other.id == this.id &&
          other.showPassedToDoList == this.showPassedToDoList &&
          other.show6HoursToDoList == this.show6HoursToDoList &&
          other.show12HoursToDoList == this.show12HoursToDoList &&
          other.showTodayToDoList == this.showTodayToDoList &&
          other.showTomorrowToDoList == this.showTomorrowToDoList &&
          other.showWeekToDoList == this.showWeekToDoList &&
          other.showMoreThanWeekToDoList == this.showMoreThanWeekToDoList &&
          other.showCompletedToDoList == this.showCompletedToDoList &&
          other.dbTimestamp == this.dbTimestamp);
}

class TaskCheckListOptionTableCompanion
    extends UpdateCompanion<TaskCheckListOptionTableData> {
  final Value<int> id;
  final Value<bool> showPassedToDoList;
  final Value<bool> show6HoursToDoList;
  final Value<bool> show12HoursToDoList;
  final Value<bool> showTodayToDoList;
  final Value<bool> showTomorrowToDoList;
  final Value<bool> showWeekToDoList;
  final Value<bool> showMoreThanWeekToDoList;
  final Value<bool> showCompletedToDoList;
  final Value<DateTime> dbTimestamp;
  const TaskCheckListOptionTableCompanion({
    this.id = const Value.absent(),
    this.showPassedToDoList = const Value.absent(),
    this.show6HoursToDoList = const Value.absent(),
    this.show12HoursToDoList = const Value.absent(),
    this.showTodayToDoList = const Value.absent(),
    this.showTomorrowToDoList = const Value.absent(),
    this.showWeekToDoList = const Value.absent(),
    this.showMoreThanWeekToDoList = const Value.absent(),
    this.showCompletedToDoList = const Value.absent(),
    this.dbTimestamp = const Value.absent(),
  });
  TaskCheckListOptionTableCompanion.insert({
    this.id = const Value.absent(),
    required bool showPassedToDoList,
    required bool show6HoursToDoList,
    required bool show12HoursToDoList,
    required bool showTodayToDoList,
    required bool showTomorrowToDoList,
    required bool showWeekToDoList,
    required bool showMoreThanWeekToDoList,
    required bool showCompletedToDoList,
    required DateTime dbTimestamp,
  })  : showPassedToDoList = Value(showPassedToDoList),
        show6HoursToDoList = Value(show6HoursToDoList),
        show12HoursToDoList = Value(show12HoursToDoList),
        showTodayToDoList = Value(showTodayToDoList),
        showTomorrowToDoList = Value(showTomorrowToDoList),
        showWeekToDoList = Value(showWeekToDoList),
        showMoreThanWeekToDoList = Value(showMoreThanWeekToDoList),
        showCompletedToDoList = Value(showCompletedToDoList),
        dbTimestamp = Value(dbTimestamp);
  static Insertable<TaskCheckListOptionTableData> custom({
    Expression<int>? id,
    Expression<bool>? showPassedToDoList,
    Expression<bool>? show6HoursToDoList,
    Expression<bool>? show12HoursToDoList,
    Expression<bool>? showTodayToDoList,
    Expression<bool>? showTomorrowToDoList,
    Expression<bool>? showWeekToDoList,
    Expression<bool>? showMoreThanWeekToDoList,
    Expression<bool>? showCompletedToDoList,
    Expression<DateTime>? dbTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (showPassedToDoList != null)
        'show_passed_to_do_list': showPassedToDoList,
      if (show6HoursToDoList != null)
        'show6_hours_to_do_list': show6HoursToDoList,
      if (show12HoursToDoList != null)
        'show12_hours_to_do_list': show12HoursToDoList,
      if (showTodayToDoList != null) 'show_today_to_do_list': showTodayToDoList,
      if (showTomorrowToDoList != null)
        'show_tomorrow_to_do_list': showTomorrowToDoList,
      if (showWeekToDoList != null) 'show_week_to_do_list': showWeekToDoList,
      if (showMoreThanWeekToDoList != null)
        'show_more_than_week_to_do_list': showMoreThanWeekToDoList,
      if (showCompletedToDoList != null)
        'show_completed_to_do_list': showCompletedToDoList,
      if (dbTimestamp != null) 'db_timestamp': dbTimestamp,
    });
  }

  TaskCheckListOptionTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? showPassedToDoList,
      Value<bool>? show6HoursToDoList,
      Value<bool>? show12HoursToDoList,
      Value<bool>? showTodayToDoList,
      Value<bool>? showTomorrowToDoList,
      Value<bool>? showWeekToDoList,
      Value<bool>? showMoreThanWeekToDoList,
      Value<bool>? showCompletedToDoList,
      Value<DateTime>? dbTimestamp}) {
    return TaskCheckListOptionTableCompanion(
      id: id ?? this.id,
      showPassedToDoList: showPassedToDoList ?? this.showPassedToDoList,
      show6HoursToDoList: show6HoursToDoList ?? this.show6HoursToDoList,
      show12HoursToDoList: show12HoursToDoList ?? this.show12HoursToDoList,
      showTodayToDoList: showTodayToDoList ?? this.showTodayToDoList,
      showTomorrowToDoList: showTomorrowToDoList ?? this.showTomorrowToDoList,
      showWeekToDoList: showWeekToDoList ?? this.showWeekToDoList,
      showMoreThanWeekToDoList:
          showMoreThanWeekToDoList ?? this.showMoreThanWeekToDoList,
      showCompletedToDoList:
          showCompletedToDoList ?? this.showCompletedToDoList,
      dbTimestamp: dbTimestamp ?? this.dbTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (showPassedToDoList.present) {
      map['show_passed_to_do_list'] = Variable<bool>(showPassedToDoList.value);
    }
    if (show6HoursToDoList.present) {
      map['show6_hours_to_do_list'] = Variable<bool>(show6HoursToDoList.value);
    }
    if (show12HoursToDoList.present) {
      map['show12_hours_to_do_list'] =
          Variable<bool>(show12HoursToDoList.value);
    }
    if (showTodayToDoList.present) {
      map['show_today_to_do_list'] = Variable<bool>(showTodayToDoList.value);
    }
    if (showTomorrowToDoList.present) {
      map['show_tomorrow_to_do_list'] =
          Variable<bool>(showTomorrowToDoList.value);
    }
    if (showWeekToDoList.present) {
      map['show_week_to_do_list'] = Variable<bool>(showWeekToDoList.value);
    }
    if (showMoreThanWeekToDoList.present) {
      map['show_more_than_week_to_do_list'] =
          Variable<bool>(showMoreThanWeekToDoList.value);
    }
    if (showCompletedToDoList.present) {
      map['show_completed_to_do_list'] =
          Variable<bool>(showCompletedToDoList.value);
    }
    if (dbTimestamp.present) {
      map['db_timestamp'] = Variable<DateTime>(dbTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCheckListOptionTableCompanion(')
          ..write('id: $id, ')
          ..write('showPassedToDoList: $showPassedToDoList, ')
          ..write('show6HoursToDoList: $show6HoursToDoList, ')
          ..write('show12HoursToDoList: $show12HoursToDoList, ')
          ..write('showTodayToDoList: $showTodayToDoList, ')
          ..write('showTomorrowToDoList: $showTomorrowToDoList, ')
          ..write('showWeekToDoList: $showWeekToDoList, ')
          ..write('showMoreThanWeekToDoList: $showMoreThanWeekToDoList, ')
          ..write('showCompletedToDoList: $showCompletedToDoList, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$TaskCheckListOptionDrift extends GeneratedDatabase {
  _$TaskCheckListOptionDrift(QueryExecutor e) : super(e);
  $TaskCheckListOptionDriftManager get managers =>
      $TaskCheckListOptionDriftManager(this);
  late final $TaskCheckListOptionTableTable taskCheckListOptionTable =
      $TaskCheckListOptionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [taskCheckListOptionTable];
}

typedef $$TaskCheckListOptionTableTableCreateCompanionBuilder
    = TaskCheckListOptionTableCompanion Function({
  Value<int> id,
  required bool showPassedToDoList,
  required bool show6HoursToDoList,
  required bool show12HoursToDoList,
  required bool showTodayToDoList,
  required bool showTomorrowToDoList,
  required bool showWeekToDoList,
  required bool showMoreThanWeekToDoList,
  required bool showCompletedToDoList,
  required DateTime dbTimestamp,
});
typedef $$TaskCheckListOptionTableTableUpdateCompanionBuilder
    = TaskCheckListOptionTableCompanion Function({
  Value<int> id,
  Value<bool> showPassedToDoList,
  Value<bool> show6HoursToDoList,
  Value<bool> show12HoursToDoList,
  Value<bool> showTodayToDoList,
  Value<bool> showTomorrowToDoList,
  Value<bool> showWeekToDoList,
  Value<bool> showMoreThanWeekToDoList,
  Value<bool> showCompletedToDoList,
  Value<DateTime> dbTimestamp,
});

class $$TaskCheckListOptionTableTableFilterComposer extends Composer<
    _$TaskCheckListOptionDrift, $TaskCheckListOptionTableTable> {
  $$TaskCheckListOptionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showPassedToDoList => $composableBuilder(
      column: $table.showPassedToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get show6HoursToDoList => $composableBuilder(
      column: $table.show6HoursToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get show12HoursToDoList => $composableBuilder(
      column: $table.show12HoursToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showTodayToDoList => $composableBuilder(
      column: $table.showTodayToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showTomorrowToDoList => $composableBuilder(
      column: $table.showTomorrowToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showWeekToDoList => $composableBuilder(
      column: $table.showWeekToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showMoreThanWeekToDoList => $composableBuilder(
      column: $table.showMoreThanWeekToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showCompletedToDoList => $composableBuilder(
      column: $table.showCompletedToDoList,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnFilters(column));
}

class $$TaskCheckListOptionTableTableOrderingComposer extends Composer<
    _$TaskCheckListOptionDrift, $TaskCheckListOptionTableTable> {
  $$TaskCheckListOptionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showPassedToDoList => $composableBuilder(
      column: $table.showPassedToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get show6HoursToDoList => $composableBuilder(
      column: $table.show6HoursToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get show12HoursToDoList => $composableBuilder(
      column: $table.show12HoursToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showTodayToDoList => $composableBuilder(
      column: $table.showTodayToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showTomorrowToDoList => $composableBuilder(
      column: $table.showTomorrowToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showWeekToDoList => $composableBuilder(
      column: $table.showWeekToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showMoreThanWeekToDoList => $composableBuilder(
      column: $table.showMoreThanWeekToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showCompletedToDoList => $composableBuilder(
      column: $table.showCompletedToDoList,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnOrderings(column));
}

class $$TaskCheckListOptionTableTableAnnotationComposer extends Composer<
    _$TaskCheckListOptionDrift, $TaskCheckListOptionTableTable> {
  $$TaskCheckListOptionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get showPassedToDoList => $composableBuilder(
      column: $table.showPassedToDoList, builder: (column) => column);

  GeneratedColumn<bool> get show6HoursToDoList => $composableBuilder(
      column: $table.show6HoursToDoList, builder: (column) => column);

  GeneratedColumn<bool> get show12HoursToDoList => $composableBuilder(
      column: $table.show12HoursToDoList, builder: (column) => column);

  GeneratedColumn<bool> get showTodayToDoList => $composableBuilder(
      column: $table.showTodayToDoList, builder: (column) => column);

  GeneratedColumn<bool> get showTomorrowToDoList => $composableBuilder(
      column: $table.showTomorrowToDoList, builder: (column) => column);

  GeneratedColumn<bool> get showWeekToDoList => $composableBuilder(
      column: $table.showWeekToDoList, builder: (column) => column);

  GeneratedColumn<bool> get showMoreThanWeekToDoList => $composableBuilder(
      column: $table.showMoreThanWeekToDoList, builder: (column) => column);

  GeneratedColumn<bool> get showCompletedToDoList => $composableBuilder(
      column: $table.showCompletedToDoList, builder: (column) => column);

  GeneratedColumn<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => column);
}

class $$TaskCheckListOptionTableTableTableManager extends RootTableManager<
    _$TaskCheckListOptionDrift,
    $TaskCheckListOptionTableTable,
    TaskCheckListOptionTableData,
    $$TaskCheckListOptionTableTableFilterComposer,
    $$TaskCheckListOptionTableTableOrderingComposer,
    $$TaskCheckListOptionTableTableAnnotationComposer,
    $$TaskCheckListOptionTableTableCreateCompanionBuilder,
    $$TaskCheckListOptionTableTableUpdateCompanionBuilder,
    (
      TaskCheckListOptionTableData,
      BaseReferences<_$TaskCheckListOptionDrift, $TaskCheckListOptionTableTable,
          TaskCheckListOptionTableData>
    ),
    TaskCheckListOptionTableData,
    PrefetchHooks Function()> {
  $$TaskCheckListOptionTableTableTableManager(
      _$TaskCheckListOptionDrift db, $TaskCheckListOptionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskCheckListOptionTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskCheckListOptionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskCheckListOptionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> showPassedToDoList = const Value.absent(),
            Value<bool> show6HoursToDoList = const Value.absent(),
            Value<bool> show12HoursToDoList = const Value.absent(),
            Value<bool> showTodayToDoList = const Value.absent(),
            Value<bool> showTomorrowToDoList = const Value.absent(),
            Value<bool> showWeekToDoList = const Value.absent(),
            Value<bool> showMoreThanWeekToDoList = const Value.absent(),
            Value<bool> showCompletedToDoList = const Value.absent(),
            Value<DateTime> dbTimestamp = const Value.absent(),
          }) =>
              TaskCheckListOptionTableCompanion(
            id: id,
            showPassedToDoList: showPassedToDoList,
            show6HoursToDoList: show6HoursToDoList,
            show12HoursToDoList: show12HoursToDoList,
            showTodayToDoList: showTodayToDoList,
            showTomorrowToDoList: showTomorrowToDoList,
            showWeekToDoList: showWeekToDoList,
            showMoreThanWeekToDoList: showMoreThanWeekToDoList,
            showCompletedToDoList: showCompletedToDoList,
            dbTimestamp: dbTimestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required bool showPassedToDoList,
            required bool show6HoursToDoList,
            required bool show12HoursToDoList,
            required bool showTodayToDoList,
            required bool showTomorrowToDoList,
            required bool showWeekToDoList,
            required bool showMoreThanWeekToDoList,
            required bool showCompletedToDoList,
            required DateTime dbTimestamp,
          }) =>
              TaskCheckListOptionTableCompanion.insert(
            id: id,
            showPassedToDoList: showPassedToDoList,
            show6HoursToDoList: show6HoursToDoList,
            show12HoursToDoList: show12HoursToDoList,
            showTodayToDoList: showTodayToDoList,
            showTomorrowToDoList: showTomorrowToDoList,
            showWeekToDoList: showWeekToDoList,
            showMoreThanWeekToDoList: showMoreThanWeekToDoList,
            showCompletedToDoList: showCompletedToDoList,
            dbTimestamp: dbTimestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TaskCheckListOptionTableTableProcessedTableManager
    = ProcessedTableManager<
        _$TaskCheckListOptionDrift,
        $TaskCheckListOptionTableTable,
        TaskCheckListOptionTableData,
        $$TaskCheckListOptionTableTableFilterComposer,
        $$TaskCheckListOptionTableTableOrderingComposer,
        $$TaskCheckListOptionTableTableAnnotationComposer,
        $$TaskCheckListOptionTableTableCreateCompanionBuilder,
        $$TaskCheckListOptionTableTableUpdateCompanionBuilder,
        (
          TaskCheckListOptionTableData,
          BaseReferences<_$TaskCheckListOptionDrift,
              $TaskCheckListOptionTableTable, TaskCheckListOptionTableData>
        ),
        TaskCheckListOptionTableData,
        PrefetchHooks Function()>;

class $TaskCheckListOptionDriftManager {
  final _$TaskCheckListOptionDrift _db;
  $TaskCheckListOptionDriftManager(this._db);
  $$TaskCheckListOptionTableTableTableManager get taskCheckListOptionTable =>
      $$TaskCheckListOptionTableTableTableManager(
          _db, _db.taskCheckListOptionTable);
}
