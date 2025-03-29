// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plato_appointment_table.dart';

// ignore_for_file: type=lint
class $PlatoAppointmentTableTable extends PlatoAppointmentTable
    with TableInfo<$PlatoAppointmentTableTable, PlatoAppointmentTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlatoAppointmentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subjectCodeMeta =
      const VerificationMeta('subjectCode');
  @override
  late final GeneratedColumn<String> subjectCode = GeneratedColumn<String>(
      'subject_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<String> year = GeneratedColumn<String>(
      'year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _semesterMeta =
      const VerificationMeta('semester');
  @override
  late final GeneratedColumn<String> semester = GeneratedColumn<String>(
      'semester', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
      'start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
      'end', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _finishedMeta =
      const VerificationMeta('finished');
  @override
  late final GeneratedColumn<bool> finished = GeneratedColumn<bool>(
      'finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("finished" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<Status, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Status>($PlatoAppointmentTableTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<DataType, String> dataType =
      GeneratedColumn<String>('data_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DataType>(
              $PlatoAppointmentTableTable.$converterdataType);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        title,
        body,
        comment,
        subjectCode,
        year,
        semester,
        start,
        end,
        createdAt,
        finished,
        status,
        dataType,
        color
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plato_appointment_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlatoAppointmentTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('subject_code')) {
      context.handle(
          _subjectCodeMeta,
          subjectCode.isAcceptableOrUnknown(
              data['subject_code']!, _subjectCodeMeta));
    } else if (isInserting) {
      context.missing(_subjectCodeMeta);
    }
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
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
          _endMeta, end.isAcceptableOrUnknown(data['end']!, _endMeta));
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('finished')) {
      context.handle(_finishedMeta,
          finished.isAcceptableOrUnknown(data['finished']!, _finishedMeta));
    } else if (isInserting) {
      context.missing(_finishedMeta);
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
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  PlatoAppointmentTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlatoAppointmentTableData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment'])!,
      subjectCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_code'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}year'])!,
      semester: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}semester'])!,
      start: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start'])!,
      end: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      finished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}finished'])!,
      status: $PlatoAppointmentTableTable.$converterstatus.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      dataType: $PlatoAppointmentTableTable.$converterdataType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}data_type'])!),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $PlatoAppointmentTableTable createAlias(String alias) {
    return $PlatoAppointmentTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, String, String> $converterstatus =
      const EnumNameConverter<Status>(Status.values);
  static JsonTypeConverter2<DataType, String, String> $converterdataType =
      const EnumNameConverter<DataType>(DataType.values);
}

