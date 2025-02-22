import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/model_repository/model_repository.dart';

class SyncfusionCalendarAppointmentCubit
    extends Cubit<List<PlatoAppointment>> {
  SyncfusionCalendarAppointmentCubit() : super(<PlatoAppointment>[]);

  void loadPlatoAppointment() async {
    emit(await PlatoAppointmentDB.readAll());
  }
}
