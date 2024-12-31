import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class PlatoAppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlatoAppointmentLoading extends PlatoAppointmentEvent {}

class PlatoAppointmentLoadingFinished extends PlatoAppointmentEvent {
  final List<PlatoAppointment> appointments;

  PlatoAppointmentLoadingFinished(this.appointments);

  @override
  List<Object?> get props => [appointments];
}
