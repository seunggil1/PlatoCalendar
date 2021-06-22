import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../Data/else.dart';
import '../Data/subjectCode.dart';
import '../Data/userData.dart';
import 'widget/appointmentEditor.dart';
import '../Data/database.dart';
import '../Data/ics.dart';
import '../main.dart';
import '../utility.dart';


final EdgeInsets edgeInsetsStart  = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets edgeInsetsMiddle = EdgeInsets.fromLTRB(10, 10, 10, 0);
final EdgeInsets edgeInsetsEnd    = EdgeInsets.fromLTRB(10, 10, 10, 10);

class ToDoList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList>{
  String dropdownValue = UserData.subjectCodeThisSemester.first;
  SortMethod _sortMethod= sortMethod;
  List<Widget> toDoListNodate = [];   // 날짜 없음
  List<Widget> toDoListPassed = [];   // 기간 지남
  List<Widget> toDoListLongTime = []; // 1주일 이상 남음
  List<Widget> toDoListWeek = [];     // 1주일 남음
  List<Widget> toDoListTomorrow = []; // 내일까지
  List<Widget> toDoListToday = [];    // 오늘까지
  List<Widget> toDoList12Hour = [];   // 12시간 남음
  List<Widget> toDoList6Hour= [];     // 6시간 남음
  List<Widget> toDoListFinished = []; // 완료

  StreamSubscription<bool> listener;

  @override
  void initState() {
    super.initState();
    listener = platoStream.stream.listen((event) {
      if(event)
        setState(() {  });
    });
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }
  @override
  Widget build(BuildContext context) {
    toDoListNodate.clear();
    toDoListPassed.clear();
    toDoListLongTime.clear();
    toDoListWeek.clear();
    toDoListTomorrow.clear();
    toDoListToday.clear();
    toDoList12Hour.clear();
    toDoList6Hour.clear();
    toDoListFinished.clear();
    DateTime now = DateTime.now();
    UserData.data.forEach((element) {
      Duration diff = element.end.difference(now);
      if(dropdownValue == '전체' || element.classCode == dropdownValue)
        if(!element.disable){ // 유저가 삭제 처리
          if(element.finished){ // 완료 일정
            // 날짜 정보가 없거나 1주 안지나면 표시
            if(element.end == null || diff.inDays > -5)
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
              }else if(element.end.day == now.day + 1) // 내일까지
                toDoListTomorrow.add(_getTodoWidget(element));
              else // 하루 넘게 남았음
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
                icon: Icon(Icons.arrow_drop_down,color: Colors.blueAccent[100]),
                isExpanded: true,
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent[100],
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: UserData.subjectCodeThisSemester
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(' '+subjectCode[value], style: TextStyle(color: Colors.blueAccent[100], fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
              flex: 9,
            ),
            Expanded(child: 
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add_box_outlined ,color: Colors.blueAccent[100]),
                  onPressed: (){
                    showDialog(context: context,
                      builder: (BuildContext context){
                        return PopUpAppointmentEditor.newAppointment();
                      }).then((value) {
                        if(value != null){
                          setState((){
                            Database.uidSet.add(value.uid);
                            UserData.data.add(value);
                          });
                          Database.uidSetSave();
                        }
                      });
                  },
                ),
              ),
              flex: 3
            ),
            Expanded(child:
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert_rounded, color: Colors.blueAccent[100]),
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
              children: [_getDurationWidget("지난 할일",0)] + (UserData.showToDoList[0] ? toDoListPassed : []),
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
              children: [_getDurationWidget("6시간 이내",1)] + (UserData.showToDoList[1] ? toDoList6Hour : []),
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
              children: [_getDurationWidget("12시간 남음",2)] + (UserData.showToDoList[2] ? toDoList12Hour : []),
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
              children: [_getDurationWidget("오늘",3)] + (UserData.showToDoList[3] ? toDoListToday : []),
            ),
          ),
          toDoListTomorrow.isEmpty ? Container()
          : Container(
            margin: edgeInsetsMiddle,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("내일",4)] + (UserData.showToDoList[4] ? toDoListTomorrow : []),
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
              children: [_getDurationWidget("7일 이내",5)] + (UserData.showToDoList[5] ? toDoListWeek : []),
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
              children: [_getDurationWidget("7일 이상",6)] + (UserData.showToDoList[6] ? toDoListLongTime : []),
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
              children: [_getDurationWidget("기한 없음",7)] + (UserData.showToDoList[7] ? toDoListNodate : []),
            ),
          ),
          toDoListFinished.isEmpty ? Container()
          : Container(
            margin: edgeInsetsEnd,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:5.0),
            decoration: BoxDecoration(
              border:Border.all(color: Colors.grey[350], width: 1.5),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_getDurationWidget("완료",8)] + (UserData.showToDoList[8] ? toDoListFinished : []),
            ),
          ),
        ],
      ),
    );
  }
  Widget _getDurationWidget(String str, int index){
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(str, style: TextStyle(fontSize: 15)),
          GestureDetector(
            onTap: (){
              setState(() {
                UserData.showToDoListByIndex(index, !UserData.showToDoList[index]);
              });
            },
            child: Icon(UserData.showToDoList[index] ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp, color: Colors.blueAccent[100]),
          )
        ],
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
                Database.calendarDataSave(data);
                if(value)
                  showMessage(context, "완료된 일정으로 변경했습니다.");
            }),
          Container(
            width: 5,
            color: colorCollection[data.color],
            child: Text('')
          ),
          Expanded(
            flex: 7,
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: ' '+data.summary +(data.description != "" ? ' : ${data.description}'  : ""))
            )
          ),
          Expanded(
            flex : 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  data.className != "" ? data.className : data.classCode,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  minFontSize: 8,
                  maxFontSize: 12,
                  style: TextStyle(color: Colors.grey,),
                ),
                AutoSizeText(
                  DateFormat("MM-dd ").format(data.end) + weekdayLocaleKR[data.end.weekday] + DateFormat(" HH:mm").format(data.end),
                  maxLines: 1,
                  minFontSize: 7,
                  maxFontSize: 12,
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