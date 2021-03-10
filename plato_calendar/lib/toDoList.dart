import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'Data/else.dart';
import 'Data/subjectCode.dart';
import 'Data/userData.dart';
import 'appointmentEditor.dart';
import 'ics.dart';


final EdgeInsets edgeInsetsStart  = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets edgeInsetsMiddle = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets edgeInsetsEnd    = EdgeInsets.fromLTRB(10, 10, 10, 10);

class ToDoList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList>{
  String dropdownValue = subjectCodeThisSemester.first;
  SortMethod _sortMethod= sortMethod;
  List<Widget> toDoListNodate = [];   // 날짜 없음
  List<Widget> toDoListPassed = [];   // 기간 지남
  List<Widget> toDoListLongTime = []; // 1주일 이상 남음
  List<Widget> toDoListWeek = [];     // 1주일 남음
  List<Widget> toDoListToday = [];    // 오늘까지
  List<Widget> toDoList12Hour = [];   // 12시간 남음
  List<Widget> toDoList6Hour= [];     // 6시간 남음
  List<Widget> toDoListFinished = []; // 완료

  @override
  Widget build(BuildContext context) {
    toDoListNodate.clear();
    toDoListPassed.clear();
    toDoListLongTime.clear();
    toDoListWeek.clear();
    toDoListToday.clear();
    toDoList12Hour.clear();
    toDoList6Hour.clear();
    toDoListFinished.clear();
    DateTime now = DateTime.now();
    data.forEach((element) {
      Duration diff = element.end.difference(now);
      if(dropdownValue == '전체' || element.classCode == dropdownValue)
        if(!element.disable){ // 유저가 삭제 처리
          if(element.finished){ // 완료 일정
            // 날짜 정보가 없거나 1주 안지나면 표시
            if(element.end == null || diff.inDays > -7)
              toDoListFinished.add(_getTodoWidget(element));
          }
          else{
            // 날짜 정보 없음
            if(element.end == null) toDoListNodate.add(_getTodoWidget(element));
            else
              if(diff.inSeconds < 0) // 기간 지남
                toDoListPassed.add(_getTodoWidget(element));
              else if(diff.inDays > 7){ // 일주일 이상 남음.
                toDoListLongTime.add(_getTodoWidget(element));
              }else if(element.end.day == now.day){ //오늘 까지
                if(diff.inHours < 6) // 6시간 남음
                  toDoList6Hour.add(_getTodoWidget(element));
                else if(diff.inHours < 12) // 12시간 남음
                  toDoList12Hour.add(_getTodoWidget(element));
                else // 오늘까지 인데 12시간 이상 남음
                  toDoListToday.add(_getTodoWidget(element));
              }else // 하루 넘게 남았음
                toDoListWeek.add(_getTodoWidget(element));
          }
        }
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            SizedBox(width: 5),
            Expanded(child: 
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.grey[350],
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
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
              flex: 9,
            ),
            Expanded(child: 
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add_box_outlined ,color: Colors.grey[350]),// 기능넣으면 grey[700]으로
                  onPressed: null,
                ),
              ),
              flex: 3
            ),
            Expanded(child:
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert_rounded, color: Colors.grey[700]),
                itemBuilder: (context) =>[
                  PopupMenuItem(
                    value: 1,
                    child: Text('정렬'),
                  )
                ],
                onSelected: (value){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState){
                          return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Row(children: [
                                    Radio(
                                      value: SortMethod.sortByDue,
                                      groupValue: _sortMethod,
                                      onChanged: (SortMethod value) {
                                        setState(() {
                                          _sortMethod = value;
                                        });
                                      },
                                    ),
                                    Text('기한순')
                                  ],),
                                  Row(children: [
                                    Radio(
                                      value: SortMethod.sortByRegister,
                                      groupValue: _sortMethod,
                                      onChanged: null,
                                      // (SortMethod value) {
                                      //   setState(() {
                                      //     _sortMethod = value;
                                      //   });
                                      // }
                                    ),
                                    Text('등록순',style: TextStyle(color: Colors.grey[350]),)
                                  ],)
                                ]
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("확인"),
                                  onPressed: () {
                                    sortMethod = _sortMethod;
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text("취소"),
                                  onPressed: () {
                                    _sortMethod = sortMethod;
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                        }
                      );
                    },
                  );
                },
              ),
              flex: 1
            )
          ],

        )
      ),
      body: ListView(
        children: [
          toDoListPassed.isEmpty ? Container()
          : Container(
            margin: edgeInsetsStart,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("지난 할일")] + toDoListPassed,
            ),
          ),
          toDoList6Hour.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("6시간 남음")] + toDoList6Hour,
            ),
          ),
          toDoList12Hour.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("12시간 남음")] + toDoList12Hour,
            ),
          ),
          toDoListToday.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("오늘")] + toDoListToday,
            ),
          ),
          toDoListWeek.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("7일 이내")] + toDoListWeek,
            ),
          ),
          toDoListLongTime.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("7일 이상")] + toDoListLongTime,
            ),
          ),
          toDoListNodate.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("기한 없음")] + toDoListNodate,
            ),
          ),
          toDoListFinished.isEmpty ? Container()
          : Container(
            margin: edgeInsetsEnd,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("완료")] + toDoListFinished,
            ),
          ),
        ],
      ),
    );
  }
  Widget _getDurationWidget(String str){
    return Container(
      margin: const EdgeInsets.fromLTRB(7,7,0,0),
      child: Text(str,
        style: TextStyle(fontSize: 15) // fontWeight: FontWeight.bold, 
        )
      );
  }
  Widget _getTodoWidget(CalendarData data){
    return FlatButton(
      onPressed: () {
        showDialog(context: context,
          builder: (BuildContext context){
            return PopUpAppointmentEditor(data);
          }).then((value) => setState((){}));
      },
      padding: EdgeInsets.all(0),
      child: Row(
        children: [
          Checkbox(
              activeColor: Colors.grey, // 선택했을 때 체크박스 background color
              checkColor : Colors.black26, // 선택했을 때 체크표시 color
              value: data.finished,
              onChanged: (value){
                setState(() {
                  data.finished = value;
                });
            }),
          Expanded(
            flex: 4,
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: data.summary +(data.description != "" ? ' : ${data.description}'  : ""))
            )
          ),
          Expanded(
            flex : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  data.className != "" ? data.className : data.classCode,
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(color: Colors.grey),
                ),
                AutoSizeText(
                  DateFormat("MM-dd ").format(data.end) + weekdayLocaleKR[data.end.weekday] + DateFormat(" HH:mm").format(data.end),
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(color: Colors.grey,),
                )
              ],
            )
          )
        ],
      )
    );
  }





}


