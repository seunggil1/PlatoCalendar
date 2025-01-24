import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class SyncfusionCalendarOptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SyncfusionCalendarOptionUpdate extends SyncfusionCalendarOptionEvent {
  final CalendarOption option;

  SyncfusionCalendarOptionUpdate(this.option);

  @override
  List<Object?> get props => [option];
}
