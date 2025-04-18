part of 'plato_appointment.dart';

extension PlatoAppointmentMapper on PlatoAppointment {
  syncfusion_calendar.Appointment toAppointment() {
    final startDay = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);

    return syncfusion_calendar.Appointment(
        // 일정의 시작 날짜와 끝나는 날짜가 같으면 시간까지 표시. 아닐 경우 끝나는 시간 표시
        startTime: startDay == endDay ? start : end,
        endTime: end,
        subject: title,
        notes: body,
        color: calendarColor[color],
        resourceIds: <String>[uid]);
  }

  PlatoAppointmentTableData _toData() {
    return PlatoAppointmentTableData(
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
      finished: Value(finished),
      status: Value(status),
      dataType: Value(dataType),
      color: Value(color),
    );
  }
}

extension PlatoAppointmentTableDataMapper on PlatoAppointmentTableData {
  PlatoAppointment toModel() {
    return PlatoAppointment()
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
      ..finished = finished
      ..status = Status.values.firstWhere((e) => e == status)
      ..dataType = DataType.values.firstWhere((e) => e == dataType)
      ..color = color;
  }
}

class SfCalendarDataSource extends syncfusion_calendar.CalendarDataSource {
  SfCalendarDataSource(List<PlatoAppointment> source) {
    appointments = source.map((e) => e.toAppointment()).toList();
  }

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;
}
