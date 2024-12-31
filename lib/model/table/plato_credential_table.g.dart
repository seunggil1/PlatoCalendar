// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plato_credential_table.dart';

// ignore_for_file: type=lint
class $PlatoCredentialTableTable extends PlatoCredentialTable
    with TableInfo<$PlatoCredentialTableTable, PlatoCredentialTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $PlatoCredentialTableTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dbTimestampMeta =
      const VerificationMeta('dbTimestamp');
  @override
  late final GeneratedColumn<DateTime> dbTimestamp = GeneratedColumn<DateTime>(
      'db_timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns => [id, username, password, dbTimestamp];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'plato_credential_table';

  @override
  VerificationContext validateIntegrity(
      Insertable<PlatoCredentialTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
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
  PlatoCredentialTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlatoCredentialTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      dbTimestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}db_timestamp'])!,
    );
  }

  @override
  $PlatoCredentialTableTable createAlias(String alias) {
    return $PlatoCredentialTableTable(attachedDatabase, alias);
  }
}

class PlatoCredentialTableData extends DataClass
    implements Insertable<PlatoCredentialTableData> {
  final int id;
  final String username;
  final String password;
  final DateTime dbTimestamp;

  const PlatoCredentialTableData(
      {required this.id,
      required this.username,
      required this.password,
      required this.dbTimestamp});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['db_timestamp'] = Variable<DateTime>(dbTimestamp);
    return map;
  }

  PlatoCredentialTableCompanion toCompanion(bool nullToAbsent) {
    return PlatoCredentialTableCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      dbTimestamp: Value(dbTimestamp),
    );
  }

  factory PlatoCredentialTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlatoCredentialTableData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      dbTimestamp: serializer.fromJson<DateTime>(json['dbTimestamp']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'dbTimestamp': serializer.toJson<DateTime>(dbTimestamp),
    };
  }

  PlatoCredentialTableData copyWith(
          {int? id,
          String? username,
          String? password,
          DateTime? dbTimestamp}) =>
      PlatoCredentialTableData(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        dbTimestamp: dbTimestamp ?? this.dbTimestamp,
      );

  PlatoCredentialTableData copyWithCompanion(
      PlatoCredentialTableCompanion data) {
    return PlatoCredentialTableData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      dbTimestamp:
          data.dbTimestamp.present ? data.dbTimestamp.value : this.dbTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlatoCredentialTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, dbTimestamp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlatoCredentialTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.dbTimestamp == this.dbTimestamp);
}

class PlatoCredentialTableCompanion
    extends UpdateCompanion<PlatoCredentialTableData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<DateTime> dbTimestamp;

  const PlatoCredentialTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.dbTimestamp = const Value.absent(),
  });

  PlatoCredentialTableCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required DateTime dbTimestamp,
  })  : username = Value(username),
        password = Value(password),
        dbTimestamp = Value(dbTimestamp);

  static Insertable<PlatoCredentialTableData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<DateTime>? dbTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (dbTimestamp != null) 'db_timestamp': dbTimestamp,
    });
  }

  PlatoCredentialTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<DateTime>? dbTimestamp}) {
    return PlatoCredentialTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      dbTimestamp: dbTimestamp ?? this.dbTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (dbTimestamp.present) {
      map['db_timestamp'] = Variable<DateTime>(dbTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlatoCredentialTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('dbTimestamp: $dbTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$PlatoCredentialDrift extends GeneratedDatabase {
  _$PlatoCredentialDrift(QueryExecutor e) : super(e);

  $PlatoCredentialDriftManager get managers =>
      $PlatoCredentialDriftManager(this);
  late final $PlatoCredentialTableTable platoCredentialTable =
      $PlatoCredentialTableTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [platoCredentialTable];
}

typedef $$PlatoCredentialTableTableCreateCompanionBuilder
    = PlatoCredentialTableCompanion Function({
  Value<int> id,
  required String username,
  required String password,
  required DateTime dbTimestamp,
});
typedef $$PlatoCredentialTableTableUpdateCompanionBuilder
    = PlatoCredentialTableCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> password,
  Value<DateTime> dbTimestamp,
});

class $$PlatoCredentialTableTableFilterComposer
    extends Composer<_$PlatoCredentialDrift, $PlatoCredentialTableTable> {
  $$PlatoCredentialTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnFilters(column));
}

class $$PlatoCredentialTableTableOrderingComposer
    extends Composer<_$PlatoCredentialDrift, $PlatoCredentialTableTable> {
  $$PlatoCredentialTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => ColumnOrderings(column));
}

class $$PlatoCredentialTableTableAnnotationComposer
    extends Composer<_$PlatoCredentialDrift, $PlatoCredentialTableTable> {
  $$PlatoCredentialTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<DateTime> get dbTimestamp => $composableBuilder(
      column: $table.dbTimestamp, builder: (column) => column);
}

class $$PlatoCredentialTableTableTableManager extends RootTableManager<
    _$PlatoCredentialDrift,
    $PlatoCredentialTableTable,
    PlatoCredentialTableData,
    $$PlatoCredentialTableTableFilterComposer,
    $$PlatoCredentialTableTableOrderingComposer,
    $$PlatoCredentialTableTableAnnotationComposer,
    $$PlatoCredentialTableTableCreateCompanionBuilder,
    $$PlatoCredentialTableTableUpdateCompanionBuilder,
    (
      PlatoCredentialTableData,
      BaseReferences<_$PlatoCredentialDrift, $PlatoCredentialTableTable,
          PlatoCredentialTableData>
    ),
    PlatoCredentialTableData,
    PrefetchHooks Function()> {
  $$PlatoCredentialTableTableTableManager(
      _$PlatoCredentialDrift db, $PlatoCredentialTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlatoCredentialTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlatoCredentialTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlatoCredentialTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<DateTime> dbTimestamp = const Value.absent(),
          }) =>
              PlatoCredentialTableCompanion(
            id: id,
            username: username,
            password: password,
            dbTimestamp: dbTimestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String password,
            required DateTime dbTimestamp,
          }) =>
              PlatoCredentialTableCompanion.insert(
            id: id,
            username: username,
            password: password,
            dbTimestamp: dbTimestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlatoCredentialTableTableProcessedTableManager
    = ProcessedTableManager<
        _$PlatoCredentialDrift,
        $PlatoCredentialTableTable,
        PlatoCredentialTableData,
        $$PlatoCredentialTableTableFilterComposer,
        $$PlatoCredentialTableTableOrderingComposer,
        $$PlatoCredentialTableTableAnnotationComposer,
        $$PlatoCredentialTableTableCreateCompanionBuilder,
        $$PlatoCredentialTableTableUpdateCompanionBuilder,
        (
          PlatoCredentialTableData,
          BaseReferences<_$PlatoCredentialDrift, $PlatoCredentialTableTable,
              PlatoCredentialTableData>
        ),
        PlatoCredentialTableData,
        PrefetchHooks Function()>;

class $PlatoCredentialDriftManager {
  final _$PlatoCredentialDrift _db;

  $PlatoCredentialDriftManager(this._db);

  $$PlatoCredentialTableTableTableManager get platoCredentialTable =>
      $$PlatoCredentialTableTableTableManager(_db, _db.platoCredentialTable);
}
