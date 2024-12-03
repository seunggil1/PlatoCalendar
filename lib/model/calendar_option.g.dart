// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_option.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCalendarOptionCollection on Isar {
  IsarCollection<CalendarOption> get calendarOptions => this.collection();
}

const CalendarOptionSchema = CollectionSchema(
  name: r'CalendarOption',
  id: 7809966669319569900,
  properties: {
    r'calendarType': PropertySchema(
      id: 0,
      name: r'calendarType',
      type: IsarType.string,
      enumMap: _CalendarOptioncalendarTypeEnumValueMap,
    ),
    r'showFinished': PropertySchema(
      id: 1,
      name: r'showFinished',
      type: IsarType.bool,
    )
  },
  estimateSize: _calendarOptionEstimateSize,
  serialize: _calendarOptionSerialize,
  deserialize: _calendarOptionDeserialize,
  deserializeProp: _calendarOptionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _calendarOptionGetId,
  getLinks: _calendarOptionGetLinks,
  attach: _calendarOptionAttach,
  version: '3.1.0+1',
);

int _calendarOptionEstimateSize(
  CalendarOption object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.calendarType.name.length * 3;
  return bytesCount;
}

void _calendarOptionSerialize(
  CalendarOption object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.calendarType.name);
  writer.writeBool(offsets[1], object.showFinished);
}

CalendarOption _calendarOptionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CalendarOption();
  object.calendarType = _CalendarOptioncalendarTypeValueEnumMap[
          reader.readStringOrNull(offsets[0])] ??
      CalendarType.split;
  object.id = id;
  object.showFinished = reader.readBool(offsets[1]);
  return object;
}

P _calendarOptionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CalendarOptioncalendarTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CalendarType.split) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CalendarOptioncalendarTypeEnumValueMap = {
  r'split': r'split',
  r'integrated': r'integrated',
};
const _CalendarOptioncalendarTypeValueEnumMap = {
  r'split': CalendarType.split,
  r'integrated': CalendarType.integrated,
};

Id _calendarOptionGetId(CalendarOption object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _calendarOptionGetLinks(CalendarOption object) {
  return [];
}

void _calendarOptionAttach(
    IsarCollection<dynamic> col, Id id, CalendarOption object) {
  object.id = id;
}

extension CalendarOptionQueryWhereSort
    on QueryBuilder<CalendarOption, CalendarOption, QWhere> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CalendarOptionQueryWhere
    on QueryBuilder<CalendarOption, CalendarOption, QWhereClause> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause> idBetween(
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
}

extension CalendarOptionQueryFilter
    on QueryBuilder<CalendarOption, CalendarOption, QFilterCondition> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeEqualTo(
    CalendarType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calendarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeGreaterThan(
    CalendarType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calendarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeLessThan(
    CalendarType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calendarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeBetween(
    CalendarType lower,
    CalendarType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calendarType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'calendarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'calendarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'calendarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'calendarType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calendarType',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      calendarTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'calendarType',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      showFinishedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showFinished',
        value: value,
      ));
    });
  }
}

extension CalendarOptionQueryObject
    on QueryBuilder<CalendarOption, CalendarOption, QFilterCondition> {}

extension CalendarOptionQueryLinks
    on QueryBuilder<CalendarOption, CalendarOption, QFilterCondition> {}

extension CalendarOptionQuerySortBy
    on QueryBuilder<CalendarOption, CalendarOption, QSortBy> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByCalendarType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarType', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByCalendarTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarType', Sort.desc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByShowFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showFinished', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByShowFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showFinished', Sort.desc);
    });
  }
}

extension CalendarOptionQuerySortThenBy
    on QueryBuilder<CalendarOption, CalendarOption, QSortThenBy> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByCalendarType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarType', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByCalendarTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarType', Sort.desc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByShowFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showFinished', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByShowFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showFinished', Sort.desc);
    });
  }
}

extension CalendarOptionQueryWhereDistinct
    on QueryBuilder<CalendarOption, CalendarOption, QDistinct> {
  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByCalendarType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calendarType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByShowFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showFinished');
    });
  }
}

extension CalendarOptionQueryProperty
    on QueryBuilder<CalendarOption, CalendarOption, QQueryProperty> {
  QueryBuilder<CalendarOption, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CalendarOption, CalendarType, QQueryOperations>
      calendarTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calendarType');
    });
  }

  QueryBuilder<CalendarOption, bool, QQueryOperations> showFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showFinished');
    });
  }
}
