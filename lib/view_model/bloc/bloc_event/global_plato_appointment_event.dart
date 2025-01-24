import 'package:equatable/equatable.dart';

sealed class GlobalPlatoAppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPlatoAppointment extends GlobalPlatoAppointmentEvent {}

class SyncPlatoAppointment extends GlobalPlatoAppointmentEvent {}

class DeleteAllPlatoAppointment extends GlobalPlatoAppointmentEvent {}

// class PlatoAppointmentUpdated extends PlatoAppointmentEvent {
//   final List<PlatoAppointment> appointments;
//
//   PlatoAppointmentUpdated(this.appointments);
//
//   @override
//   List<Object?> get props => [appointments];
// }
