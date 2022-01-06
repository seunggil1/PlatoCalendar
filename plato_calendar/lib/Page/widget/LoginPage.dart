import 'package:flutter/material.dart';

import '../../Data/etc.dart';
import '../../Data/userData.dart';
import '../../pnu/pnu.dart';

// 로그인 창
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
                style: TextStyle(color: Colors.black),
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
                style: TextStyle(color: Colors.black),
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
                await update(force: true);
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