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
    r'appointmentDisplayMode': PropertySchema(
      id: 0,
      name: r'appointmentDisplayMode',
      type: IsarType.string,
      enumMap: _CalendarOptionappointmentDisplayModeEnumValueMap,
    ),
    r'calendarType': PropertySchema(
      id: 1,
      name: r'calendarType',
      type: IsarType.string,
      enumMap: _CalendarOptioncalendarTypeEnumValueMap,
    ),
    r'dbTimestamp': PropertySchema(
      id: 2,
      name: r'dbTimestamp',
      type: IsarType.dateTime,
    ),
    r'firstDayOfWeek': PropertySchema(
      id: 3,
      name: r'firstDayOfWeek',
      type: IsarType.long,
    ),
    r'showFinished': PropertySchema(
      id: 4,
      name: r'showFinished',
      type: IsarType.bool,
    ),
    r'viewType': PropertySchema(
      id: 5,
      name: r'viewType',
      type: IsarType.string,
      enumMap: _CalendarOptionviewTypeEnumValueMap,
    )
  },
  estimateSize: _calendarOptionEstimateSize,
  serialize: _calendarOptionSerialize,
  deserialize: _calendarOptionDeserialize,
  deserializeProp: _calendarOptionDeserializeProp,
  idName: r'id',
  indexes: {
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
  bytesCount += 3 + object.appointmentDisplayMode.name.length * 3;
  bytesCount += 3 + object.calendarType.name.length * 3;
  bytesCount += 3 + object.viewType.name.length * 3;
  return bytesCount;
}

void _calendarOptionSerialize(
  CalendarOption object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appointmentDisplayMode.name);
  writer.writeString(offsets[1], object.calendarType.name);
  writer.writeDateTime(offsets[2], object.dbTimestamp);
  writer.writeLong(offsets[3], object.firstDayOfWeek);
  writer.writeBool(offsets[4], object.showFinished);
  writer.writeString(offsets[5], object.viewType.name);
}

