import 'package:equatable/equatable.dart';

import '../bloc_state/bloc_state.dart';

sealed class CalendarOptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CalendarOptionEvent {}

class Loading extends CalendarOptionEvent {}

class LoadingFinished extends CalendarOptionEvent {}

class Update extends CalendarOptionEvent {
  final CalendarOptionState option;

  Update(this.option);

  @override
  List<Object?> get props => [option];
}
