import 'package:flutter/material.dart';

import 'Data/else.dart';
import 'Data/subjectCode.dart';
import 'Data/userData.dart';
import 'appointmentEditor.dart';
import 'database.dart';
import 'plato.dart';

class Setting extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Setting>{
  Set<String> _subjectCodeThisSemester = Set<String>.from(UserData.subjectCodeThisSemester);
  bool expanded = false;
  @override
  void initState() {
    super.initState();
    _subjectCodeThisSemester.remove("전체");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
            children: [
              Card(
                child: ListTile(
                  minLeadingWidth : 20,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ Icon(Icons.people_alt,color: Colors.blueAccent[100])]
                  ),
                  title: Text(UserData.id == ""? "Plato 계정" : UserData.id),
                  subtitle: Text(UserData.lastSyncInfo, style: TextStyle(fontSize: 13)),
                  trailing: TextButton(
                    onPressed: (){
                      if(UserData.id == "")
                        showDialog(context: context,
                          builder: (BuildContext context){
                            return LoginPage();                      
                          }).then((value) => setState((){
                            _subjectCodeThisSemester = Set<String>.from(UserData.subjectCodeThisSemester);
                            _subjectCodeThisSemester.remove("전체");
                          }));
                      else{
                        setState(() {
                          UserData.id = "";
                          UserData.pw = "";
                          UserData.lastSyncInfo = null;
                        });
                      }                      
                    },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: 90,
                    decoration: BoxDecoration(color: Colors.blueAccent[100],borderRadius: BorderRadius.circular(10)),
                    child: Text(UserData.id == ""? "로그인" : "로그아웃", style: TextStyle(color: Colors.white))
                    )
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                        title: Text('완료된 일정 표시'),
                        subtitle: Text(
                          UserData.showFinished ? '완료된 일정을 달력에 표시합니다' : '완료된 일정을 달력에 표시하지 않습니다'
                        ),
                        trailing: Switch(
                          activeColor: Colors.blueAccent[100],
                          value: UserData.showFinished, 
                          onChanged: (value){
                            setState(() {
                              UserData.showFinished = value;
                            });
                          }),
                        isThreeLine: false
                    ),
                    ListTile(
                          title: Text('시작 요일'),
                          subtitle: Text('달력에서 한 주의 시작을 ${weekdayLocaleKR[UserData.firstDayOfWeek]}요일로 합니다'),
                          trailing:
                            DropdownButton(
                              underline: Container(
                                height: 2,
                                color: Colors.grey[350]),
                              value: UserData.firstDayOfWeek,
                              items: weekdayLocaleKR.entries.map<DropdownMenuItem<int>>(
                                (e) => DropdownMenuItem<int>(value: e.key, child: Text(e.value))).toList(),
                              onChanged: (newValue){
                                setState(() {
                                    UserData.firstDayOfWeek = newValue;
                                });
                              }),
                          isThreeLine: false
                    )
                  ],
                )
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                          title: Text('달력 종류'),
                          subtitle: UserData.calendarType == CalendarType.integrated ? Text('달력과 시간 별 일정을 한 페이지에 표시합니다') : Text('달력과 시간별 일정을 두 페이지로 나눠서 표시합니다'),
                          trailing:
                            DropdownButton(
                              underline: Container(
                                height: 2,
                                color: Colors.grey[350]),
                              value: UserData.calendarType,
                              items: [
                                  DropdownMenuItem<CalendarType>(value: CalendarType.split, child: Text('Type1')),
                                  DropdownMenuItem<CalendarType>(value: CalendarType.integrated, child: Text('Type2'))
                              ],
                              onChanged: (newValue){
                                setState(() {
                                    UserData.calendarType = newValue;
                                });
                              }),
                          isThreeLine: false
                    )
                  ],
                )
              ),
              _subjectCodeThisSemester.length != 0
              ? Card(
                child: expanded 
                ? ListTile(
                  subtitle: Column(children: _subjectCodeThisSemester.map<Widget>((String data) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(subjectCode[data]),
                          ),
                        ),
                        FlatButton(
                          onPressed: (){
                            showDialog(context: context,
                                    builder: (BuildContext context){
                                      return CalendarColorPicker(UserData.defaultColor[data] ?? 9);                      
                                    }).then((value) {
                                      if(value != null){
                                        setState((){ UserData.defaultColor[data] = value;});
                                        Database.defaultColorSave();
                                      }
                                    });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minWidth: 3,
                          child: Icon(Icons.lens,color: colorCollection[UserData.defaultColor[data] ?? 9]))
                      ],
                    );
                  }).toList()
                  ),
                )
                : TextButton(
                  onPressed: (){
                    setState(() {
                      expanded = true;
                    });
                  }, 
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(4.0,2.0,2.0,2.5),
                          title: Text("기본 색상 지정"),
                          subtitle: Text("Plato에서 새로운 일정이 추가 될 때의 각 과목 별 색깔을 지정합니다. 이미 추가된 일정에는 적용되지 않습니다.",style: TextStyle(fontSize: 13),)
                        )
                      ),
                      Icon(Icons.keyboard_arrow_down_sharp,size: 30,color: Colors.grey[600])
                    ],
                  )
                )
              )
              : Container(),
            ],
          ),
          )
        ],
      ));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  bool loginStatus = false;
  void checkIdPw(String data){
    if(idController.text != "" && pwController.text != "")
      setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding : const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        backgroundColor: Colors.grey[350],
        content: Container(
          alignment: Alignment.center,
          width: (colorCollection.length * 100).toDouble(),
          height: 150.0,
          //color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '아이디',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true ,
                    fillColor: Colors.white, 
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200])
                    )
                  ),
                  controller: idController,
                  onChanged: checkIdPw,
                )
              ),
              SizedBox(height: 10),
              Expanded(
                child: TextField(
                  obscureText : true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true ,
                    fillColor: Colors.white, 
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200])
                    )
                  ),
                  controller: pwController,
                  onChanged: checkIdPw,
                )
              ),
              TextButton(
                onPressed: idController.text == "" && pwController.text == "" && !loginStatus
                ? null
                :() async {
                  setState(() {
                    loginStatus = true;
                  });
                  UserData.id = idController.text;
                  UserData.pw = pwController.text;
                  await Plato.update(force: true);
                  Navigator.pop(context, true);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: 90,
                  decoration: BoxDecoration(
                    color: idController.text != "" && pwController.text != "" && !loginStatus
                      ? Colors.blue[900]
                      : Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                  child: Text("로그인", style: TextStyle(color: Colors.white)))
              ),
            ],
          )
          )

    );
  }
}