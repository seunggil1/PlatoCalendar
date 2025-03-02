import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/etc/kr_localization.dart';
import 'package:plato_calendar/etc/subject_code.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/widget_util/show_snack_bar.dart';

import 'calendar_color_picker.dart';

class AppointmentEditorBody extends StatefulWidget {
  final List<String> subjectCodeList;
  final PlatoAppointment appointment;

  const AppointmentEditorBody(
      {super.key, required this.subjectCodeList, required this.appointment});

  @override
  State<StatefulWidget> createState() => _AppointmentEditorBodyState();
}

class _AppointmentEditorBodyState extends State<AppointmentEditorBody> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  late final List<String> subjectCodeList;

  late final PlatoAppointment appointment;
  late String subjectCode;

  @override
  void initState() {
    super.initState();
    subjectCodeList = widget.subjectCodeList.sublist(1);
    appointment = widget.appointment;

    subjectCode = appointment.subjectCode;
    titleController.text = appointment.title;
    bodyController.text = appointment.body;
    commentController.text = appointment.comment;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            Row(
              children: [
                Text('수업  ', style: TextStyle(color: Colors.grey[600])),
                Expanded(
                  child: DropdownButton<String>(
                    value: subjectCode,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    iconSize: 24,
                    elevation: 16,
                    // style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 1,
                      color: Colors.grey[600],
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue == null) return;
                        subjectCode = newValue;
                      });
                    },
                    items: subjectCodeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            subjectCodeToName[value] ?? value,
                          ));
                    }).toList(),
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Transform.translate(
                offset: Offset(-20, 0),
                child: TextField(
                  controller: titleController,
                ),
              ),
              leading: Icon(Icons.calendar_today_rounded,
                  color: calendarColor[appointment.color]),
            ),
            bodyController.text.isNotEmpty
                ? Text(
                    '\n',
                    style: TextStyle(fontSize: 3),
                  )
                : Container(),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300.0),
              child: Row(
                children: [
                  const Text("Memo   ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      maxLines: null,
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextButton(
                    onPressed: appointment.dataType == DataType.school
                        ? () {
                            showSnackBar(context, 'Plato 일정은 시간 변경이 불가합니다.');
                          } // Plato 일정이면 날짜 변경 x
                        : () {
                            DatePicker.showDateTimePicker(context,
                                locale: LocaleType.ko,
                                currentTime: appointment.start,
                                onConfirm: (DateTime time) {
                              int diff = appointment.start
                                  .difference(appointment.end)
                                  .inSeconds;
                              PlatoAppointment nextAppointment;

                              if (diff > 0) {
                                nextAppointment = appointment.copyWith(
                                    start: time,
                                    end: time.add(Duration(hours: 1)));
                              } else {
                                nextAppointment = appointment.copyWith(
                                    start: time, end: appointment.end);
                              }

                              setState(() {
                                appointment = nextAppointment;
                              });
                            });
                          },
                    child: Text(
                        "시작 시간 :  ${getFullDateTimeLocaleKR(appointment.start)}")),
                //Text('~',style: TextStyle( fontSize: 30)),
              ]),
            ),
            TextButton(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(" 달력에 표시되는 색깔 : "),
                  Icon(Icons.lens, color: calendarColor[appointment.color])
                ]),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CalendarColorPicker(appointment.color);
                      }).then((value) => setState(() {
                        if (value != null) {
                          appointment.copyWith(color: value);
                        }
                      }));
                })
          ]),
        )
      ],
    );
  }
}
