// Dart imports:
import 'dart:collection';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/etc/subject_code.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'bloc_event/bloc_event.dart';
import 'bloc_state/bloc_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState()) {
    PlatoAppointmentDB.dbUpdatedStream.listen((_) async {
      add(LoadTodoList());
    });
    TaskCheckListDisplayOptionDB.dbUpdatedStream.listen((_) async {
      add(LoadTodoList());
    });

    on<LoadTodoList>((event, emit) async {
      final taskCheckListDisplayOption =
          await TaskCheckListDisplayOptionDB.read();
      final subjectCodeList = await PlatoAppointmentDB.readAllSubjectCode();

      String subjectCodeFilter =
          event.subjectCodeFilter ?? state.subjectCodeFilter;

      if (!subjectCodeList.contains(state.subjectCodeFilter)) {
        subjectCodeFilter = subjectCodeAll;
      }

      final data = await _readData(
          subjectCodeList: subjectCodeList.toList(growable: false),
          option: taskCheckListDisplayOption,
          subjectCodeFilter: subjectCodeFilter);

      emit(data);
    });

    on<UpdateTodo>((event, emit) async {
      await PlatoAppointmentDB.write(event.appointment);
    });

    on<ChangeTodoDisplayOption>((event, emit) async {
      TaskCheckListDisplayOption nextOption =
          state.taskCheckListDisplayOption.copyWith();
      nextOption.showToDoList[event.changeIndex] =
          !nextOption.showToDoList[event.changeIndex];

      await TaskCheckListDisplayOptionDB.write(nextOption);
    });
  }
}

Future<TodoListState> _readData(
    {required List<String> subjectCodeList,
    required TaskCheckListDisplayOption option,
    required String subjectCodeFilter}) async {
  final readRequestList = [];

  option.showToDoList.asMap().forEach((index, show) {
    readRequestList.add(toDoListMapper[index]);

    // 만약 displayOption이 true인 것만 requestList에 추가할거면
    // if (show) {
    //   readRequestList.add(toDoListMapper[index]);
    // }
  });

  final List<List<PlatoAppointment>> appointmentList =
      await Future.wait(readRequestList.map((e) => e(subjectCodeFilter)));
  final Queue<List<PlatoAppointment>> appointmentListQueue =
      Queue.from(appointmentList);

  // displayOption이 false인 것은 빈 리스트로 채워서 반환
  final data = <List<PlatoAppointment>>[];
  option.showToDoList.asMap().forEach((index, show) {
    data.add(appointmentListQueue.removeFirst());
    // if (show) {
    //   data.add(appointmentListQueue.removeFirst());
    // } else {
    //   data.add(<PlatoAppointment>[]);
    // }
  });

  final result = TodoListState(
    subjectCodeList: subjectCodeList,
    subjectCodeFilter: subjectCodeFilter,
    taskCheckListDisplayOption: option,
    taskCheckListPassed: data[0],
    taskCheckList6Hour: data[1],
    taskCheckList12Hour: data[2],
    taskCheckListToday: data[3],
    taskCheckListTomorrow: data[4],
    taskCheckListWeek: data[5],
    taskCheckListMoreThanWeek: data[6],
    taskCheckListComplete: data[7],
  );

  return result;
}

final toDoListMapper = {
  0: PlatoAppointmentDB.readPastPlatoAppointment,
  1: PlatoAppointmentDB.readPlatoAppointmentWithin6Hours,
  2: PlatoAppointmentDB.readPlatoAppointmentWithin12Hours,
  3: PlatoAppointmentDB.readTodayPlatoAppointment,
  4: PlatoAppointmentDB.readTomorrowPlatoAppointment,
  5: PlatoAppointmentDB.readPlatoAppointmentWithinWeek,
  6: PlatoAppointmentDB.readPlatoAppointmentMoreThanWeek,
  7: PlatoAppointmentDB.readCompletePlatoAppointment
};
