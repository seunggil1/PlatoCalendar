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
  String _subject;

  @override
  void initState() {
    super.initState();
    _subjectCodeThisSemester.remove("전체");
    if(_subjectCodeThisSemester.length != 0)
      _subject = _subjectCodeThisSemester.first;
    else
      _subject = "None";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
        children: [
          Card(child: 
            ListTile(
              minLeadingWidth : 20,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people_alt,color: Colors.blue[200]),
                ],
              ),
              title: Text(UserData.id == ""? "Plato 계정" : UserData.id),
              subtitle: Text(UserData.lastSyncInfo),
              trailing: TextButton(
                onPressed: (){
                  if(UserData.id == "")
                    showDialog(context: context,
                      builder: (BuildContext context){
                        return LoginPage();                      
                      }).then((value) => setState((){
                        print(1);
                      }));
                  else{
                    setState(() {
                      UserData.id = "";
                      UserData.pw = "";
                    });
                  }                      
                },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                width: 90,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
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
          _subjectCodeThisSemester.length != 0
          ? Card(
            child: Row(
            children: [
              Text('    기본 색상 지정', style: TextStyle(fontSize: 16 )),
              Expanded(child: Container()),
              DropdownButton<String>(
                  value: _subject,
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
                      _subject = newValue;
                    });
                  },
                  items: _subjectCodeThisSemester
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: subjectCode[value])
                      )
                    );
                  }).toList(),
                ),
              FlatButton(
                onPressed: (){
                  showDialog(context: context,
                          builder: (BuildContext context){
                            return CalendarColorPicker(UserData.defaultColor[_subject] ?? 9);                      
                          }).then((value) {
                            if(value != null){
                              setState((){ UserData.defaultColor[_subject] = value;});
                              Database.defaultColorSave();
                            }
                          });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 3,
                child: Icon(Icons.lens,color: colorCollection[UserData.defaultColor[_subject] ?? 9]))
            ],
          ),
          )
          : Container(),
        ],
      ),
      )
    );
  }

}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

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
                  onPressed: idController.text == "" && pwController.text == ""
                  ? null
                  :() async {
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
                      color: idController.text != "" && pwController.text != ""
                        ? Colors.blue[900]
                        : Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                    child: Text("로그인", style: TextStyle(color: Colors.white)))
                )

            ],
          )
          )

    );
  }
}