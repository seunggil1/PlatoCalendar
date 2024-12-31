import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class PlatoAppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDataRequest extends PlatoAppointmentEvent {}
class SyncRequest extends PlatoAppointmentEvent {}

// class PlatoAppointmentUpdated extends PlatoAppointmentEvent {
//   final List<PlatoAppointment> appointments;
//
//   PlatoAppointmentUpdated(this.appointments);
//
//   @override
//   List<Object?> get props => [appointments];
// }
