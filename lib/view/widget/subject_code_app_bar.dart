// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:plato_calendar/etc/subject_code_to_name.dart';
import 'package:plato_calendar/util/logger.dart';
import 'package:plato_calendar/view/widget/appointment_editor/appointment_editor.dart';
import 'package:plato_calendar/view_model/view_model.dart';

final _logger = LoggerManager.getLogger('widget - subject_code_app_bar');

AppBar getSubjectCodeAppBarWidget(BuildContext context) {
  final todoListBloc = context.read<TodoListBloc>();

  return AppBar(
      elevation: 0,
      title:
          BlocBuilder<TodoListBloc, TodoListState>(builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        List<String> subjectCodeList = state.subjectCodeList;
        String subjectCodeFilter = state.subjectCodeFilter;

        _logger.fine(
            'subjectCodeList: $subjectCodeList, Filter: $subjectCodeFilter');

        return Row(
          children: [
            const SizedBox(width: 5),
            Expanded(
                child: DropdownButton<String>(
              value: subjectCodeFilter,
              icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
              isExpanded: true,
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: colorScheme.primary,
              ),
              onChanged: (String? newValue) {
                context
                    .read<TodoListBloc>()
                    .add(LoadTodoList(subjectCodeFilter: newValue));
              },
              items:
                  subjectCodeList.map<DropdownMenuItem<String>>((String value) {
                String subjectName = subjectCodeToName[value] ?? value;
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(subjectName,
                      style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                );
              }).toList(),
            )),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.add_box_outlined, color: colorScheme.primary),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppointmentEditorDialog(
                            subjectCodeList: subjectCodeList);
                      }).then((updateAppointment) {
                    if (updateAppointment != null) {
                      todoListBloc.add(UpdateTodo(updateAppointment));
                    }
                  });
                },
              ),
            )
          ],
        );
      }));
}
