import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/service/service.dart';

import 'bloc_event/bloc_event.dart';
import 'task_check_list_bloc.dart';

class GlobalPlatoAppointmentBloc
    extends Bloc<GlobalPlatoAppointmentEvent, List<PlatoAppointment>> {
  final TaskCheckListBloc taskCheckListBloc;

  GlobalPlatoAppointmentBloc({required this.taskCheckListBloc})
      : super(<PlatoAppointment>[]) {
    on<LoadPlatoAppointment>((event, emit) async {
      emit(await PlatoAppointmentDB.readAll());
    });

    on<SyncPlatoAppointment>((event, emit) async {
      await AppSyncHandler.sync();
      add(LoadPlatoAppointment());
      taskCheckListBloc.add(LoadTaskCheckListEvent());
    });

    on<DeleteAllPlatoAppointment>((event, emit) async {
      await Future.wait([
        PlatoAppointmentDB.deleteAll(),
        SyncInfoDB.deleteAll(),
      ]);

      add(LoadPlatoAppointment());
      taskCheckListBloc.add(LoadTaskCheckListEvent());
    });
  }
}
