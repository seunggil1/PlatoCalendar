import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class TaskCheckListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskCheckListInitial extends TaskCheckListEvent {}

class ChangeTaskCheckListDisplayOption extends TaskCheckListEvent {
  final int changeIndex;

  ChangeTaskCheckListDisplayOption(this.changeIndex);

  @override
  List<Object?> get props => [changeIndex];
}

class ChangeTaskCheckList extends TaskCheckListEvent {
  final PlatoAppointment appointment;

  ChangeTaskCheckList(this.appointment);
}