CalendarOption _calendarOptionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CalendarOption();
  object.appointmentDisplayMode =
      _CalendarOptionappointmentDisplayModeValueEnumMap[
              reader.readStringOrNull(offsets[0])] ??
          MonthAppointmentDisplayMode.indicator;
  object.calendarType = _CalendarOptioncalendarTypeValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      CalendarType.split;
  object.dbTimestamp = reader.readDateTime(offsets[2]);
  object.firstDayOfWeek = reader.readLong(offsets[3]);
  object.id = id;
  object.showFinished = reader.readBool(offsets[4]);
  object.viewType = _CalendarOptionviewTypeValueEnumMap[
          reader.readStringOrNull(offsets[5])] ??
      CalendarView.day;
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
      return (_CalendarOptionappointmentDisplayModeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          MonthAppointmentDisplayMode.indicator) as P;
    case 1:
      return (_CalendarOptioncalendarTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CalendarType.split) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (_CalendarOptionviewTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CalendarView.day) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CalendarOptionappointmentDisplayModeEnumValueMap = {
  r'indicator': r'indicator',
  r'appointment': r'appointment',
  r'none': r'none',
};
const _CalendarOptionappointmentDisplayModeValueEnumMap = {
  r'indicator': MonthAppointmentDisplayMode.indicator,
  r'appointment': MonthAppointmentDisplayMode.appointment,
  r'none': MonthAppointmentDisplayMode.none,
};
const _CalendarOptioncalendarTypeEnumValueMap = {
  r'split': r'split',
  r'integrated': r'integrated',
};
const _CalendarOptioncalendarTypeValueEnumMap = {
  r'split': CalendarType.split,
  r'integrated': CalendarType.integrated,
};
const _CalendarOptionviewTypeEnumValueMap = {
  r'day': r'day',
  r'week': r'week',
  r'workWeek': r'workWeek',
  r'month': r'month',
  r'timelineDay': r'timelineDay',
  r'timelineWeek': r'timelineWeek',
  r'timelineWorkWeek': r'timelineWorkWeek',
  r'timelineMonth': r'timelineMonth',
  r'schedule': r'schedule',
};
const _CalendarOptionviewTypeValueEnumMap = {
  r'day': CalendarView.day,
  r'week': CalendarView.week,
  r'workWeek': CalendarView.workWeek,
  r'month': CalendarView.month,
  r'timelineDay': CalendarView.timelineDay,
  r'timelineWeek': CalendarView.timelineWeek,
  r'timelineWorkWeek': CalendarView.timelineWorkWeek,
  r'timelineMonth': CalendarView.timelineMonth,
  r'schedule': CalendarView.schedule,
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhere> anyDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dbTimestamp'),
      );
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause>
      dbTimestampEqualTo(DateTime dbTimestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dbTimestamp',
        value: [dbTimestamp],
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterWhereClause>
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

extension CalendarOptionQueryFilter
    on QueryBuilder<CalendarOption, CalendarOption, QFilterCondition> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeEqualTo(
    MonthAppointmentDisplayMode value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appointmentDisplayMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeGreaterThan(
    MonthAppointmentDisplayMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appointmentDisplayMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeLessThan(
    MonthAppointmentDisplayMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appointmentDisplayMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeBetween(
    MonthAppointmentDisplayMode lower,
    MonthAppointmentDisplayMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appointmentDisplayMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appointmentDisplayMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appointmentDisplayMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appointmentDisplayMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appointmentDisplayMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appointmentDisplayMode',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      appointmentDisplayModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appointmentDisplayMode',
        value: '',
      ));
    });
  }

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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      dbTimestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      firstDayOfWeekEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstDayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      firstDayOfWeekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstDayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      firstDayOfWeekLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstDayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      firstDayOfWeekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstDayOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeEqualTo(
    CalendarView value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeGreaterThan(
    CalendarView value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeLessThan(
    CalendarView value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeBetween(
    CalendarView lower,
    CalendarView upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewType',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterFilterCondition>
      viewTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewType',
        value: '',
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
      sortByAppointmentDisplayMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appointmentDisplayMode', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByAppointmentDisplayModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appointmentDisplayMode', Sort.desc);
    });
  }

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
      sortByDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByDbTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.desc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByFirstDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstDayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByFirstDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstDayOfWeek', Sort.desc);
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy> sortByViewType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      sortByViewTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.desc);
    });
  }
}

extension CalendarOptionQuerySortThenBy
    on QueryBuilder<CalendarOption, CalendarOption, QSortThenBy> {
  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByAppointmentDisplayMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appointmentDisplayMode', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByAppointmentDisplayModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appointmentDisplayMode', Sort.desc);
    });
  }

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

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByDbTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbTimestamp', Sort.desc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByFirstDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstDayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByFirstDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstDayOfWeek', Sort.desc);
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

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy> thenByViewType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.asc);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QAfterSortBy>
      thenByViewTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.desc);
    });
  }
}

extension CalendarOptionQueryWhereDistinct
    on QueryBuilder<CalendarOption, CalendarOption, QDistinct> {
  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByAppointmentDisplayMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appointmentDisplayMode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByCalendarType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calendarType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByDbTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dbTimestamp');
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByFirstDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstDayOfWeek');
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QDistinct>
      distinctByShowFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showFinished');
    });
  }

  QueryBuilder<CalendarOption, CalendarOption, QDistinct> distinctByViewType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'viewType', caseSensitive: caseSensitive);
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

  QueryBuilder<CalendarOption, MonthAppointmentDisplayMode, QQueryOperations>
      appointmentDisplayModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appointmentDisplayMode');
    });
  }

  QueryBuilder<CalendarOption, CalendarType, QQueryOperations>
      calendarTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calendarType');
    });
  }

  QueryBuilder<CalendarOption, DateTime, QQueryOperations>
      dbTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dbTimestamp');
    });
  }

  QueryBuilder<CalendarOption, int, QQueryOperations> firstDayOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstDayOfWeek');
    });
  }

  QueryBuilder<CalendarOption, bool, QQueryOperations> showFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showFinished');
    });
  }

  QueryBuilder<CalendarOption, CalendarView, QQueryOperations>
      viewTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'viewType');
    });
  }
}
