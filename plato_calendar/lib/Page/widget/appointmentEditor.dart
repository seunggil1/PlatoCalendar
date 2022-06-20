import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:plato_calendar/Data/etc.dart';
import 'package:plato_calendar/utility.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../Data/subjectCode.dart';
import '../../Data/userData.dart';
import '../../Data/ics.dart';

class PopUpAppointmentEditor extends StatefulWidget {
  bool newData = false;
  CalendarData calendarData;

  CalendarData get scalendarData => calendarData;
  PopUpAppointmentEditor.appointment(Appointment data) {
    calendarData = UserData.data.firstWhere((value) {
      return value.hashCode == data.resourceIds[0];
    });
  }
  PopUpAppointmentEditor(this.calendarData);
  PopUpAppointmentEditor.newAppointment() {
    DateTime time = DateTime.now();
    time = time.subtract(Duration(
        seconds: time.second,
        milliseconds: time.millisecond,
        microseconds: time.microsecond));
    calendarData = CalendarData.newIcs();
    newData = true;
  }
  @override
  _PopUpAppointmentEditorState createState() => _PopUpAppointmentEditorState();
}

class _PopUpAppointmentEditorState extends State<PopUpAppointmentEditor> {
  TextEditingController summaryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  String _classCode;
  DateTime _start;
  DateTime _end;
  int _color;
  bool _isPlato;
  @override
  void initState() {
    super.initState();
    summaryController.text = widget.calendarData.summary;
    descriptionController.text = widget.calendarData.description;
    memoController.text = widget.calendarData.memo;
    _classCode =
        UserData.subjectCodeThisSemester.contains(widget.calendarData.classCode)
            ? widget.calendarData.classCode
            : UserData.subjectCodeThisSemester.first; // 특정 과목이 아닐 경우 "전체"로 표시.
    _start = widget.calendarData.start;
    _end = widget.calendarData.end;
    _color = widget.calendarData.color;
    _isPlato = widget.calendarData.isPlato;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !widget.newData
                    ? Container(
                        // 신규추가인 경우 삭제 버튼 표시 x
                        alignment: Alignment.centerLeft,
                        width: 50,
                        child: FlatButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        content: Text("삭제하시겠습니까?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("확인"),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("취소"),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  }).then((value) {
                                if (value != null && value) {
                                  widget.calendarData.disable = true;
                                  Navigator.pop(context);
                                  UserData.writeDatabase
                                      .calendarDataSave(widget.calendarData);
                                }
                              });
                            },
                            child: Icon(
                              Icons.delete_outlined,
                              color: Colors.white,
                            )))
                    : Container(),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 50,
                  child: FlatButton(
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        widget.calendarData.summary = summaryController.text;
                        widget.calendarData.description =
                            descriptionController.text;
                        widget.calendarData.memo = memoController.text;
                        if (_classCode != "전체") {
                          widget.calendarData.classCode = _classCode;
                          widget.calendarData.className =
                              subjectCode[_classCode];
                        } else {
                          widget.calendarData.classCode = "과목 분류 없음";
                          widget.calendarData.className = "";
                        }
                        widget.calendarData.start = _start;
                        widget.calendarData.end = _end;
                        widget.calendarData.color = _color;
                        widget.calendarData.isPeriod =
                            (_start != _end) ? true : false;

                        if (widget.newData) // 신규 추가인 경우
                          Navigator.pop(
                              context, widget.calendarData); // calendarData 전달
                        else
                          Navigator.pop(context);
                        UserData.writeDatabase
                            .calendarDataSave(widget.calendarData);
                      },
                      child: Text(
                        '저장',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
          backgroundColor: colorCollection[_color],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('수업  ', style: TextStyle(color: Colors.grey[600])),
                      Expanded(
                        child: DropdownButton<String>(
                          value: _classCode,
                          icon: Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _classCode = newValue;
                              if (UserData.defaultColor.containsKey(_classCode))
                                _color = UserData.defaultColor[_classCode];
                            });
                          },
                          items: UserData.subjectCodeThisSemester
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  subjectCode[value] ?? value,
                                  style: TextStyle(color: () {
                                    if (UserData.themeMode == ThemeMode.dark)
                                      return Colors.white;
                                    else if (UserData.themeMode ==
                                            ThemeMode.system &&
                                        MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark)
                                      return Colors.white;
                                    else
                                      return Colors.black;
                                  }()),
                                ));
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Transform.translate(
                      offset: Offset(-20, 0),
                      child: TextField(
                        controller: summaryController,
                      ),
                    ),
                    leading: Icon(Icons.calendar_today_rounded,
                        color: colorCollection[_color]),
                  ),
                  descriptionController.text.length != 0
                      ? Text(
                          "\n",
                          style: TextStyle(fontSize: 3),
                        )
                      : Container(),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 300.0),
                      child: Row(children: [
                        Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(descriptionController.text,
                              style: TextStyle(fontSize: 14)),
                        ))
                      ])),
                  descriptionController.text.length != 0
                      ? Text("\n", style: TextStyle(fontSize: 5))
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
                            controller: memoController,
                            maxLines: null,
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                              onPressed: _isPlato
                                  ? () {
                                      showToastMessageCenter(
                                          "Plato 일정은 시간 변경이 불가합니다.");
                                    } // Plato 일정이면 날짜 변경 x
                                  : () {
                                      DatePicker.showDateTimePicker(context,
                                          locale: LocaleType.ko,
                                          currentTime: _start,
                                          onConfirm: (DateTime time) {
                                        setState(() {
                                          _start = time;
                                          if (_start
                                                  .difference(_end)
                                                  .inSeconds >
                                              0)
                                            _end =
                                                _start.add(Duration(hours: 1));
                                        });
                                      });
                                    },
                              child: AutoSizeText(
                                  "시작 시간 :  " + getDateTimeLocaleKR(_start))),
                          //Text('~',style: TextStyle( fontSize: 30)),
                          FlatButton(
                              onPressed: _isPlato
                                  ? () {
                                      showToastMessageCenter(
                                          "Plato 일정은 시간 변경이 불가합니다.");
                                    } // Plato 일정이면 날짜 변경 x
                                  : () {
                                      DatePicker.showDateTimePicker(context,
                                          locale: LocaleType.ko,
                                          currentTime: _end,
                                          onConfirm: (DateTime time) {
                                        setState(() {
                                          _end = time;
                                          if (_start
                                                  .difference(_end)
                                                  .inSeconds >
                                              0)
                                            _start = _end
                                                .subtract(Duration(hours: 1));
                                        });
                                      });
                                    },
                              child: AutoSizeText(
                                  "종료 시간 :  " + getDateTimeLocaleKR(_end))),
                        ]),
                  ),
                  FlatButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" 달력에 표시되는 색깔 : "),
                            Icon(Icons.lens, color: colorCollection[_color])
                          ]),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CalendarColorPicker(_color);
                            }).then((value) => setState(() {
                              if (value != null) _color = value;
                            }));
                      })
                ],
              ),
            ),
          ],
        ));
  }
}

