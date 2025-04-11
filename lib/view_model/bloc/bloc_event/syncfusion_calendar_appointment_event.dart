// Package imports:
import 'package:equatable/equatable.dart';

sealed class SyncfusionCalendarAppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SyncfusionCalendarAppointmentUpdate
    extends SyncfusionCalendarAppointmentEvent {}
