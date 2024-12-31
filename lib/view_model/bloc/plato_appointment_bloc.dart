import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import 'package:plato_calendar/service/service.dart';

import 'bloc_event/bloc_event.dart';

class PlatoAppointmentBloc
    extends Bloc<PlatoAppointmentEvent, List<PlatoAppointment>> {
  PlatoAppointmentBloc() : super(<PlatoAppointment>[]) {
    on<PlatoAppointmentLoading>((event, emit) async {
      await AppSyncHandler.sync();
      emit(await PlatoAppointmentDB.readAll());
    });
    on<PlatoAppointmentLoadingFinished>((event, emit) {});
  }
}
