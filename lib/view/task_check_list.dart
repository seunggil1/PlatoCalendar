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
    // BlocSelector<TaskCheckListBloc, TaskCheckListState, List>(
    //   selector: (state) => state.taskCheckList6Hour,
    //   builder: (context, a){
    //     return Container();
    //   }
    // );
    return Scaffold(
      appBar: getSubjectCodeAppBarWidget(context),
      body: ListView(
          children:
              List.generate(8, (index) => TodoWidget(durationIndex: index))),
    );
  }
}
