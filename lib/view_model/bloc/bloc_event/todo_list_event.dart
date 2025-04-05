// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:plato_calendar/model/model.dart';

sealed class TodoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodoList extends TodoListEvent {
  final String? subjectCodeFilter;

  LoadTodoList({this.subjectCodeFilter});

  @override
  List<Object?> get props => [subjectCodeFilter];
}

class ChangeTodoDisplayOption extends TodoListEvent {
  final int changeIndex;

  ChangeTodoDisplayOption(this.changeIndex);

  @override
  List<Object?> get props => [changeIndex];
}

class UpdateTodo extends TodoListEvent {
  final PlatoAppointment appointment;

  UpdateTodo(this.appointment);

  @override
  List<Object?> get props => [appointment];
}
