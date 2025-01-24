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

Widget todoGroupWidget(
    BuildContext context, int durationHeader, List<PlatoAppointment> data) {
  if (data.isEmpty) {
    return Container();
  } else {
    return Container(
      margin: edgeInsetsStart,
      padding: padding,
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDurationHeaderWidget(
              taskDurationLocaleKR[durationHeader] ?? '', durationHeader),
          ...data.map((task) => todoWidget(context, task))
        ],
      ),
    );
  }
}

Widget todoWidget(BuildContext context, PlatoAppointment data) {
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
                if (value) showMessage(context, '완료된 일정으로 변경했습니다.');
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
                        style: TextStyle(color: () {
                          switch (state.themeMode) {
                            case ThemeMode.dark:
                              return Colors.white;
                            case ThemeMode.light:
                              return Colors.black;
                            case ThemeMode.system:
                            default:
                              return MediaQuery.of(context)
                                          .platformBrightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black;
                          }
                        }()),
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
