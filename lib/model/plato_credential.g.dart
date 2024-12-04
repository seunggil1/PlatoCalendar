// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plato_credential.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlatoCredentialCollection on Isar {
  IsarCollection<PlatoCredential> get platoCredentials => this.collection();
}

const PlatoCredentialSchema = CollectionSchema(
  name: r'PlatoCredential',
  id: 6975083411879633438,
  properties: {
    r'dbTimestamp': PropertySchema(
      id: 0,
      name: r'dbTimestamp',
      type: IsarType.dateTime,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'password': PropertySchema(
      id: 2,
      name: r'password',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 3,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _platoCredentialEstimateSize,
  serialize: _platoCredentialSerialize,
  deserialize: _platoCredentialDeserialize,
  deserializeProp: _platoCredentialDeserializeProp,
  idName: r'id',
  indexes: {
    r'username': IndexSchema(
      id: -2899563114555695793,
      name: r'username',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'username',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'dbTimestamp': IndexSchema(
      id: -4857539644237969184,
      name: r'dbTimestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dbTimestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _platoCredentialGetId,
  getLinks: _platoCredentialGetLinks,
  attach: _platoCredentialAttach,
  version: '3.1.0+1',
);

int _platoCredentialEstimateSize(
  PlatoCredential object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.password.length * 3;
  bytesCount += 3 + object.username.length * 3;
  return bytesCount;
}

void _platoCredentialSerialize(
  PlatoCredential object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dbTimestamp);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.password);
  writer.writeString(offsets[3], object.username);
}

PlatoCredential _platoCredentialDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlatoCredential();
  object.dbTimestamp = reader.readDateTime(offsets[0]);
  object.id = id;
  object.password = reader.readString(offsets[2]);
  object.username = reader.readString(offsets[3]);
  return object;
}

P _platoCredentialDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _platoCredentialGetId(PlatoCredential object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _platoCredentialGetLinks(PlatoCredential object) {
  return [];
}

void _platoCredentialAttach(
    IsarCollection<dynamic> col, Id id, PlatoCredential object) {
  object.id = id;
}

extension PlatoCredentialByIndex on IsarCollection<PlatoCredential> {
  Future<PlatoCredential?> getByUsername(String username) {
    return getByIndex(r'username', [username]);
  }

  PlatoCredential? getByUsernameSync(String username) {
    return getByIndexSync(r'username', [username]);
  }

  Future<bool> deleteByUsername(String username) {
    return deleteByIndex(r'username', [username]);
  }

  bool deleteByUsernameSync(String username) {
    return deleteByIndexSync(r'username', [username]);
  }

  Future<List<PlatoCredential?>> getAllByUsername(List<String> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return getAllByIndex(r'username', values);
  }

  List<PlatoCredential?> getAllByUsernameSync(List<String> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'username', values);
  }

  Future<int> deleteAllByUsername(List<String> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'username', values);
  }

  int deleteAllByUsernameSync(List<String> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'username', values);
  }

  Future<Id> putByUsername(PlatoCredential object) {
    return putByIndex(r'username', object);
  }

  Id putByUsernameSync(PlatoCredential object, {bool saveLinks = true}) {
    return putByIndexSync(r'username', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUsername(List<PlatoCredential> objects) {
    return putAllByIndex(r'username', objects);
  }

  List<Id> putAllByUsernameSync(List<PlatoCredential> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'username', objects, saveLinks: saveLinks);
  }
}

extension PlatoCredentialQueryWhereSort
    on QueryBuilder<PlatoCredential, PlatoCredential, QWhere> {
  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhere> anyDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dbTimestamp'),
      );
    });
  }
}

extension PlatoCredentialQueryWhere
    on QueryBuilder<PlatoCredential, PlatoCredential, QWhereClause> {
  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      usernameEqualTo(String username) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'username',
        value: [username],
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      usernameNotEqualTo(String username) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [],
              upper: [username],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [username],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [username],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [],
              upper: [username],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      dbTimestampEqualTo(DateTime dbTimestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dbTimestamp',
        value: [dbTimestamp],
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      dbTimestampNotEqualTo(DateTime dbTimestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbTimestamp',
              lower: [],
              upper: [dbTimestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbTimestamp',
              lower: [dbTimestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbTimestamp',
              lower: [dbTimestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbTimestamp',
              lower: [],
              upper: [dbTimestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      dbTimestampGreaterThan(
    DateTime dbTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dbTimestamp',
        lower: [dbTimestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      dbTimestampLessThan(
    DateTime dbTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dbTimestamp',
        lower: [],
        upper: [dbTimestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterWhereClause>
      dbTimestampBetween(
    DateTime lowerDbTimestamp,
    DateTime upperDbTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dbTimestamp',
        lower: [lowerDbTimestamp],
        includeLower: includeLower,
        upper: [upperDbTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlatoCredentialQueryFilter
    on QueryBuilder<PlatoCredential, PlatoCredential, QFilterCondition> {
  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      dbTimestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      dbTimestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dbTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      dbTimestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dbTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      dbTimestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dbTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'password',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'password',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      passwordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterFilterCondition>
      usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension PlatoCredentialQueryObject
    on QueryBuilder<PlatoCredential, PlatoCredential, QFilterCondition> {}

extension PlatoCredentialQueryLinks
    on QueryBuilder<PlatoCredential, PlatoCredential, QFilterCondition> {}

extension PlatoCredentialQuerySortBy
    on QueryBuilder<PlatoCredential, PlatoCredential, QSortBy> {
  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByDbTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension PlatoCredentialQuerySortThenBy
    on QueryBuilder<PlatoCredential, PlatoCredential, QSortThenBy> {
  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByDbTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QAfterSortBy>
      thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension PlatoCredentialQueryWhereDistinct
    on QueryBuilder<PlatoCredential, PlatoCredential, QDistinct> {
  QueryBuilder<PlatoCredential, PlatoCredential, QDistinct>
      distinctByDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dbTimestamp');
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QDistinct> distinctByPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'password', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlatoCredential, PlatoCredential, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension PlatoCredentialQueryProperty
    on QueryBuilder<PlatoCredential, PlatoCredential, QQueryProperty> {
  QueryBuilder<PlatoCredential, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlatoCredential, DateTime, QQueryOperations>
      dbTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dbTimestamp');
    });
  }

  QueryBuilder<PlatoCredential, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<PlatoCredential, String, QQueryOperations> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<PlatoCredential, String, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
