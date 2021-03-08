import 'package:flutter/material.dart';

import 'Data/else.dart';
import 'Data/userData.dart' as userData;
import 'Data/userData.dart';
import 'appointmentEditor.dart';

class Setting extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Setting>{
  String _dropdownValue = weekdayLocaleKR[userData.firstDayOfWeek];
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
          Column(),
        ],
      ),
      )
    );
  }


}