import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class CalendarOptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CalendarOptionEvent {}

class Loading extends CalendarOptionEvent {}

class LoadingFinished extends CalendarOptionEvent {}

class Update extends CalendarOptionEvent {
  final CalendarOption option;

  Update(this.option);

  @override
  List<Object?> get props => [option];
}
