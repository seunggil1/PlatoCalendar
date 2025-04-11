// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';
import './bloc_event/bloc_event.dart';
import './bloc_state/bloc_state.dart';

class SyncfusionCalendarAppointmentBloc extends Bloc<
    SyncfusionCalendarAppointmentEvent, SyncfusionCalendarAppointmentState> {
  SyncfusionCalendarAppointmentBloc(
      {List<String>? subjectCodeList, List<PlatoAppointment>? appointments})
      : super(SyncfusionCalendarAppointmentState(
            subjectCodeList: subjectCodeList, appointments: appointments)) {
    PlatoAppointmentDB.dbUpdatedStream.listen((_) async {
      add(SyncfusionCalendarAppointmentUpdate());
    });

    SyncfusionCalendarOptionDB.dbUpdatedStream.listen((_) async {
      add(SyncfusionCalendarAppointmentUpdate());
    });

    on<SyncfusionCalendarAppointmentUpdate>((event, emit) async {
      final showFinished = await SyncfusionCalendarOptionDB.read()
          .then((value) => value.showFinished);
      final Set<String> subjectCodeList =
          await PlatoAppointmentDB.readAllSubjectCode();
      final List<PlatoAppointment> appointments =
          await PlatoAppointmentDB.readAll(showFinished: showFinished);

      emit(SyncfusionCalendarAppointmentState(
        subjectCodeList: subjectCodeList.toList(growable: false),
        appointments: appointments,
      ));
    });
  }
}
