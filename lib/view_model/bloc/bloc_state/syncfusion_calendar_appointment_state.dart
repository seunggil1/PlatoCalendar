import 'package:plato_calendar/model/model.dart';

final class SyncfusionCalendarAppointmentState {
  final List<String> subjectCodeList;
  final List<PlatoAppointment> appointments;

  SyncfusionCalendarAppointmentState(
      {List<String>? subjectCodeList, List<PlatoAppointment>? appointments})
      : subjectCodeList = const ['전체'],
        appointments = const <PlatoAppointment>[];
}
