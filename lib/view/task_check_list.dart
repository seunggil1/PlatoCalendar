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
        children: [
          todoGroupWidget(context, 0),
          todoGroupWidget(context, 1),
          todoGroupWidget(context, 2),
          todoGroupWidget(context, 3),
          todoGroupWidget(context, 4),
          todoGroupWidget(context, 5),
          todoGroupWidget(context, 6),
          todoGroupWidget(context, 7)
        ],
      ),
    );
  }
}
