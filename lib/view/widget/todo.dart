import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/etc/kr_localization.dart';
import 'package:plato_calendar/etc/subject_code.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/view_model/view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:plato_calendar/widget_util/widget_util.dart';

import 'duration_header.dart';

class TodoWidget extends StatelessWidget {
  final int durationIndex;

  const TodoWidget({super.key, required this.durationIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TaskCheckListState>(
        builder: (context, state) {
      bool showToList =
          state.taskCheckListDisplayOption.showToDoList[durationIndex];
      // 데이터가 없음 -> fold / unfold 옵션이 필요없으니 생략
      if (state[durationIndex].isEmpty) {
        return SizedBox.shrink();
      } else {
        List<Widget> todoWidgetList = [
          ...showToList
              ? state[durationIndex]
                  .map((task) => _TodoWidget(appointmentData: task))
              : <Widget>[]
        ];

        return Card.outlined(
          margin: edgeInsetsStart,
          child: Padding(
            padding: padding,
            // decoration: boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DurationHeaderWidget(
                    index: durationIndex,
                    showToList: showToList,
                    headerText: taskDurationLocaleKR[durationIndex] ?? ''),
                ...todoWidgetList
              ],
            ),
          ),
        );
      }
    });
  }
}

class _TodoWidget extends StatelessWidget {
  final PlatoAppointment appointmentData;
  final DateTime startDay;
  final DateTime endDay;

  _TodoWidget({
    required this.appointmentData,
  })  : startDay = DateTime(
          appointmentData.start.year,
          appointmentData.start.month,
          appointmentData.start.day,
        ),
        endDay = DateTime(
          appointmentData.end.year,
          appointmentData.end.month,
          appointmentData.end.day,
        );

  @override
  Widget build(BuildContext context) {
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
                value: appointmentData.finished,
                onChanged: (value) {
                  // TODO : 일정 완료 상태 변경
                  // context.read<TaskCheckListBloc>().add(
                  //     ChangeTaskCheckListFinished(appointmentData.id, value!));
                  appointmentData.finished = value!;
                  if (value) showSnackBar(context, '완료된 일정으로 변경했습니다.');
                }),
            Container(
                width: 5,
                color: calendarColor[appointmentData.color],
                child: Text('')),
            Expanded(
                flex: 7,
                child:
                    BlocBuilder<GlobalDisplayOptionBloc, GlobalDisplayOption>(
                        builder: (context, state) {
                  return RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style: TextStyle(color: colorScheme.onSurface),
                          text:
                              ' ${appointmentData.title}${appointmentData.body != '' ? ' : ${appointmentData.body}' : ''}'));
                })),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.sp, 0, 5.sp, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          subjectCode.containsKey(appointmentData.subjectCode)
                              ? subjectCode[appointmentData.subjectCode]!
                              : appointmentData.subjectCode,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: colorScheme.secondary, fontSize: 14.sp),
                        ),
                        Text(
                          startDay == endDay
                              ? getDateTimeLocaleKR(appointmentData.start)
                              : getDateTimeLocaleKR(appointmentData.end),
                          maxLines: 1,
                          style: TextStyle(
                              color: colorScheme.secondary, fontSize: 14.sp),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        )
                      ],
                    )))
          ],
        ));
  }
}

final EdgeInsets edgeInsetsStart = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets padding =
    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0);
