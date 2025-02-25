part of 'plato_appointment_table.dart';

extension PlatoAppointmentTableQuery on PlatoAppointmentDrift {
  Future<List<String>> readAllSubjectCode() async {
    final query = selectOnly(platoAppointmentTable, distinct: true)
      ..addColumns([platoAppointmentTable.subjectCode]);

    final rows = await query.get();
    return rows
        .map((row) => row.read(platoAppointmentTable.subjectCode))
        .whereType<String>()
        .toList();
  }

  Future<List<PlatoAppointmentTableData>> readPastPlatoAppointment() async {
    final before = DateTime.now().subtract(const Duration(days: 7));
    final now = DateTime.now();
    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) &
              t.end.isBiggerThanValue(before) &
              t.end.isSmallerThanValue(now)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>>
      readPlatoAppointmentWithin6Hours() async {
    final now = DateTime.now();
    final sixHoursLater = now.add(Duration(hours: 6));
    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) &
              t.end.isBiggerThanValue(now) &
              t.end.isSmallerOrEqualValue(sixHoursLater)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>>
      readPlatoAppointmentWithin12Hours() async {
    final now = DateTime.now();
    final sixHoursLater = now.add(Duration(hours: 6));
    final twelveHoursLater = now.add(Duration(hours: 12));
    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) &
              t.end.isBiggerThanValue(sixHoursLater) &
              t.end.isSmallerOrEqualValue(twelveHoursLater)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>> readTodayPlatoAppointment() async {
    final now = DateTime.now();
    final twelveHoursLater = now.add(Duration(hours: 12));

    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) &
              t.end.isBiggerThanValue(twelveHoursLater) &
              t.end.year.equals(now.year) &
              t.end.month.equals(now.month) &
              t.end.day.equals(now.day)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>> readTomorrowPlatoAppointment() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) &
              t.end.year.equals(tomorrow.year) &
              t.end.month.equals(tomorrow.month) &
              t.end.day.equals(tomorrow.day)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>>
      readPlatoAppointmentWithinWeek() async {
    final twoDaysLater = DateTime.now().add(const Duration(days: 2));
    final sixDaysLater = DateTime.now().add(const Duration(days: 6));
    // 오늘 0시(시작)
    final startDays =
        DateTime(twoDaysLater.year, twoDaysLater.month, twoDaysLater.day);
    // 7일 후의 23시 59분 59초 (또는 8일 0시 직전)
    final endOfDays = DateTime(
        sixDaysLater.year, sixDaysLater.month, sixDaysLater.day, 23, 59, 59);

    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) &
              t.end.isBiggerThanValue(startDays) &
              t.end.isSmallerOrEqualValue(endOfDays)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>>
      readPlatoAppointmentMoreThanWeek() async {
    final sevenDaysLater = DateTime.now().add(const Duration(days: 7));
    // 오늘 0시(시작)
    final startDays =
        DateTime(sevenDaysLater.year, sevenDaysLater.month, sevenDaysLater.day);

    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(false) & t.end.isBiggerThanValue(startDays)))
        .get();
  }

  Future<List<PlatoAppointmentTableData>> readCompletePlatoAppointment() async {
    final fiveDaysBefore = DateTime.now().subtract(const Duration(days: 5));
    return await (select(platoAppointmentTable)
          ..where((t) =>
              t.finished.equals(true) &
              t.end.isBiggerThanValue(fiveDaysBefore)))
        .get();
  }
}