/// 일정 색상을 지정하는 팝업 창
class CalendarColorPicker extends StatefulWidget {
  CalendarColorPicker(this.calendarColor);

  final int calendarColor;

  @override
  State<StatefulWidget> createState() =>
      _CalendarColorPickerState(calendarColor);
}

class _CalendarColorPickerState extends State<CalendarColorPicker> {
  int _calendarColor;
  _CalendarColorPickerState(this._calendarColor);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
        content: Container(
            alignment: Alignment.center,
            width: (colorCollection.length * 100).toDouble(),
            height: 50.0,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                '색상',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemCount: colorCollection.length,
                  itemBuilder: (context, i) {
                    return FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.all(2.2),
                        minWidth: 10,
                        onPressed: () {
                          setState(() {
                            _calendarColor = i;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.pop(context, _calendarColor);
                          });
                        },
                        child: Icon(
                            i == _calendarColor
                                ? Icons.lens
                                : Icons.trip_origin,
                            color: colorCollection[i]));
                  }),
            )));
  }
}

/// 일정 완료, 삭제만 가능한 간단 팝업 창
class SimplePopUpAppointmentEditor extends StatefulWidget {
  final CalendarData calendarData;

  SimplePopUpAppointmentEditor(Appointment data)
      : calendarData = UserData.data.firstWhere((value) {
          return value.hashCode == data.resourceIds[0];
        });
  @override
  State<StatefulWidget> createState() =>
      _SimplePopUpAppointmentEditorState(calendarData);
}

class _SimplePopUpAppointmentEditorState
    extends State<SimplePopUpAppointmentEditor> {
  CalendarData calendarData;

  _SimplePopUpAppointmentEditorState(this.calendarData);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        backgroundColor: Colors.grey[50],
        content: Container(
            height: 150.0,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      calendarData.finished = true;
                      UserData.writeDatabase.calendarDataSave(calendarData);
                      Navigator.pop(context, true);
                    },
                    child: Text("일정 완료처리 하기",
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 16))),
                TextButton(
                    onPressed: () {
                      calendarData.disable = true;
                      UserData.writeDatabase.calendarDataSave(calendarData);
                      Navigator.pop(context, false);
                    },
                    child: Text("일정 삭제하기",
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 16))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("취소",
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 16)))
              ],
            )));
  }
}
