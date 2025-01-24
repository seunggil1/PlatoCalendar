import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

import 'bloc_event/bloc_event.dart';
import 'bloc_state/bloc_state.dart';

class CheckListBloc extends Bloc<TaskCheckListEvent, TaskCheckListState> {
  CheckListBloc() : super(TaskCheckListState()) {
    on<LoadTaskCheckListEvent>((event, emit) async {
      final data = await Future.wait([
        PlatoAppointmentDB.readPastPlatoAppointment(),
        PlatoAppointmentDB.readPlatoAppointmentWithin6Hours(),
        PlatoAppointmentDB.readPlatoAppointmentWithin12Hours(),
        PlatoAppointmentDB.readTodayPlatoAppointment(),
        PlatoAppointmentDB.readTomorrowPlatoAppointment(),
        PlatoAppointmentDB.readPlatoAppointmentWithinWeek(),
        PlatoAppointmentDB.readPlatoAppointmentMoreThanWeek()
      ]);

      emit(TaskCheckListState(
        taskCheckListPassed: data[0],
        taskCheckList6Hour: data[1],
        taskCheckList12Hour: data[2],
        taskCheckListToday: data[3],
        taskCheckListTomorrow: data[4],
        taskCheckListWeek: data[5],
        taskCheckListMoreThanWeek: data[6],
      ));
    });
  }
}
