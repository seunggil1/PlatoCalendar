import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:plato_calendar/Data/else.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Data/subjectCode.dart';
import 'Data/userData.dart' as userData;
import 'Data/userData.dart';
import 'package:intl/intl.dart';
import 'ics.dart';


class PopUpAppointmentEditor extends StatefulWidget{
  CalendarData calendarData;

  CalendarData get scalendarData => calendarData;
  PopUpAppointmentEditor.appointment(Appointment data){
    calendarData = userData.data.firstWhere((value) {
      return value.hashCode == data.resourceIds[0];
    });
  }
  PopUpAppointmentEditor(this.calendarData);

  @override
  _PopUpAppointmentEditorState createState() => _PopUpAppointmentEditorState();
}
class _PopUpAppointmentEditorState extends State<PopUpAppointmentEditor>{
  TextEditingController summaryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String _classCode;
  DateTime _start;
  DateTime _end;
  int _color;
  @override
  void initState() {
    super.initState();
    summaryController.text = widget.calendarData.summary;
    descriptionController.text = widget.calendarData.description;
    _classCode =  subjectCodeThisSemester.contains(widget.calendarData.classCode)
                  ? widget.calendarData.classCode
                  : subjectCodeThisSemester.first;
    _start = widget.calendarData.start;
    _end = widget.calendarData.end;
    _color = widget.calendarData.color;
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
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    child: FlatButton(
                      padding: EdgeInsets.all(5),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return StatefulBuilder(builder: (context,setState){
                              return AlertDialog(
                                content: Text("삭제하시겠습니까?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("확인"),
                                    onPressed: () {
                                      Navigator.pop(context,true);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("취소"),
                                    onPressed: () {
                                      Navigator.pop(context,false);
                                    },
                                  ),
                                ],
                              );
                            });
                          }).then((value){
                            if(value){
                              widget.calendarData.disable = true;
                              Navigator.pop(context);
                            }
                          });
                      },
                      child: Icon(Icons.delete_outlined, color: Colors.white,))
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    child: FlatButton(
                      padding: EdgeInsets.all(5),
                      onPressed: (){
                        widget.calendarData.summary = summaryController.text;
                        widget.calendarData.description = descriptionController.text;
                        if(_classCode != "전체"){
                          widget.calendarData.classCode = _classCode;
                          widget.calendarData.className = subjectCode[_classCode];
                        }else{
                          widget.calendarData.classCode = "bc6a6e7ce4fb95e75c4aa33a26";
                          widget.calendarData.className = "";
                        }
                        widget.calendarData.start = _start;
                        widget.calendarData.end = _end;
                        widget.calendarData.color = _color;
                        Navigator.pop(context);
                      },
                      child: Text('저장',style: TextStyle(color: Colors.white),)),
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
                        Text('수업  ',style: TextStyle(color: Colors.grey[600])),
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
                              });
                            },
                            items: subjectCodeThisSemester
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(subjectCode[value]),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Transform.translate(
                        offset: Offset(-20,0),
                        child: TextField(
                          controller: summaryController,
                        ),
                      ),
                      leading: Icon(Icons.calendar_today_rounded ,color: colorCollection[_color]),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 300.0,
                      ),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          children: [
                            FlatButton(
                              onPressed: (){
                                DatePicker.showDateTimePicker(
                                  context,
                                  locale: LocaleType.ko,
                                  onConfirm: (DateTime time){
                                    setState(() {
                                      _start = time;
                                    });
                                });
                              },
                              child: AutoSizeText(getTimeLocaleKR(_start))
                            ),
                            Text('~',style: TextStyle( fontSize: 30)),
                            FlatButton(
                              onPressed: (){
                                DatePicker.showDateTimePicker(
                                  context,
                                  locale: LocaleType.ko,
                                  onConfirm: (DateTime time){
                                    setState(() {
                                      _end = time;
                                    });
                                });
                              },
                              child: AutoSizeText(getTimeLocaleKR(_end))
                            ),
                          ]),
                    ),
                    FlatButton(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(" 달력에 표시되는 색깔 : "), Icon(Icons.lens,color: colorCollection[_color])]),
                      onPressed: (){
                        showDialog(context: context,
                          builder: (BuildContext context){
                            return CalendarColorPicker(_color);                      
                          }).then((value) => setState((){
                            _color = value;
                          }));
                      })
                  ],
                ),
              ),
            ],
          )
    );
  }

}
class CalendarColorPicker extends StatefulWidget {
  CalendarColorPicker(this.calendarColor);

  final int calendarColor;

  @override
  State<StatefulWidget> createState() => _CalendarColorPickerState(calendarColor);
}

class _CalendarColorPickerState extends State<CalendarColorPicker> {
  int _calendarColor;
  _CalendarColorPickerState(this._calendarColor);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding : const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
        content: Container(
          alignment: Alignment.center,
          width: (colorCollection.length * 100).toDouble(),
          height: 50.0,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            leading: Text('색상',style: TextStyle(fontWeight: FontWeight.bold),),
            title: ListView.builder(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemCount: colorCollection.length,
              itemBuilder: (context,i){
                return FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(5),
                  minWidth: 10,
                  onPressed: (){
                    setState(() {
                      _calendarColor = i;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.pop(context,_calendarColor);
                    });
                  },
                  child: Icon(
                    i == _calendarColor
                        ? Icons.lens
                        : Icons.trip_origin,
                    color: colorCollection[i])
                  );
              }),
          )

    ));
  }
}