import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plato_calendar/Page/widget/Loading.dart';
import 'package:plato_calendar/Page/widget/LoginPage.dart';
import 'package:plato_calendar/Page/widget/adBanner.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../Data/etc.dart';
import '../Data/subjectCode.dart';
import '../Data/userData.dart';
import '../utility.dart';
import 'widget/appointmentEditor.dart';
import '../main.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Setting> with TickerProviderStateMixin {
  Set<String> _subjectCodeThisSemester =
      Set<String>.from(UserData.subjectCodeThisSemester);
  bool expanded = false;
  StreamSubscription<bool> listener;

  AnimationController _controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _subjectCodeThisSemester.remove("전체");
    listener = pnuStream.stream.listen((event) {
      if (event) setState(() {});
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    listener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('설정',
              style: TextStyle(
                  color: Colors.blueAccent[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).bottomAppBarColor
              : Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                        minLeadingWidth: 20,
                        contentPadding: const EdgeInsets.fromLTRB(16, 5, 5, 5),
                        leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.people_alt,
                                  color: Colors.blueAccent[100])
                            ]),
                        title:
                            Text(UserData.id == "" ? "Plato 계정" : UserData.id),
                        subtitle: Text(UserData.lastSyncInfo,
                            style: TextStyle(fontSize: 12)),
                        trailing: Container(
                          padding: EdgeInsets.all(0),
                          width: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  child: Loading(
                                      animation: animation,
                                      control: _controller)),
                              TextButton(
                                  onPressed: () {
                                    if (UserData.id == "")
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return LoginPage();
                                          }).then((value) => setState(() {
                                            _subjectCodeThisSemester =
                                                Set<String>.from(UserData
                                                    .subjectCodeThisSemester);
                                            _subjectCodeThisSemester
                                                .remove("전체");
                                          }));
                                    else {
                                      setState(() {
                                        UserData.id = "";
                                        UserData.pw = "";
                                        UserData.lastSyncInfo = null;
                                      });
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(0),
                                      width: 85,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          UserData.id == "" ? "로그인" : "로그아웃",
                                          style:
                                              TextStyle(color: Colors.white)))),
                            ],
                          ),
                        )),
                  ),
                  UserData.lastSyncInfo.contains("오류")
                      ? Card(
                          child: Column(
                          children: [
                            ListTile(
                                minLeadingWidth: 10,
                                leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.warning_amber_outlined,
                                          size: 18)
                                    ]),
                                title: Text(
                                  '오류 메세지가 나왔을 때',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                subtitle: Text(
                                    '- ID/PW 오류 : 로그아웃 버튼을 누르고 다시 시도해주세요.\n- 로그인 오류 : Plato 서버나 일시적인 네트워크 문제로, 인터넷 연결을 확인한 뒤에 앱을 재시작해보세요.\n- 동기화 오류 : 데이터 분석중 오류가 발생했습니다. 지속적인 오류 발생시 앱스토어를 통해 알려주세요.',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                                isThreeLine: false),
                          ],
                        ))
                      : Container(),
                  UserData.isSaveGoogleToken
                      ? Card(
                          child: ListTile(
                            title: Text('캘린더 앱과 동기화'),
                            subtitle: Text('Google 동기화 진행중'),
                            trailing: TextButton(
                                onPressed: () async {
                                  await UserData.googleCalendar
                                      .logOutGoogleAccount();
                                  setState(() {});
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(0),
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent[100],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("Logout",
                                        style:
                                            TextStyle(color: Colors.white)))),
                          ),
                        )
                      : Card(
                          child: ListTile(
                            leading: Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Text('캘린더 앱과 동기화')),
                            title: SignInButton(
                              Buttons.GoogleDark,
                              onPressed: () async {
                                if (UserData.id == "")
                                  showToastMessageCenter(
                                      '먼저 Plato 로그인을 진행해주세요.');
                                else {
                                  await UserData.googleCalendar
                                      .authUsingGoogleAccount();
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                  Card(
                      child: Column(
                    children: [
                      ListTile(
                          title: Text('완료된 일정 표시'),
                          subtitle: Text(UserData.showFinished
                              ? '완료된 일정을 달력에 표시합니다'
                              : '완료된 일정을 달력에 표시하지 않습니다. '),
                          trailing: Switch(
                              activeColor: Colors.blueAccent[100],
                              value: UserData.showFinished,
                              onChanged: (value) {
                                setState(() {
                                  UserData.showFinished = value;
                                });
                              }),
                          isThreeLine: false),
                      ListTile(
                          title: Text('달력 종류'),
                          subtitle:
                              UserData.calendarType == CalendarType.integrated
                                  ? Text('달력과 시간 별 일정을 한 페이지에 표시합니다')
                                  : Text('달력과 시간별 일정을 두 페이지로 나눠서 표시합니다'),
                          trailing: DropdownButton(
                              underline:
                                  Container(height: 2, color: Colors.grey[350]),
                              value: UserData.calendarType,
                              items: [
                                DropdownMenuItem<CalendarType>(
                                    value: CalendarType.split,
                                    child: Text('Type1')),
                                DropdownMenuItem<CalendarType>(
                                    value: CalendarType.integrated,
                                    child: Text('Type2'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  UserData.calendarType = newValue;
                                });
                              }),
                          isThreeLine: true),
                      ListTile(
                          title: Text('시작 요일'),
                          subtitle: Text(
                              '달력에서 한 주의 시작을 ${weekdayLocaleKR[UserData.firstDayOfWeek]}요일로 합니다'),
                          trailing: DropdownButton(
                              underline:
                                  Container(height: 2, color: Colors.grey[350]),
                              value: UserData.firstDayOfWeek,
                              items: weekdayLocaleKR.entries
                                  .map<DropdownMenuItem<int>>((e) =>
                                      DropdownMenuItem<int>(
                                          value: e.key, child: Text(e.value)))
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  UserData.firstDayOfWeek = newValue;
                                });
                              }),
                          isThreeLine: false)
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      ListTile(
                          title: Text('테마'),
                          subtitle: Text((() {
                            switch (UserData.themeMode) {
                              case ThemeMode.system:
                                return "시스템 디스플레이 설정에 따라\n라이트/다크모드로 자동 적용됩니다.";
                              case ThemeMode.light:
                                return "밝은 테마를 적용합니다.";
                              case ThemeMode.dark:
                                return "어두운 테마를 적용합니다.";
                            }
                          })()),
                          trailing: DropdownButton(
                              underline:
                                  Container(height: 2, color: Colors.grey[350]),
                              value: UserData.themeMode,
                              items: [
                                DropdownMenuItem<ThemeMode>(
                                    value: ThemeMode.system,
                                    child: Text('시스템 설정')),
                                DropdownMenuItem<ThemeMode>(
                                    value: ThemeMode.light,
                                    child: Text('라이트 모드')),
                                DropdownMenuItem<ThemeMode>(
                                    value: ThemeMode.dark,
                                    child: Text('다크 모드')),
                              ],
                              onChanged: (newValue) async {
                                setState(() {
                                  UserData.themeMode = newValue;
                                  showToastMessageCenter(
                                      "변경사항을 적용하기 위해 어플을 종료합니다.");
                                });
                                await Future.delayed(Duration(seconds: 2));
                                if (Platform.isAndroid)
                                  SystemNavigator.pop();
                                else if (Platform.isIOS) exit(0);
                              }),
                          isThreeLine: true)
                    ],
                  )),
                  _subjectCodeThisSemester.length != 0
                      ? Card(
                          child: expanded
                              ? ListTile(
                                  subtitle: Column(
                                      children: _subjectCodeThisSemester
                                          .map<Widget>((String data) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomLeft,
                                            child:
                                                Text(subjectCode[data] ?? data),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CalendarColorPicker(
                                                        UserData.defaultColor[
                                                                data] ??
                                                            18);
                                                  }).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    UserData.defaultColor[
                                                        data] = value;
                                                  });
                                                  UserData.writeDatabase
                                                      .defaultColorSave();
                                                }
                                              });
                                            },
                                            style: TextButton.styleFrom(
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: Icon(Icons.lens,
                                                color: colorCollection[UserData
                                                        .defaultColor[data] ??
                                                    18]))
                                      ],
                                    );
                                  }).toList()),
                                )
                              : TextButton(
                                  onPressed: () {
                                    setState(() {
                                      expanded = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      4.0, 2.0, 2.0, 2.5),
                                              title: Text("기본 색상 지정"),
                                              subtitle: Text(
                                                "Plato에서 새로운 일정이 추가 될 때의 각 과목 별 색깔을 지정합니다. 이미 추가된 일정에는 적용되지 않습니다.",
                                                style: TextStyle(fontSize: 13),
                                              ))),
                                      Icon(Icons.keyboard_arrow_down_sharp,
                                          size: 30, color: Colors.grey[600])
                                    ],
                                  )))
                      : Container(),
                  // Card(
                  //   child: ListTile(
                  //     title: Text('일정 내보내기'),
                  //     subtitle: Text('다른 캘린더 앱으로 내보내기'),
                  //     trailing: TextButton(
                  //           onPressed: (){
                  //             showToastMessageCenter("잠시 후 새창이 표시되면 캘린더 앱을 선택해주세요");
                  //             icsExport().then((value) {
                  //               if(!value)
                  //                 showToastMessageCenter("오류가 발생했습니다");
                  //             });
                  //           },
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             padding: EdgeInsets.all(0),
                  //             width: 70,
                  //             decoration: BoxDecoration(color: Colors.blueAccent[100],borderRadius: BorderRadius.circular(10)),
                  //             child: Text("Export", style: TextStyle(color: Colors.white))
                  //             )
                  //         ),
                  //   ),
                  // ),
                  Card(child: AdBanner(bannerLocation: 2)),
                ],
              ),
            )
          ],
        ));
  }
}
