import 'package:flutter/material.dart';
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/widget_util/widget_util.dart';

class AppointmentEditorAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  final bool showDeleteButton;
  final PlatoAppointment appointment;

  const AppointmentEditorAppbar(
      {super.key, required this.showDeleteButton, required this.appointment});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _AppointmentEditorAppbarState();
}

class _AppointmentEditorAppbarState extends State<AppointmentEditorAppbar> {
  late final PlatoAppointment appointment;

  @override
  void initState() {
    super.initState();
    appointment = widget.appointment;
  }

  @override
  Widget build(BuildContext context) {
    final deleteButton = widget.showDeleteButton
        ? IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context);

              bool delete = await confirmDialog(context,
                  title: '삭제 확인',
                  content: '해당 일정을 삭제합니다. 계속하시겠습니까?',
                  yesLabel: '삭제',
                  noLabel: '취소');
              if (delete && mounted) {
                widget.appointment.copyWith(status: Status.disable);
                navigator.pop(widget.appointment);
              }
            },
            icon: Icon(Icons.delete_outlined))
        : Container();

    return AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              deleteButton,
              Container(
                alignment: Alignment.centerLeft,
                width: 50,
                child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                    ),
                    onPressed: () {
                      // appointment.title = summaryController.text;
                      // widget.calendarData.description =
                      //     descriptionController.text;
                      // widget.calendarData.memo = memoController.text;
                      // if (_classCode != "전체") {
                      //   widget.calendarData.classCode = _classCode;
                      //   widget.calendarData.className =
                      //   subjectCode[_classCode]!;
                      // } else {
                      //   widget.calendarData.classCode = "과목 분류 없음";
                      //   widget.calendarData.className = "";
                      // }
                      // widget.calendarData.start = _start;
                      // widget.calendarData.end = _end;
                      // widget.calendarData.color = _color;
                      // widget.calendarData.isPeriod =
                      // (_start != _end) ? true : false;
                      //
                      // if (widget.newData) // 신규 추가인 경우
                      //   Navigator.pop(
                      //       context, widget.calendarData); // calendarData 전달
                      // else
                      //   Navigator.pop(context);
                      // UserData.writeDatabase
                      //     .calendarDataSave(widget.calendarData);
                    },
                    child: Text(
                      '저장',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
        backgroundColor: calendarColor[widget.appointment.color]);
  }
}
