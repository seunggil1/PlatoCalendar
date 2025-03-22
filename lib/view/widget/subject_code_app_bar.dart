import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:plato_calendar/etc/subject_code.dart';

AppBar getSubjectCodeAppBarWidget(BuildContext context) {
  return AppBar(
      elevation: 0,
      title:
          BlocBuilder<TodoListBloc, TodoListState>(builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        List<String> subjectCodeList = state.subjectCodeList;
        String subjectCodeFilter = state.subjectCodeFilter;

        debugPrint(
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
            ))
          ],
        );
      }));
}