class PlatoAppointmentTableData extends DataClass
    implements Insertable<PlatoAppointmentTableData> {
  final String uid;
  final String title;
  final String body;
  final String comment;
  final String subjectCode;
  final String year;
  final String semester;
  final DateTime start;
  final DateTime end;
  final DateTime createdAt;
  final bool finished;
  final Status status;
  final DataType dataType;
  final int color;
  const PlatoAppointmentTableData(
      {required this.uid,
      required this.title,
      required this.body,
      required this.comment,
      required this.subjectCode,
      required this.year,
      required this.semester,
      required this.start,
      required this.end,
      required this.createdAt,
      required this.finished,
      required this.status,
      required this.dataType,
      required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['comment'] = Variable<String>(comment);
    map['subject_code'] = Variable<String>(subjectCode);
    map['year'] = Variable<String>(year);
    map['semester'] = Variable<String>(semester);
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['finished'] = Variable<bool>(finished);
    {
      map['status'] = Variable<String>(
          $PlatoAppointmentTableTable.$converterstatus.toSql(status));
    }
    {
      map['data_type'] = Variable<String>(
          $PlatoAppointmentTableTable.$converterdataType.toSql(dataType));
    }
    map['color'] = Variable<int>(color);
    return map;
  }

  PlatoAppointmentTableCompanion toCompanion(bool nullToAbsent) {
    return PlatoAppointmentTableCompanion(
      uid: Value(uid),
      title: Value(title),
      body: Value(body),
      comment: Value(comment),
      subjectCode: Value(subjectCode),
      year: Value(year),
      semester: Value(semester),
      start: Value(start),
      end: Value(end),
      createdAt: Value(createdAt),
      finished: Value(finished),
      status: Value(status),
      dataType: Value(dataType),
      color: Value(color),
    );
  }

  factory PlatoAppointmentTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlatoAppointmentTableData(
      uid: serializer.fromJson<String>(json['uid']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      comment: serializer.fromJson<String>(json['comment']),
      subjectCode: serializer.fromJson<String>(json['subjectCode']),
      year: serializer.fromJson<String>(json['year']),
      semester: serializer.fromJson<String>(json['semester']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      finished: serializer.fromJson<bool>(json['finished']),
      status: $PlatoAppointmentTableTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      dataType: $PlatoAppointmentTableTable.$converterdataType
          .fromJson(serializer.fromJson<String>(json['dataType'])),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'comment': serializer.toJson<String>(comment),
      'subjectCode': serializer.toJson<String>(subjectCode),
      'year': serializer.toJson<String>(year),
      'semester': serializer.toJson<String>(semester),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'finished': serializer.toJson<bool>(finished),
      'status': serializer.toJson<String>(
          $PlatoAppointmentTableTable.$converterstatus.toJson(status)),
      'dataType': serializer.toJson<String>(
          $PlatoAppointmentTableTable.$converterdataType.toJson(dataType)),
      'color': serializer.toJson<int>(color),
    };
  }

  PlatoAppointmentTableData copyWith(
          {String? uid,
          String? title,
          String? body,
          String? comment,
          String? subjectCode,
          String? year,
          String? semester,
          DateTime? start,
          DateTime? end,
          DateTime? createdAt,
          bool? finished,
          Status? status,
          DataType? dataType,
          int? color}) =>
      PlatoAppointmentTableData(
        uid: uid ?? this.uid,
        title: title ?? this.title,
        body: body ?? this.body,
        comment: comment ?? this.comment,
        subjectCode: subjectCode ?? this.subjectCode,
        year: year ?? this.year,
        semester: semester ?? this.semester,
        start: start ?? this.start,
        end: end ?? this.end,
        createdAt: createdAt ?? this.createdAt,
        finished: finished ?? this.finished,
        status: status ?? this.status,
        dataType: dataType ?? this.dataType,
        color: color ?? this.color,
      );
  PlatoAppointmentTableData copyWithCompanion(
      PlatoAppointmentTableCompanion data) {
    return PlatoAppointmentTableData(
      uid: data.uid.present ? data.uid.value : this.uid,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      comment: data.comment.present ? data.comment.value : this.comment,
      subjectCode:
          data.subjectCode.present ? data.subjectCode.value : this.subjectCode,
      year: data.year.present ? data.year.value : this.year,
      semester: data.semester.present ? data.semester.value : this.semester,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      finished: data.finished.present ? data.finished.value : this.finished,
      status: data.status.present ? data.status.value : this.status,
      dataType: data.dataType.present ? data.dataType.value : this.dataType,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlatoAppointmentTableData(')
          ..write('uid: $uid, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('comment: $comment, ')
          ..write('subjectCode: $subjectCode, ')
          ..write('year: $year, ')
          ..write('semester: $semester, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('createdAt: $createdAt, ')
          ..write('finished: $finished, ')
          ..write('status: $status, ')
          ..write('dataType: $dataType, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, title, body, comment, subjectCode, year,
      semester, start, end, createdAt, finished, status, dataType, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlatoAppointmentTableData &&
          other.uid == this.uid &&
          other.title == this.title &&
          other.body == this.body &&
          other.comment == this.comment &&
          other.subjectCode == this.subjectCode &&
          other.year == this.year &&
          other.semester == this.semester &&
          other.start == this.start &&
          other.end == this.end &&
          other.createdAt == this.createdAt &&
          other.finished == this.finished &&
          other.status == this.status &&
          other.dataType == this.dataType &&
          other.color == this.color);
}

class PlatoAppointmentTableCompanion
    extends UpdateCompanion<PlatoAppointmentTableData> {
  final Value<String> uid;
  final Value<String> title;
  final Value<String> body;
  final Value<String> comment;
  final Value<String> subjectCode;
  final Value<String> year;
  final Value<String> semester;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<DateTime> createdAt;
  final Value<bool> finished;
  final Value<Status> status;
  final Value<DataType> dataType;
  final Value<int> color;
  final Value<int> rowid;
  const PlatoAppointmentTableCompanion({
    this.uid = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.comment = const Value.absent(),
    this.subjectCode = const Value.absent(),
    this.year = const Value.absent(),
    this.semester = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.finished = const Value.absent(),
    this.status = const Value.absent(),
    this.dataType = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlatoAppointmentTableCompanion.insert({
    required String uid,
    required String title,
    required String body,
    required String comment,
    required String subjectCode,
    required String year,
    required String semester,
    required DateTime start,
    required DateTime end,
    required DateTime createdAt,
    required bool finished,
    required Status status,
    required DataType dataType,
    required int color,
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        title = Value(title),
        body = Value(body),
        comment = Value(comment),
        subjectCode = Value(subjectCode),
        year = Value(year),
        semester = Value(semester),
        start = Value(start),
        end = Value(end),
        createdAt = Value(createdAt),
        finished = Value(finished),
        status = Value(status),
        dataType = Value(dataType),
        color = Value(color);
  static Insertable<PlatoAppointmentTableData> custom({
    Expression<String>? uid,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? comment,
    Expression<String>? subjectCode,
    Expression<String>? year,
    Expression<String>? semester,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<DateTime>? createdAt,
    Expression<bool>? finished,
    Expression<String>? status,
    Expression<String>? dataType,
    Expression<int>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (comment != null) 'comment': comment,
      if (subjectCode != null) 'subject_code': subjectCode,
      if (year != null) 'year': year,
      if (semester != null) 'semester': semester,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (createdAt != null) 'created_at': createdAt,
      if (finished != null) 'finished': finished,
      if (status != null) 'status': status,
      if (dataType != null) 'data_type': dataType,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlatoAppointmentTableCompanion copyWith(
      {Value<String>? uid,
      Value<String>? title,
      Value<String>? body,
      Value<String>? comment,
      Value<String>? subjectCode,
      Value<String>? year,
      Value<String>? semester,
      Value<DateTime>? start,
      Value<DateTime>? end,
      Value<DateTime>? createdAt,
      Value<bool>? finished,
      Value<Status>? status,
      Value<DataType>? dataType,
      Value<int>? color,
      Value<int>? rowid}) {
    return PlatoAppointmentTableCompanion(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      body: body ?? this.body,
      comment: comment ?? this.comment,
      subjectCode: subjectCode ?? this.subjectCode,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      start: start ?? this.start,
      end: end ?? this.end,
      createdAt: createdAt ?? this.createdAt,
      finished: finished ?? this.finished,
      status: status ?? this.status,
      dataType: dataType ?? this.dataType,
      color: color ?? this.color,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (subjectCode.present) {
      map['subject_code'] = Variable<String>(subjectCode.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (semester.present) {
      map['semester'] = Variable<String>(semester.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (finished.present) {
      map['finished'] = Variable<bool>(finished.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $PlatoAppointmentTableTable.$converterstatus.toSql(status.value));
    }
    if (dataType.present) {
      map['data_type'] = Variable<String>(
          $PlatoAppointmentTableTable.$converterdataType.toSql(dataType.value));
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
    return (StringBuffer('PlatoAppointmentTableCompanion(')
          ..write('uid: $uid, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('comment: $comment, ')
          ..write('subjectCode: $subjectCode, ')
          ..write('year: $year, ')
          ..write('semester: $semester, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('createdAt: $createdAt, ')
          ..write('finished: $finished, ')
          ..write('status: $status, ')
          ..write('dataType: $dataType, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PlatoAppointmentDrift extends GeneratedDatabase {
  _$PlatoAppointmentDrift(QueryExecutor e) : super(e);
  $PlatoAppointmentDriftManager get managers =>
      $PlatoAppointmentDriftManager(this);
  late final $PlatoAppointmentTableTable platoAppointmentTable =
      $PlatoAppointmentTableTable(this);
  late final Index status = Index(
      'status', 'CREATE INDEX status ON plato_appointment_table (status)');
  late final Index finished = Index('finished',
      'CREATE INDEX finished ON plato_appointment_table (finished)');
  late final Index end =
      Index('end', 'CREATE INDEX "end" ON plato_appointment_table ("end")');
  late final Index subjectCode = Index('subjectCode',
      'CREATE INDEX subjectCode ON plato_appointment_table (subject_code)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [platoAppointmentTable, status, finished, end, subjectCode];
}

typedef $$PlatoAppointmentTableTableCreateCompanionBuilder
    = PlatoAppointmentTableCompanion Function({
  required String uid,
  required String title,
  required String body,
  required String comment,
  required String subjectCode,
  required String year,
  required String semester,
  required DateTime start,
  required DateTime end,
  required DateTime createdAt,
  required bool finished,
  required Status status,
  required DataType dataType,
  required int color,
  Value<int> rowid,
});
typedef $$PlatoAppointmentTableTableUpdateCompanionBuilder
    = PlatoAppointmentTableCompanion Function({
  Value<String> uid,
  Value<String> title,
  Value<String> body,
  Value<String> comment,
  Value<String> subjectCode,
  Value<String> year,
  Value<String> semester,
  Value<DateTime> start,
  Value<DateTime> end,
  Value<DateTime> createdAt,
  Value<bool> finished,
  Value<Status> status,
  Value<DataType> dataType,
  Value<int> color,
  Value<int> rowid,
});

class $$PlatoAppointmentTableTableFilterComposer
    extends Composer<_$PlatoAppointmentDrift, $PlatoAppointmentTableTable> {
  $$PlatoAppointmentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subjectCode => $composableBuilder(
      column: $table.subjectCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get semester => $composableBuilder(
      column: $table.semester, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get start => $composableBuilder(
      column: $table.start, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get end => $composableBuilder(
      column: $table.end, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get finished => $composableBuilder(
      column: $table.finished, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Status, Status, String> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<DataType, DataType, String> get dataType =>
      $composableBuilder(
          column: $table.dataType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));
}

class $$PlatoAppointmentTableTableOrderingComposer
    extends Composer<_$PlatoAppointmentDrift, $PlatoAppointmentTableTable> {
  $$PlatoAppointmentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subjectCode => $composableBuilder(
      column: $table.subjectCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get semester => $composableBuilder(
      column: $table.semester, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get start => $composableBuilder(
      column: $table.start, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get end => $composableBuilder(
      column: $table.end, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get finished => $composableBuilder(
      column: $table.finished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataType => $composableBuilder(
      column: $table.dataType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));
}

class $$PlatoAppointmentTableTableAnnotationComposer
    extends Composer<_$PlatoAppointmentDrift, $PlatoAppointmentTableTable> {
  $$PlatoAppointmentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<String> get subjectCode => $composableBuilder(
      column: $table.subjectCode, builder: (column) => column);

  GeneratedColumn<String> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get semester =>
      $composableBuilder(column: $table.semester, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get finished =>
      $composableBuilder(column: $table.finished, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Status, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DataType, String> get dataType =>
      $composableBuilder(column: $table.dataType, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);
}

class $$PlatoAppointmentTableTableTableManager extends RootTableManager<
    _$PlatoAppointmentDrift,
    $PlatoAppointmentTableTable,
    PlatoAppointmentTableData,
    $$PlatoAppointmentTableTableFilterComposer,
    $$PlatoAppointmentTableTableOrderingComposer,
    $$PlatoAppointmentTableTableAnnotationComposer,
    $$PlatoAppointmentTableTableCreateCompanionBuilder,
    $$PlatoAppointmentTableTableUpdateCompanionBuilder,
    (
      PlatoAppointmentTableData,
      BaseReferences<_$PlatoAppointmentDrift, $PlatoAppointmentTableTable,
          PlatoAppointmentTableData>
    ),
    PlatoAppointmentTableData,
    PrefetchHooks Function()> {
  $$PlatoAppointmentTableTableTableManager(
      _$PlatoAppointmentDrift db, $PlatoAppointmentTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlatoAppointmentTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PlatoAppointmentTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlatoAppointmentTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<String> comment = const Value.absent(),
            Value<String> subjectCode = const Value.absent(),
            Value<String> year = const Value.absent(),
            Value<String> semester = const Value.absent(),
            Value<DateTime> start = const Value.absent(),
            Value<DateTime> end = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> finished = const Value.absent(),
            Value<Status> status = const Value.absent(),
            Value<DataType> dataType = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlatoAppointmentTableCompanion(
            uid: uid,
            title: title,
            body: body,
            comment: comment,
            subjectCode: subjectCode,
            year: year,
            semester: semester,
            start: start,
            end: end,
            createdAt: createdAt,
            finished: finished,
            status: status,
            dataType: dataType,
            color: color,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String title,
            required String body,
            required String comment,
            required String subjectCode,
            required String year,
            required String semester,
            required DateTime start,
            required DateTime end,
            required DateTime createdAt,
            required bool finished,
            required Status status,
            required DataType dataType,
            required int color,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlatoAppointmentTableCompanion.insert(
            uid: uid,
            title: title,
            body: body,
            comment: comment,
            subjectCode: subjectCode,
            year: year,
            semester: semester,
            start: start,
            end: end,
            createdAt: createdAt,
            finished: finished,
            status: status,
            dataType: dataType,
            color: color,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlatoAppointmentTableTableProcessedTableManager
    = ProcessedTableManager<
        _$PlatoAppointmentDrift,
        $PlatoAppointmentTableTable,
        PlatoAppointmentTableData,
        $$PlatoAppointmentTableTableFilterComposer,
        $$PlatoAppointmentTableTableOrderingComposer,
        $$PlatoAppointmentTableTableAnnotationComposer,
        $$PlatoAppointmentTableTableCreateCompanionBuilder,
        $$PlatoAppointmentTableTableUpdateCompanionBuilder,
        (
          PlatoAppointmentTableData,
          BaseReferences<_$PlatoAppointmentDrift, $PlatoAppointmentTableTable,
              PlatoAppointmentTableData>
        ),
        PlatoAppointmentTableData,
        PrefetchHooks Function()>;

class $PlatoAppointmentDriftManager {
  final _$PlatoAppointmentDrift _db;
  $PlatoAppointmentDriftManager(this._db);
  $$PlatoAppointmentTableTableTableManager get platoAppointmentTable =>
      $$PlatoAppointmentTableTableTableManager(_db, _db.platoAppointmentTable);
}
