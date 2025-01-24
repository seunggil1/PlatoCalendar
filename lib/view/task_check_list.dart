import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view/widget/widget.dart';
import 'package:plato_calendar/view_model/view_model.dart';


class TaskCheckListPage extends StatefulWidget {
  const TaskCheckListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<TaskCheckListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCheckListBloc>().add(LoadTaskCheckListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCheckListBloc, TaskCheckListState>(
        builder: (context, state) {
      return Scaffold(
        appBar: getSubjectCodeAppBarWidget(context),
        body: ListView(
          children: [
            todoGroupWidget(context, 0, state.taskCheckListPassed),
            todoGroupWidget(context, 1, state.taskCheckList6Hour),
            todoGroupWidget(context, 2, state.taskCheckList12Hour),
            todoGroupWidget(context, 3, state.taskCheckListToday),
            todoGroupWidget(context, 4, state.taskCheckListTomorrow),
            todoGroupWidget(context, 5, state.taskCheckListWeek),
            todoGroupWidget(context, 6, state.taskCheckListMoreThanWeek),
            todoGroupWidget(context, 7, state.taskCheckListComplete)
          ],
        ),
      );
    });
  }
}
