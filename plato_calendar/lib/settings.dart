import 'package:flutter/material.dart';

import 'Data/else.dart';
import 'Data/subjectCode.dart';
import 'Data/userData.dart' as userData;
import 'Data/userData.dart';
import 'appointmentEditor.dart';

class Setting extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Setting>{
  Set<String> _subjectCodeThisSemester = Set<String>.from(subjectCodeThisSemester);
  String dropdownValue2;
  String _dropdownValue = weekdayLocaleKR[userData.firstDayOfWeek];

  @override
  void initState() {
    super.initState();
    _subjectCodeThisSemester.remove("전체");
    dropdownValue2 = _subjectCodeThisSemester.first;
  }

  @override
  Widget build(BuildContext context) {
    //a.login().then((value) => a.getCalendar());
    
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
        children: [
          Row(
            children: [
              Text("한 주의 시작", style: TextStyle(fontSize: 16 )),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: DropdownButton(
                    underline: Container(
                      height: 2,
                      color: Colors.grey[350],
                    ),
                    value: userData.firstDayOfWeek,
                    items: weekdayLocaleKR.entries.map<DropdownMenuItem<int>>((e) 
                      => DropdownMenuItem<int>(value: e.key, child: Text(e.value))).toList(),
                    onChanged: (newValue){
                      setState(() {
                        userData.firstDayOfWeek = newValue;
                      });
                    }),
                )
              ),
            ],
          ),
          Row(
            children: [
              Text("완료된 일정 표시", style: TextStyle(fontSize: 16 )),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Switch(value: showFinished, onChanged: (value){
                    setState(() {
                      showFinished = value;
                    });
                  }),
                )
              ),
            ],
          ),
          Row(
            children: [
              Text('과목별 기본 색상 지정'),
              Expanded(child: Container()),
              DropdownButton<String>(
                  value: dropdownValue2,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey[350],
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue2 = newValue;
                    });
                  },
                  items: _subjectCodeThisSemester
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(subjectCode[value]),
                    );
                  }).toList(),
                ),
              FlatButton(
                onPressed: (){
                  showDialog(context: context,
                          builder: (BuildContext context){
                            return CalendarColorPicker(defaultColor[dropdownValue2] ?? 5);                      
                          }).then((value) => setState((){
                            defaultColor[dropdownValue2] = value;
                          }));
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 3,
                child: Icon(Icons.lens,color: colorCollection[defaultColor[dropdownValue2] ?? 5]))
            ],
          ),
        ],
      ),
      )
    );
  }


}