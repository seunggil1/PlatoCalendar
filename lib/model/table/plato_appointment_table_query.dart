part of 'plato_appointment_table.dart';

typedef PlateAppointmentQuery
    = SimpleSelectStatement<PlatoAppointmentTable, PlatoAppointmentTableData>;
typedef PlatoAppointmentResults = List<PlatoAppointmentTableData>;

extension PlatoAppointmentTableQuery on PlatoAppointmentDrift {
  PlateAppointmentQuery _addSubjectCodeFilter(
      PlateAppointmentQuery query, String subjectCode) {
    if (subjectCode != '전체') {
      query.where((t) => t.subjectCode.equals(subjectCode));
    }
    return query;
  }

  Future<List<String>> readAllSubjectCode() async {
    final query = selectOnly(platoAppointmentTable, distinct: true)
      ..addColumns([platoAppointmentTable.subjectCode]);

    final rows = await query.get();
    return rows
        .map((row) => row.read(platoAppointmentTable.subjectCode))
        .whereType<String>()
        .toList();
  }

  Future<PlatoAppointmentResults> readPastPlatoAppointment(
      String subjectCode) async {
    final before = DateTime.now().subtract(const Duration(days: 7));
    final now = DateTime.now();
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(false) &
          t.end.isBiggerThanValue(before) &
          t.end.isSmallerThanValue(now));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readPlatoAppointmentWithin6Hours(
      String subjectCode) async {
    final now = DateTime.now();
    final sixHoursLater = now.add(Duration(hours: 6));
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(false) &
          t.end.isBiggerThanValue(now) &
          t.end.isSmallerOrEqualValue(sixHoursLater));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readPlatoAppointmentWithin12Hours(
      String subjectCode) async {
    final now = DateTime.now();
    final sixHoursLater = now.add(Duration(hours: 6));
    final twelveHoursLater = now.add(Duration(hours: 12));
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(false) &
          t.end.isBiggerThanValue(sixHoursLater) &
          t.end.isSmallerOrEqualValue(twelveHoursLater));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readTodayPlatoAppointment(
      String subjectCode) async {
    final now = DateTime.now();
    final twelveHoursLater = now.add(Duration(hours: 12));
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(false) &
          t.end.isBiggerThanValue(twelveHoursLater) &
          t.end.year.equals(now.year) &
          t.end.month.equals(now.month) &
          t.end.day.equals(now.day));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readTomorrowPlatoAppointment(
      String subjectCode) async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(false) &
          t.end.year.equals(tomorrow.year) &
          t.end.month.equals(tomorrow.month) &
          t.end.day.equals(tomorrow.day));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readPlatoAppointmentWithinWeek(
      String subjectCode) async {
    final twoDaysLater = DateTime.now().add(const Duration(days: 2));
    final sixDaysLater = DateTime.now().add(const Duration(days: 6));
    // 오늘 0시(시작)
    final startDays =
        DateTime(twoDaysLater.year, twoDaysLater.month, twoDaysLater.day);
    // 7일 후의 23시 59분 59초 (또는 8일 0시 직전)
    final endOfDays = DateTime(
        sixDaysLater.year, sixDaysLater.month, sixDaysLater.day, 23, 59, 59);
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(false) &
          t.end.isBiggerThanValue(startDays) &
          t.end.isSmallerOrEqualValue(endOfDays));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readPlatoAppointmentMoreThanWeek(
      String subjectCode) async {
    final sevenDaysLater = DateTime.now().add(const Duration(days: 7));
    // 오늘 0시(시작)
    final startDays =
        DateTime(sevenDaysLater.year, sevenDaysLater.month, sevenDaysLater.day);

    final query = select(platoAppointmentTable)
      ..where(
          (t) => t.finished.equals(false) & t.end.isBiggerThanValue(startDays));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }

  Future<PlatoAppointmentResults> readCompletePlatoAppointment(
      String subjectCode) async {
    final fiveDaysBefore = DateTime.now().subtract(const Duration(days: 7));
    final query = select(platoAppointmentTable)
      ..where((t) =>
          t.finished.equals(true) & t.end.isBiggerThanValue(fiveDaysBefore));

    return await _addSubjectCodeFilter(query, subjectCode).get();
  }
}
