import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/service/service.dart';

import 'bloc_event/bloc_event.dart';

class PlatoAppointmentBloc
    extends Bloc<PlatoAppointmentEvent, List<PlatoAppointment>> {
  PlatoAppointmentBloc() : super(<PlatoAppointment>[]) {
    on<LoadDataRequest>((event, emit) async {
      emit(await PlatoAppointmentDB.readAll());
    });

    on<SyncRequest>((event, emit) async {
      await AppSyncHandler.sync();
      add(LoadDataRequest());
    });
  }
}
