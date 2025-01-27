import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/etc/kr_localization.dart';
import 'package:plato_calendar/etc/subject_code.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';

import './widget_util/widget_util.dart';
import 'duration_header.dart';

Widget todoGroupWidget(BuildContext context, int durationIndex) {
  final colorScheme = Theme.of(context).colorScheme;

  return BlocBuilder<TaskCheckListBloc, TaskCheckListState>(
      builder: (context, state) {
    bool showToList =
        state.taskCheckListDisplayOption.showToDoList[durationIndex];
    // 데이터가 없음 -> fold / unfold 옵션이 필요없으니 생략
    if (state[durationIndex].isEmpty) {
      return SizedBox.shrink();
    } else {
      List<Widget> todoWidgetList = [
        ...showToList
            ? state[durationIndex].map((task) => todoWidget(context, task))
            : <Widget>[]
      ];

      return Card.outlined(
        // color: colorScheme.surface,
        margin: edgeInsetsStart,
        child: Padding(
          padding: padding,
          // decoration: boxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getDurationHeaderWidget(context, durationIndex, showToList,
                  taskDurationLocaleKR[durationIndex] ?? ''),
              ...todoWidgetList
            ],
          ),
        ),
      );
    }
  });
}

Widget todoWidget(BuildContext context, PlatoAppointment data) {
  final colorScheme = Theme.of(context).colorScheme;

  return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container();
              // PopUpAppointmentEditor(data);
            }).then((value) => debugPrint('1'));
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
      ),
      child: Row(
        children: [
          Checkbox(
              activeColor: Colors.grey, // 선택했을 때 체크박스 background color
              checkColor: Colors.black26, // 선택했을 때 체크표시 color
              value: data.finished,
              onChanged: (value) {
                // TODO : 일정 완료 상태 변경
                data.finished = value!;
                if (value) showSnackBar(context, '완료된 일정으로 변경했습니다.');
              }),
          Container(
              width: 5, color: calendarColor[data.color], child: Text('')),
          Expanded(
              flex: 7,
              child: BlocBuilder<GlobalDisplayOptionBloc, GlobalDisplayOption>(
                  builder: (context, state) {
                return RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: TextStyle(color: colorScheme.onSurface),
                        text:
                            ' ${data.title}${data.body != '' ? ' : ${data.body}' : ''}'));
              })),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subjectCode.containsKey(data.subjectCode)
                        ? subjectCode[data.subjectCode]!
                        : data.subjectCode,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    DateFormat('MM-dd ').format(data.end) +
                        weekdayLocaleKR[data.end.weekday]! +
                        DateFormat(' HH:mm').format(data.end),
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ))
        ],
      ));
}

final EdgeInsets edgeInsetsStart = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets edgeInsetsMiddle = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets edgeInsetsEnd = EdgeInsets.fromLTRB(10, 10, 10, 10);
final EdgeInsets padding =
    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0);
final BoxDecoration boxDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey[350] ?? Colors.grey, width: 1.5),
    borderRadius: BorderRadius.circular(5));
