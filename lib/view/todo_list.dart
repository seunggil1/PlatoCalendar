import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/view_model.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarOptionBloc, CalendarOptionState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Row(
              children: [],
            )),
      );
    });
  }
}
