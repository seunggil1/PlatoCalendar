import 'dart:collection';

import 'package:plato_calendar/model/model.dart';

final class TodoListState with ListMixin<List<PlatoAppointment>> {
  TaskCheckListDisplayOption taskCheckListDisplayOption;

  final List<String> subjectCodeList;
  final String subjectCodeFilter;
  final List<PlatoAppointment> taskCheckListPassed;
  final List<PlatoAppointment> taskCheckList6Hour;
  final List<PlatoAppointment> taskCheckList12Hour;
  final List<PlatoAppointment> taskCheckListToday;
  final List<PlatoAppointment> taskCheckListTomorrow;
  final List<PlatoAppointment> taskCheckListWeek;
  final List<PlatoAppointment> taskCheckListMoreThanWeek;
  final List<PlatoAppointment> taskCheckListComplete;

  TodoListState({
    TaskCheckListDisplayOption? taskCheckListDisplayOption,
    String? subjectCodeFilter,
    this.subjectCodeList = const ['전체'],
    this.taskCheckListPassed = const [],
    this.taskCheckList6Hour = const [],
    this.taskCheckList12Hour = const [],
    this.taskCheckListToday = const [],
    this.taskCheckListTomorrow = const [],
    this.taskCheckListWeek = const [],
    this.taskCheckListMoreThanWeek = const [],
    this.taskCheckListComplete = const [],
  }) : taskCheckListDisplayOption = taskCheckListDisplayOption ?? TaskCheckListDisplayOption(),
       subjectCodeFilter = subjectCodeFilter ?? subjectCodeList[0];

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
