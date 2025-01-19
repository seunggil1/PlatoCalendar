import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view/widget/todo.dart';
import 'package:plato_calendar/view_model/view_model.dart';

class TaskCheckListPage extends StatelessWidget {
  const TaskCheckListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCheckListBloc>(
        create: (BuildContext context) => TaskCheckListBloc(),
        child: const _TaskCheckListPage());
  }
}

class _TaskCheckListPage extends StatefulWidget {
  const _TaskCheckListPage();

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<_TaskCheckListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCheckListBloc>().add(TaskCheckListInitial());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCheckListBloc, TaskCheckListState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Row(
              children: [],
            )),
        body: ListView(
          children: [
            todoGroupWidget(context, state.taskCheckListPassed),
            todoGroupWidget(context, state.taskCheckList6Hour),
            todoGroupWidget(context, state.taskCheckList12Hour),
            todoGroupWidget(context, state.taskCheckListToday),
            todoGroupWidget(context, state.taskCheckListTomorrow),
            todoGroupWidget(context, state.taskCheckListWeek),
            todoGroupWidget(context, state.taskCheckListMoreThanWeek),
            todoGroupWidget(context, state.taskCheckListComplete)
          ],
        ),
      );
    });
  }
}
