import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

import './bloc_state/bloc_state.dart';

class SyncfusionCalendarAppointmentCubit
    extends Cubit<SyncfusionCalendarAppointmentState> {
  SyncfusionCalendarAppointmentCubit(
      {List<String>? subjectCodeList, List<PlatoAppointment>? appointments})
      : super(SyncfusionCalendarAppointmentState(
            subjectCodeList: subjectCodeList, appointments: appointments));

  void loadPlatoAppointment({required bool showFinished}) async {
    final List<String> subjectCodeList =
        await PlatoAppointmentDB.readAllSubjectCode();
    final List<PlatoAppointment> appointments =
        await PlatoAppointmentDB.readAll(showFinished: showFinished);

    emit(SyncfusionCalendarAppointmentState(
      subjectCodeList: subjectCodeList,
      appointments: appointments,
    ));
  }
}
