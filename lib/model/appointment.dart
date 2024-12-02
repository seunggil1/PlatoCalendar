import 'package:isar/isar.dart';

part 'appointment.g.dart';

enum Status { enable, disable }

enum DataType { school, etc }

@collection
class Appointment {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uid;

  late String title;
  String body = '';
  String comment = '';

  @Index()
  late String subjectCode;

  late DateTime start;
  late DateTime end;

  DateTime createdAt = DateTime.now();
  DateTime? deletedAt;

  @Enumerated(EnumType.name)
  @Index()
  Status status = Status.enable;

  @Enumerated(EnumType.name)
  DataType dataType = DataType.school;

  /// CopyWith method
  Appointment copyWith({
    Id? id,
    String? uid,
    String? title,
    String? body,
    String? comment,
    String? subjectCode,
    DateTime? start,
    DateTime? end,
    DateTime? createdAt,
    DateTime? deletedAt,
    Status? status,
    DataType? dataType,
  }) {
    return Appointment()
      ..id = Isar.autoIncrement
      ..uid = uid ?? this.uid
      ..title = title ?? this.title
      ..body = body ?? this.body
      ..comment = comment ?? this.comment
      ..subjectCode = subjectCode ?? this.subjectCode
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

    return other is Appointment && other.uid == uid;
  }

  @override
  String toString() {
    return 'Appointment{uid: $id, uid: $uid, title: $title, body: $body, comment: $comment, subjectCode: $subjectCode, start: $start, end: $end, createdAt: $createdAt, deletedAt: $deletedAt, status: $status, dataType: $dataType}';
  }
}
