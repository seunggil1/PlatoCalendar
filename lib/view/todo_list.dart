// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view/widget/widget.dart';
import 'package:plato_calendar/view_model/view_model.dart';

final _logger = LoggerManager.getLogger('View - TodoListPage');

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoListBloc>().add(LoadTodoList());
  }

  @override
  Widget build(BuildContext context) {
    // BlocSelector<TaskCheckListBloc, TaskCheckListState, List>(
    //   selector: (state) => state.taskCheckList6Hour,
    //   builder: (context, a){
    //     return Container();
    //   }
    // );
    _logger.fine('Widget build');

    return Scaffold(
      appBar: getSubjectCodeAppBarWidget(context),
      body: ListView(
          children:
              List.generate(8, (index) => TodoWidget(durationIndex: index))),
    );
  }
}
