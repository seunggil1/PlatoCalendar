import 'package:equatable/equatable.dart';
import 'package:plato_calendar/model/model.dart';

sealed class TodoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodoList extends TodoListEvent {}

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
