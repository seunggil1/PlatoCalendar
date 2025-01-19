import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

import 'bloc_event/bloc_event.dart';
import 'bloc_state/bloc_state.dart';

class TaskCheckListBloc extends Bloc<TaskCheckListEvent, TaskCheckListState> {
  TaskCheckListBloc() : super(TaskCheckListState()) {
    on<TaskCheckListInitial>((event, emit) async {
      final taskCheckListDisplayOption =
          await TaskCheckListDisplayOptionDB.read();

      final data = await readData(taskCheckListDisplayOption);
      emit(data);
    });

    on<ChangeTaskCheckListDisplayOption>((event, emit) async {
      TaskCheckListDisplayOption nextOption =
          state.taskCheckListDisplayOption.copyWith();
      nextOption.showToDoList[event.changeIndex] =
          !nextOption.showToDoList[event.changeIndex];

      await TaskCheckListDisplayOptionDB.write(nextOption);
      final data = await readData(nextOption);
      emit(data);
    });
  }

  Future<TaskCheckListState> readData(TaskCheckListDisplayOption option) async {
    final readRequestList = [];

    // displayOption이 true인 것만 requestList에 추가
    option.showToDoList.asMap().forEach((index, show) {
      if (show) {
        readRequestList.add(toDoListMapper[index]);
      }
    });

    final List<List<PlatoAppointment>> appointmentList =
        await Future.wait(readRequestList.map((e) => e()));
    final Queue<List<PlatoAppointment>> appointmentListQueue =
        Queue.from(appointmentList);

    // displayOption이 false인 것은 빈 리스트로 채워서 반환
    final data = <List<PlatoAppointment>>[];
    option.showToDoList.asMap().forEach((index, show) {
      if (show) {
        data.add(appointmentListQueue.removeFirst());
      } else {
        data.add(<PlatoAppointment>[]);
      }
    });

    final result = TaskCheckListState(
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
