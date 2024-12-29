import 'package:drift/drift.dart';
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/etc/school_data.dart' as school_data;
import 'package:plato_calendar/util/logger.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart'
    as syncfusion_calendar;

import 'table/table.dart';

class PlatoAppointment {
  static final logger = LoggerManager.getLogger('Model - PlatoAppointment');

  int? id;
  late String uid;
  late String title = '';
  late String body = '';
  late String comment = '';
  late String subjectCode = '';
  late String year;
  late String semester;

  late DateTime start;
  late DateTime end;

  late DateTime createdAt = DateTime.now();
  bool deleted = false;

  Status status = Status.enable;
  DataType dataType = DataType.school;

  int color = 0;

  // Constructor
  PlatoAppointment();

  PlatoAppointment.byIcsMap(Map<String, dynamic> data) {
    try {
      uid = data['uid'];
      title = data['summary'];
      title = title.replaceAll('####', ':');
      body = data['description'];
      body = body.replaceAll('####', ':');
      body = body.replaceAll('\\n', '\n');

      start = data['dtstart'].toDateTime().toUtc();
      end = data['dtend'].toDateTime().toUtc();

      // 시간에서 초 부분 0으로 자르기, 59초인 경우 sfcalendar.scheduleview에서 토요일 일정 제대로 표시 못하는 오류가 있음.
      start = start.subtract(Duration(seconds: start.second));
      end = end.subtract(Duration(seconds: end.second));

      List classInfo;
      if (data.containsKey('categories')) {
        classInfo = data['categories'][0].split('_');
      } else {
        classInfo = [
          '${school_data.year}',
          '${school_data.semester}',
          '과목 분류 없음',
          '000'
        ];
      }

      if (classInfo.length > 2) {
        year = classInfo[0];
        semester = classInfo[1];
        subjectCode = classInfo[2];
      } else {
        year = 'No data';
        semester = 'No data';
        subjectCode = classInfo[0];
      }

      // 0분인 경우 1분 빼기, 00시 마감일 때, 전날 23시 59분로 변경하는 역할을 한다.
      if (end.minute == 0) {
        if (start == end) {
          start = start.subtract(const Duration(minutes: 1));
        }
        end = end.subtract(const Duration(minutes: 1));
      }
    } catch (e, stacktrace) {
      logger.severe('Failed to create PlatoAppointment.byMap: $e', stacktrace);
      rethrow;
    }
  }

  /// CopyWith method
  PlatoAppointment copyWith({
    int? id,
    String? uid,
    String? title,
    String? body,
    String? comment,
    String? subjectCode,
    String? year,
    String? semester,
    DateTime? start,
    DateTime? end,
    DateTime? createdAt,
    bool? deleted,
    Status? status,
    DataType? dataType,
  }) {
    return PlatoAppointment()
      ..id = id ?? this.id
      ..uid = uid ?? this.uid
      ..title = title ?? this.title
      ..body = body ?? this.body
      ..comment = comment ?? this.comment
      ..subjectCode = subjectCode ?? this.subjectCode
      ..year = year ?? this.year
      ..semester = semester ?? this.semester
      ..start = start ?? this.start
      ..end = end ?? this.end
      ..createdAt = createdAt ?? this.createdAt
      ..deleted = deleted ?? this.deleted
      ..status = status ?? this.status
      ..dataType = dataType ?? this.dataType;
  }

  syncfusion_calendar.Appointment toAppointment() {
    return syncfusion_calendar.Appointment(
        startTime: start == end ? start : end,
        endTime: end,
        subject: title,
        notes: body,
        color: calendarColor[color],
        resourceIds: <int>[hashCode]);
  }

  @override
  int get hashCode => Object.hash(uid, null);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is PlatoAppointment && other.uid == uid;
  }

  @override
  String toString() {
    return 'Appointment{uid: $uid, title: $title, body: $body, comment: $comment, subjectCode: $subjectCode, year: $year, semester: $semester, start: $start, end: $end, createdAt: $createdAt, deleted: $deleted, status: $status, dataType: $dataType}';
  }
}

extension PlatoAppointmentMapper on PlatoAppointment {
  PlatoAppointmentTableData _toData() {
    return PlatoAppointmentTableData(
      id: id ?? 0,
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
      deleted: deleted,
      status: status,
      dataType: dataType,
      color: color,
    );
  }

  PlatoAppointmentTableCompanion toSchema() {
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
      deleted: Value(deleted),
      status: Value(status),
      dataType: Value(dataType),
      color: Value(color),
    );
  }
}

extension PlatoAppointmentTableDataMapper on PlatoAppointmentTableData {
  PlatoAppointment toModel() {
    return PlatoAppointment()
      ..id = id
      ..uid = uid
      ..title = title
      ..body = body
      ..comment = comment
      ..subjectCode = subjectCode
      ..year = year
      ..semester = semester
      ..start = start
      ..end = end
      ..createdAt = createdAt
      ..deleted = deleted
      ..status = Status.values.firstWhere((e) => e == status)
      ..dataType = DataType.values.firstWhere((e) => e == dataType)
      ..color = color;
  }
}
