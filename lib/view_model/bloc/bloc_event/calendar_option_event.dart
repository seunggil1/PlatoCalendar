import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class CalendarOptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalendarOptionInitial extends CalendarOptionEvent {}

class CalendarOptionLoading extends CalendarOptionEvent {}

class CalendarOptionLoadingFinished extends CalendarOptionEvent {}

class CalendarOptionUpdate extends CalendarOptionEvent {
  final CalendarOption option;

  CalendarOptionUpdate(this.option);

  @override
  List<Object?> get props => [option];
}
