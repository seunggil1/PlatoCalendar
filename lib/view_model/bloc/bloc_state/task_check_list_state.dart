import 'package:plato_calendar/model/model.dart';

final class TaskCheckListState {
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
}
