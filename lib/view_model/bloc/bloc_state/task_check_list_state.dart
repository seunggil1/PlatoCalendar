import 'dart:collection';

import 'package:plato_calendar/model/model.dart';

final class TaskCheckListState with ListMixin<List<PlatoAppointment>> {
  late TaskCheckListDisplayOption taskCheckListDisplayOption;
  final List<PlatoAppointment> taskCheckListPassed;
  final List<PlatoAppointment> taskCheckList6Hour;
  final List<PlatoAppointment> taskCheckList12Hour;
  final List<PlatoAppointment> taskCheckListToday;
  final List<PlatoAppointment> taskCheckListTomorrow;
  final List<PlatoAppointment> taskCheckListWeek;
  final List<PlatoAppointment> taskCheckListMoreThanWeek;
  final List<PlatoAppointment> taskCheckListComplete;

  TaskCheckListState({
    TaskCheckListDisplayOption? taskCheckListDisplayOption,
    this.taskCheckListPassed = const [],
    this.taskCheckList6Hour = const [],
    this.taskCheckList12Hour = const [],
    this.taskCheckListToday = const [],
    this.taskCheckListTomorrow = const [],
    this.taskCheckListWeek = const [],
    this.taskCheckListMoreThanWeek = const [],
    this.taskCheckListComplete = const [],
  }) {
    this.taskCheckListDisplayOption =
        taskCheckListDisplayOption ?? TaskCheckListDisplayOption();
  }

  List<List<PlatoAppointment>> get _lists => [
        taskCheckListPassed,
        taskCheckList6Hour,
        taskCheckList12Hour,
        taskCheckListToday,
        taskCheckListTomorrow,
        taskCheckListWeek,
        taskCheckListMoreThanWeek,
        taskCheckListComplete,
      ];

  @override
  int get length => _lists.length;

  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot change the length of this list.');
  }

  @override
  List<PlatoAppointment> operator [](int index) => _lists[index];

  @override
  void operator []=(int index, List<PlatoAppointment> value) {
    throw UnsupportedError('Cannot modify the lists.');
  }
}
