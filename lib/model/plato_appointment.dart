import 'package:isar/isar.dart';

import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/etc/school_data.dart' as school_data;

part 'plato_appointment.g.dart';

enum Status { enable, disable }

enum DataType { school, etc }

@collection
class PlatoAppointment {
  static final logger = LoggerManager.getLogger('Model - PlatoAppointment');

  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uid;

  late String title;
  String body = '';
  String comment = '';

  @Index()
  late String subjectCode;

  @Index()
  late String year;

  @Index()
  late String semester;

  late DateTime start;
  late DateTime end;

  DateTime createdAt = DateTime.now();
  DateTime? deletedAt;

  @Enumerated(EnumType.name)
  @Index()
  Status status = Status.enable;

  @Enumerated(EnumType.name)
  DataType dataType = DataType.school;

  int color = 0;

  // Constructor
  PlatoAppointment();

  PlatoAppointment.byMap(Map<String, dynamic> data) {
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

      if (end.hour == 0 && end.minute == 0) {
        if (start == end) start = start.subtract(Duration(minutes: 1));
        end = end.subtract(Duration(minutes: 1));
      }
    } catch (e, stacktrace) {
      logger.severe('Failed to create PlatoAppointment.byMap: $e', stacktrace);
      rethrow;
    }
  }

  /// CopyWith method
  PlatoAppointment copyWith({
    Id? id,
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
    DateTime? deletedAt,
    Status? status,
    DataType? dataType,
  }) {
    return PlatoAppointment()
      ..id = Isar.autoIncrement
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
      ..deletedAt = deletedAt ?? this.deletedAt
      ..status = status ?? this.status
      ..dataType = dataType ?? this.dataType;
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
    return 'Appointment{uid: $uid, title: $title, body: $body, comment: $comment, subjectCode: $subjectCode, year: $year, semester: $semester, start: $start, end: $end, createdAt: $createdAt, deletedAt: $deletedAt, status: $status, dataType: $dataType}';
  }
}
