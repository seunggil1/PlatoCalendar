import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

import 'Data/userData.dart';
import 'ics.dart';

class ToDoList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList>{
  String dropdownValue = 'One';
  SortMethod _sortMethod= sortMethod;
  List<Widget> toDoWidgetList = [];
  @override
  Widget build(BuildContext context) {
    toDoWidgetList.clear();
    data.forEach((element) { 
      toDoWidgetList.add(getTodoWidget(element)); 
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: 
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                isExpanded: true,
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              flex: 9,
            ),
            Expanded(child: 
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add_box_outlined),
                  onPressed: () => print('IconButton'),
                ),
              ),
              flex: 3
            ),
            Expanded(child:
              PopupMenuButton<int>(
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
                                      onChanged: (SortMethod value) {
                                        setState(() {
                                          _sortMethod = value;
                                        });
                                      },
                                    ),
                                    Text('등록순')
                                  ],)
                                ]
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: new Text("확인"),
                                  onPressed: () {
                                    sortMethod = _sortMethod;
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: new Text("취소"),
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
      body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal:5.0),
        decoration: BoxDecoration(
          border:Border.all(color:Colors.grey[350], width: 1.5),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          children: toDoWidgetList,
        ),
      ),
      );
  }

  Widget getTodoWidget(CalendarData data){
    return Row(
      children: [
        Checkbox(
          value: data.finished,
          onChanged: (value){
            setState(() {
              data.finished = value;
            });
        }),
        Expanded(
          flex: 4,
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              text: data.summary+' : '+ data.description)
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
                DateFormat("MM-dd HH:mm:ss").format(data.end),
                maxLines: 1,
                minFontSize: 8,
                style: TextStyle(color: Colors.grey,),
              )
            ],
          )
        )
      ],
    );
  }





}


